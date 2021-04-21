import 'package:posts_list/src/domain/models/models.dart';
import 'package:posts_list/src/domain/models/src/user_model.dart';
import 'dart:convert';
import 'web_api.dart';
import 'web_data_source.dart';

class JsonPlaceholderWebDataSource extends WebDataSource {
  final WebAPI webApi;

  JsonPlaceholderWebDataSource(this.webApi);

  Future<List<PostModel>> getPosts() async {
    final response = await webApi.getPosts();
    final List list = jsonDecode(response.body);

    return list.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<List<CommentModel>> getComments() async {
    final response = await webApi.getComments();
    final List list = jsonDecode(response.body);

    return list.map((e) => CommentModel.fromJson(e)).toList();
  }

  Future<List<UserModel>> getUsers() async {
    final response = await webApi.getComments();
    final List list = jsonDecode(response.body);

    return list.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  void dispose() {
    webApi.dispose();
  }
}
