import 'package:moviles_auth/features/auth/domain/entities/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The only file that talks to Supabase Auth.
class SupabaseAuthDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return _toAppUser(response.user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return _toAppUser(response.user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }

  AppUser? currentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return AppUser(id: user.id, email: user.email ?? '');
  }

  AppUser _toAppUser(User? user) {
    if (user == null) throw Exception('Supabase no devolvió el usuario');
    return AppUser(id: user.id, email: user.email ?? '');
  }
}
