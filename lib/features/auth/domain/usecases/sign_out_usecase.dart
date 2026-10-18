import 'package:moviles_auth/features/auth/data/repository/auth_repository_impl.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';

/// Closes the current session.
class SignOutUseCase {
  final AuthRepository _auth = AuthRepositoryImpl();

  Future<void> call() {
    return _auth.signOut();
  }
}
