/// Something the register screen asks the RegisterBloc to do.
abstract class RegisterEvent {}

/// The user submitted the sign up form.
class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String fullName;
  final String email;
  final String password;

  RegisterSubmitted({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'RegisterSubmitted(username: $username, email: $email)';
  }
}
