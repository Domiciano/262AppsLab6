import 'package:moviles_auth/features/auth/data/source/supabase_auth_data_source.dart';
import 'package:moviles_auth/features/auth/domain/entities/app_user.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';

/// Fulfils AuthRepository by delegating on the Supabase data source.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDataSource _dataSource = SupabaseAuthDataSource();

  @override
  Future<AppUser> signUp({required String email, required String password}) {
    return _dataSource.signUp(email: email, password: password);
  }

  @override
  Future<AppUser> signIn({required String email, required String password}) {
    return _dataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  @override
  AppUser? currentUser() {
    return _dataSource.currentUser();
  }
}
