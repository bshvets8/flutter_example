import 'package:flutter_cubit/domain/models/models.dart';

abstract class PostsRepository {
  Stream<List<PostModel>> posts();

  Stream<PostModel> getPost(int postId);

  void loadPosts();

  void dispose();
}
