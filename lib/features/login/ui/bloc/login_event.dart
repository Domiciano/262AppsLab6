/// Something the login screen asks the LoginBloc to do.
abstract class LoginEvent {}

/// The user submitted the sign in form.
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});

  @override
  String toString() {
    return 'LoginSubmitted(email: $email)';
  }
}
