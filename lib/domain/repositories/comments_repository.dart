import 'package:flutter_cubit/domain/data_providers.dart';
import 'package:flutter_cubit/domain/models.dart';

class CommentsRepository {
  final WebDataProvider webDataProvider;

  CommentsRepository(this.webDataProvider);

  Future<List<CommentModel>> getComments(int postId) =>
      webDataProvider.getComments(postId);
}
