import 'package:moviles_auth/features/auth/data/source/supabase_profile_data_source.dart';
import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/auth/domain/repository/profile_repository.dart';

/// Fulfils ProfileRepository by delegating on the Supabase data source.
class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseProfileDataSource _dataSource = SupabaseProfileDataSource();

  @override
  Future<void> createProfile(Profile profile) {
    return _dataSource.createProfile(profile);
  }

  @override
  Future<Profile> getProfile(String id) {
    return _dataSource.getProfile(id);
  }
}
