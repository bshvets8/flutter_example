import 'package:flutter_cubit/domain/models/models.dart';

abstract class PostsRepository {
  // REVIEW: Create base repository. add dispose
  // REVIEW: Rename to getPosts or get method
  // REVIEW: Add 'force' argument to invalidate data in db
  Stream<List<PostModel>> posts();

  Stream<PostModel> getPost(int postId);

  Future<void> loadPosts();

  void dispose();
}
