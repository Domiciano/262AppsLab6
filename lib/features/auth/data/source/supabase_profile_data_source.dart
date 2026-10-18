import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The only file that reads and writes the profiles table.
class SupabaseProfileDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createProfile(Profile profile) async {
    try {
      await _client.from('profiles').insert({
        'id': profile.id,
        'username': profile.username,
        'full_name': profile.fullName,
      });
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Profile> getProfile(String id) async {
    try {
      final row = await _client.from('profiles').select().eq('id', id).single();
      return Profile(
        id: row['id'] as String,
        username: row['username'] as String,
        fullName: row['full_name'] as String,
      );
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }
}
