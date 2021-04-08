import 'package:flutter_cubit/domain/models/models.dart';

abstract class CommentsRepository {
  Stream<List<CommentModel>> comments();

  Stream<List<CommentModel>> getComments(int postId);

  void loadComments();
}