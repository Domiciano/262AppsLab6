import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles_auth/features/auth/domain/repository/profile_repository.dart';

/// Opens a session and then reads the profile of that account.
class SignInUseCase {
  final AuthRepository _auth;
  final ProfileRepository _profiles;

  SignInUseCase(this._auth, this._profiles);

  Future<Profile> call({
    required String email,
    required String password,
  }) async {
    final user = await _auth.signIn(email: email, password: password);
    return _profiles.getProfile(user.id);
  }
}
