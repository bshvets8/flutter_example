import 'package:posts_list/src/domain/models/models.dart';

abstract class PostsListState {}

class PostsListInitial extends PostsListState {}

class PostsListLoaded extends PostsListState {
  final List<PostModel> posts;

  PostsListLoaded(this.posts);
}

class PostsListLoadFailure extends PostsListState {}
