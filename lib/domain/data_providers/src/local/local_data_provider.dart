import 'package:flutter_cubit/domain/models/models.dart';

// REVIEW: Rename to more specific. (e.g. Database). Hold separate db for every module
abstract class LocalDataProvider {
  Stream<List<PostModel>> posts();

  Stream<List<CommentModel>> comments();

  void setPosts(List<PostModel> posts);

  void setComments(List<CommentModel> posts);

  void dispose();
}
