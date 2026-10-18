import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles_auth/features/auth/domain/repository/profile_repository.dart';

/// Creates the account and then saves its profile with the same id.
class SignUpUseCase {
  final AuthRepository _auth;
  final ProfileRepository _profiles;

  SignUpUseCase(this._auth, this._profiles);

  Future<Profile> call({
    required String username,
    required String fullName,
    required String email,
    required String password,
  }) async {
    final user = await _auth.signUp(email: email, password: password);
    final profile = Profile(
      id: user.id,
      username: username,
      fullName: fullName,
    );
    await _profiles.createProfile(profile);
    return profile;
  }
}
