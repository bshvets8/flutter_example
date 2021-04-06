import 'package:flutter_cubit/domain/models.dart';

import 'web_api.dart';

import 'dart:convert';

class WebDataProvider {
  final WebAPI webApi;

  WebDataProvider(this.webApi);

  Future<List<PostModel>> getPosts() async {
    final response = await webApi.getPosts();
    final List list = jsonDecode(response.body);

    return list.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await webApi.getComments(postId);
    final List list = jsonDecode(response.body);

    return list.map((e) => CommentModel.fromJson(e)).toList();
  }
}
