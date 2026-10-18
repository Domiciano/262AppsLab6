import 'package:moviles_auth/features/auth/domain/entities/auth_user.dart';

/// Contract for creating accounts, opening or closing a session and reading it.
abstract class AuthRepository {
  Future<AuthUser> signUp({required String email, required String password});
  Future<AuthUser> signIn({required String email, required String password});
  Future<void> signOut();
  AuthUser? currentUser();
}
