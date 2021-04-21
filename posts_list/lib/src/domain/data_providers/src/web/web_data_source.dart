import 'package:posts_list/src/domain/models/models.dart';
import 'package:posts_list/src/domain/models/src/user_model.dart';

abstract class WebDataSource {
  Future<List<PostModel>> getPosts();

  Future<List<CommentModel>> getComments();

  Future<List<UserModel>> getUsers();

  void dispose();
}
