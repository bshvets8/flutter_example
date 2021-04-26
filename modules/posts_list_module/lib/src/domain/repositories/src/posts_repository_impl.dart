import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:posts_list_module/src/domain/data_providers/data_sources.dart';
import 'package:posts_list_module/src/domain/models/models.dart';

import 'posts_repository.dart';

class PostsRepositoryImpl extends PostsRepository {
  final WebDataSource webDataSource;
  final DatabaseDataSource databaseDataSource;

  PostsRepositoryImpl({@required this.webDataSource, this.databaseDataSource});

  @override
  Stream<List<PostModel>> getPosts({bool forceFetch = false}) async* {
    if (forceFetch || !await databaseDataSource.hasPosts) {
      await _loadPosts();
    }

    yield* databaseDataSource.getPosts();
  }

  @override
  Stream<PostModel> getPost(int postId) =>
      getPosts().map((posts) => posts.firstWhere((element) => element.id == postId, orElse: () => null));

  Future<void> _loadPosts() async {
    final posts = await webDataSource.getPosts();
    await databaseDataSource.deletePosts();
    await databaseDataSource.insertPosts(posts);
  }

  @override
  void dispose() {}
}
