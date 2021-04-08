abstract class PostsListSelectionState {}

class PostsListNoPostSelected extends PostsListSelectionState {}

class PostsListPostSelected extends PostsListSelectionState {
  final int postId;

  PostsListPostSelected(this.postId);
}
