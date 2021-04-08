import 'package:flutter_cubit/domain/models/models.dart';

abstract class LocalDataProvider {
  Stream<List<PostModel>> posts();

  Stream<List<CommentModel>> comments();

  void setPosts(List<PostModel> posts);

  void setComments(List<CommentModel> posts);

  void dispose();
}
