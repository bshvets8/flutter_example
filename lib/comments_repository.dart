import 'dart:convert';

import 'package:flutter_cubit/comment_model.dart';
import 'package:flutter_cubit/post_model.dart';
import 'package:flutter_cubit/web_api.dart';

class CommentsRepository {
  final WebAPI _api;

  CommentsRepository(this._api);

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await _api.getComments(postId);
    final List list = jsonDecode(response.body);

    return list.map((e) => CommentModel.fromJson(e)).toList();
  }
}
