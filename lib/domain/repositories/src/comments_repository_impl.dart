import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final WebDataProvider webDataProvider;
  final LocalDataProvider localDataProvider;

  CommentsRepositoryImpl(
      {@required this.webDataProvider, @required this.localDataProvider});

  Stream<List<CommentModel>> comments() => localDataProvider.comments();

  Stream<List<CommentModel>> getComments(int postId) => comments().map(
      (list) => list.where((element) => element.postId == postId).toList());

  void loadComments() async {
    final comments = await webDataProvider.getComments();
    localDataProvider.setComments(comments);
  }
}
