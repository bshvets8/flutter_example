import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/data_providers.dart';
import 'package:flutter_cubit/domain/models.dart';

// TODO: Add Abstraction, Separate Caching
class PostsRepository {
  final WebDataProvider webDataProvider;
  final LocalDataProvider localDataProvider;

  PostsRepository({@required this.webDataProvider, this.localDataProvider});

  Stream<List<PostModel>> posts() => localDataProvider.posts();

  Stream<PostModel> getPost(int postId) => posts()
      .map((posts) => posts.firstWhere((element) => element.id == postId));

  void loadPosts() async {
    final posts = await webDataProvider.getPosts();
    localDataProvider.setPosts(posts);
  }
}
