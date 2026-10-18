import 'package:flutter/material.dart';

import 'package:moviles_auth/components/primary_button.dart';
import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/home/ui/components/post_card.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';
import 'package:moviles_auth/theme/app_theme.dart';

/// The profile of the signed in user and their latest posts.
class ProfilePage extends StatelessWidget {
  final Profile profile;
  final List<Post> posts;
  final Function(Post) onLike;
  final Function() onSignOut;

  const ProfilePage({
    super.key,
    required this.profile,
    required this.posts,
    required this.onLike,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 88,
              height: 88,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                profile.fullName.isEmpty
                    ? '?'
                    : profile.fullName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@${profile.username}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          const Text(
            'Tus últimos posts',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          if (posts.isEmpty)
            const Text(
              'Aún no has publicado',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          for (final post in posts)
            PostCard(post: post, onLike: () => onLike(post)),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Cerrar sesión', onPressed: () => onSignOut()),
        ],
      ),
    );
  }
}
