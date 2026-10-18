/// Account returned by Supabase Auth: its id and its email.
class AuthUser {
  final String id;
  final String email;

  const AuthUser({required this.id, required this.email});
}
