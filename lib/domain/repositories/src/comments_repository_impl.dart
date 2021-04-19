import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final WebDataSource webDataSource;
  final DatabaseDataSource databaseDataSource;

  CommentsRepositoryImpl({@required this.webDataSource, @required this.databaseDataSource});

  @override
  Stream<List<CommentModel>> getComments({int postId, bool forceFetch = false}) async* {
    if (forceFetch || !await databaseDataSource.hasComments) {
      await _loadComments();
    }

    yield* databaseDataSource
        .getComments()
        .map((list) => postId == null ? list : list.where((element) => element.postId == postId).toList());
  }

  Future<void> _loadComments() async {
    final comments = await webDataSource.getComments();
    await databaseDataSource.deleteComments();
    await databaseDataSource.insertComments(comments);
  }

  @override
  void dispose() {}
}
