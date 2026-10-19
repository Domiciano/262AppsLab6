/// Account returned by Supabase Auth: its id and its email.
class AppUser {
  final String id;
  final String email;

  const AppUser({required this.id, required this.email});
}
