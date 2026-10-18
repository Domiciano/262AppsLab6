import 'package:moviles_auth/features/auth/domain/entities/profile.dart';

/// Contract for saving and reading the profile of an account.
abstract class ProfileRepository {
  Future<void> createProfile(Profile profile);
  Future<Profile> getProfile(String id);
}
