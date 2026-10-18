import 'package:moviles_auth/features/auth/domain/entities/profile.dart';

enum RegisterStatus { initial, loading, success, failure }

/// Single state of the register screen; status says which moment it is.
class RegisterState {
  final RegisterStatus status;
  final Profile? profile;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.profile,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    Profile? profile,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'RegisterState(status: ${status.name}, error: $errorMessage)';
  }
}
