import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/models/models.dart';

import 'posts_repository.dart';

class PostsRepositoryImpl extends PostsRepository {
  final WebDataProvider webDataProvider;
  final LocalDataProvider localDataProvider;

  PostsRepositoryImpl({@required this.webDataProvider, this.localDataProvider});

  Stream<List<PostModel>> posts() => localDataProvider.posts();

  Stream<PostModel> getPost(int postId) =>
      posts().map((posts) => posts.firstWhere((element) => element.id == postId, orElse: () => null));

  Future<void> loadPosts() async {
    final posts = await webDataProvider.getPosts();
    localDataProvider.setPosts(posts);
  }

  void dispose() {
    webDataProvider.dispose();
  }
}
