import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class PostsListVM {
  final PostsRepository _postsRepository;

  PostsListVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository;

  Stream<List<PostModel>> get posts => _postsRepository.posts();

  void loadPosts() {
    _postsRepository.loadPosts();
  }
}
