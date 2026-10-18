/// Row of the profiles table: same id as the account, plus public data.
class Profile {
  final String id;
  final String username;
  final String fullName;

  const Profile({
    required this.id,
    required this.username,
    required this.fullName,
  });
}
