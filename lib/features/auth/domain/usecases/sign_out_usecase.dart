import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';

/// Closes the current session.
class SignOutUseCase {
  final AuthRepository _auth;

  SignOutUseCase(this._auth);

  Future<void> call() => _auth.signOut();
}
