import 'package:flutter_cubit/domain/models.dart';

abstract class WebDataProvider {
  Future<List<PostModel>> getPosts();

  Future<List<CommentModel>> getComments();
}
