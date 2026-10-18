import 'package:moviles_auth/features/auth/domain/entities/profile.dart';

enum LoginStatus { initial, loading, success, failure }

/// Single state of the login screen; status says which moment it is.
class LoginState {
  final LoginStatus status;
  final Profile? profile;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.profile,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    Profile? profile,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'LoginState(status: ${status.name}, error: $errorMessage)';
  }
}
