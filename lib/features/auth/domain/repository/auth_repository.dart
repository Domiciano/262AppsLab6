import 'package:moviles_auth/features/auth/domain/entities/app_user.dart';

/// Contract for creating accounts, opening or closing a session and reading it.
abstract class AuthRepository {
  Future<AppUser> signUp({required String email, required String password});
  Future<AppUser> signIn({required String email, required String password});
  Future<void> signOut();
  AppUser? currentUser();
}
