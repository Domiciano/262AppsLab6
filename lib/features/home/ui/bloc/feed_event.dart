import 'package:moviles_auth/features/posts/domain/entities/post.dart';

/// Something the home screen asks the FeedBloc to do.
abstract class FeedEvent {}

/// Load the wall from page 0, and the latest posts of the user.
class FeedStarted extends FeedEvent {
  @override
  String toString() => 'FeedStarted()';
}

/// Load the next page of the wall.
class FeedMoreRequested extends FeedEvent {
  @override
  String toString() => 'FeedMoreRequested()';
}

/// The user touched the heart of a post.
class FeedLikeToggled extends FeedEvent {
  final Post post;

  FeedLikeToggled(this.post);

  @override
  String toString() => 'FeedLikeToggled($post)';
}
