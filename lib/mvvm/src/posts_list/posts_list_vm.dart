import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class PostsListVM {
  final PostsRepository _postsRepository;

  PostsListVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository;

  Stream<List<PostModel>> get posts => _postsRepository.posts();

  // Review: Make private
  // Review: pass id through arguments/constructor
  // Review: Sqlite. Encrypted databases / Reactive interface. Use different approaches. In memory-database.\

  // Review: Try to create base viewmodel and base widget to provide it.
  // Review: Concrete widgets should listen to concrete properties.
  // Review: Expose only constructor, init method, getters.
  void loadPosts() {
    _postsRepository.loadPosts();
  }
}
