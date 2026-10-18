/// A post of the wall, with its author and its likes already resolved.
class Post {
  final String id;
  final String content;
  final DateTime createdAt;
  final String authorUsername;
  final String authorName;
  final int likeCount;
  final bool likedByMe;

  const Post({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.authorUsername,
    required this.authorName,
    required this.likeCount,
    required this.likedByMe,
  });

  Post copyWith({int? likeCount, bool? likedByMe}) {
    return Post(
      id: id,
      content: content,
      createdAt: createdAt,
      authorUsername: authorUsername,
      authorName: authorName,
      likeCount: likeCount ?? this.likeCount,
      likedByMe: likedByMe ?? this.likedByMe,
    );
  }

  @override
  String toString() {
    return 'Post($id, @$authorUsername, likes: $likeCount)';
  }
}
