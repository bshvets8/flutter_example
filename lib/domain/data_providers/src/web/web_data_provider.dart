import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/models/src/user_model.dart';

abstract class WebDataProvider {
  Future<List<PostModel>> getPosts();

  Future<List<CommentModel>> getComments();

  Future<List<UserModel>> getUsers();

  void dispose();
}
