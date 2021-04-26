import 'package:posts_list_module/src/domain/models/models.dart';

// DONE: Rename to more specific. (e.g. Database). Hold separate db for every module
abstract class DatabaseDataSource {
  Stream<List<PostModel>> getPosts();

  Stream<List<CommentModel>> getComments();

  Future<bool> get hasPosts;

  Future<bool> get hasComments;

  Future<void> insertPosts(List<PostModel> posts);

  Future<void> insertComments(List<CommentModel> posts);

  Future<void> deletePosts();

  Future<void> deleteComments();

  void dispose();
}
