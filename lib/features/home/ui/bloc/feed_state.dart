import 'package:moviles_auth/features/posts/domain/entities/post.dart';

enum FeedStatus { initial, loading, success, failure }

/// Single state of the wall and of the latest posts of the user.
class FeedState {
  final FeedStatus status;
  final List<Post> posts;
  final List<Post> myPosts;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const FeedState({
    this.status = FeedStatus.initial,
    this.posts = const [],
    this.myPosts = const [],
    this.page = 0,
    this.hasMore = true,
    this.errorMessage,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<Post>? posts,
    List<Post>? myPosts,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return FeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      myPosts: myPosts ?? this.myPosts,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'FeedState(status: ${status.name}, posts: ${posts.length}, '
        'myPosts: ${myPosts.length}, page: $page, hasMore: $hasMore, '
        'error: $errorMessage)';
  }
}
