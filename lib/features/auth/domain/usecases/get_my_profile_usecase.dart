import 'package:moviles_auth/features/auth/data/repository/auth_repository_impl.dart';
import 'package:moviles_auth/features/auth/data/repository/profile_repository_impl.dart';
import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles_auth/features/auth/domain/repository/profile_repository.dart';

/// Reads the user saved in the local session and brings their profile.
class GetMyProfileUseCase {
  final AuthRepository _auth = AuthRepositoryImpl();
  final ProfileRepository _profiles = ProfileRepositoryImpl();

  Future<Profile> call() async {
    final user = _auth.currentUser();
    if (user == null) throw Exception('No hay una sesión iniciada');
    return _profiles.getProfile(user.id);
  }
}
