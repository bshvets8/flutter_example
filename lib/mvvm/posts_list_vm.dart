import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models.dart';
import 'package:flutter_cubit/domain/repositories.dart';
import 'package:rxdart/rxdart.dart';

class PostsListVM {
  final PostsRepository _postsRepository;

  final BehaviorSubject<int> _selectedPostIdSubject = BehaviorSubject();

  PostsListVM({@required PostsRepository postsRepository})
      : _postsRepository = postsRepository;

  Stream<List<PostModel>> get posts => _postsRepository.posts();

  Stream<int> get selectedPostId => _selectedPostIdSubject.stream;

  void loadPosts() {
    _postsRepository.loadPosts();
  }

  void selectPost(int postId) => _selectedPostIdSubject.sink.add(postId);

  void dispose() {
    _selectedPostIdSubject.close();
  }
}
