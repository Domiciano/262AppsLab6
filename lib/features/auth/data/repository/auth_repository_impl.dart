import 'package:moviles_auth/features/auth/data/source/supabase_auth_data_source.dart';
import 'package:moviles_auth/features/auth/domain/entities/auth_user.dart';
import 'package:moviles_auth/features/auth/domain/repository/auth_repository.dart';

/// Fulfils AuthRepository by delegating on the Supabase data source.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDataSource _dataSource = SupabaseAuthDataSource();

  @override
  Future<AuthUser> signUp({required String email, required String password}) {
    return _dataSource.signUp(email: email, password: password);
  }

  @override
  Future<AuthUser> signIn({required String email, required String password}) {
    return _dataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() => _dataSource.signOut();
}
