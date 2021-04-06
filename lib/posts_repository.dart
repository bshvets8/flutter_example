import 'dart:convert';

import 'package:flutter_cubit/post_model.dart';
import 'package:flutter_cubit/web_api.dart';

class PostsRepository {
  final WebAPI _api;

  PostsRepository(this._api);

  Future<List<PostModel>> getPosts() async {
    final response = await _api.getPosts();
    final List list = jsonDecode(response.body);

    return list.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<PostModel> getPost(int postId) async {
    final response = await _api.getPost(postId);
    final List list = jsonDecode(response.body);
    return PostModel.fromJson(list.first);
  }
}
