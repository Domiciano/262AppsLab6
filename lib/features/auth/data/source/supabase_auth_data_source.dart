import 'package:moviles_auth/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

/// The only file that talks to Supabase Auth.
class SupabaseAuthDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return _toAuthUser(response.user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return _toAuthUser(response.user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }

  AuthUser? currentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return AuthUser(id: user.id, email: user.email ?? '');
  }

  AuthUser _toAuthUser(User? user) {
    if (user == null) throw Exception('Supabase no devolvió el usuario');
    return AuthUser(id: user.id, email: user.email ?? '');
  }
}
