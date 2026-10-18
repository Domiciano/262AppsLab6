import 'package:flutter/material.dart';

import 'package:moviles_auth/features/home/ui/components/post_card.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';
import 'package:moviles_auth/theme/app_theme.dart';

/// The wall: every post, newest first, and the Mostrar más button.
class FeedPage extends StatelessWidget {
  final List<Post> posts;
  final bool hasMore;
  final bool isLoading;
  final Function() onLoadMore;
  final Function(Post) onLike;

  const FeedPage({
    super.key,
    required this.posts,
    required this.hasMore,
    required this.isLoading,
    required this.onLoadMore,
    required this.onLike,
  });

  Widget _footer() {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (!hasMore || posts.isEmpty) return const SizedBox.shrink();
    return Center(
      child: OutlinedButton(
        onPressed: () => onLoadMore(),
        child: const Text('Mostrar más'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty && !isLoading) {
      return const Center(
        child: Text(
          'Todavía no hay posts',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index == posts.length) return _footer();
        final post = posts[index];
        return PostCard(post: post, onLike: () => onLike(post));
      },
    );
  }
}
