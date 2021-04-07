import 'dart:async';

import 'package:flutter_cubit/domain/data_providers.dart';
import 'package:flutter_cubit/domain/models.dart';
import 'package:rxdart/rxdart.dart';

class InMemoryDataProvider extends LocalDataProvider {
  final List<PostModel> _postsList = [];
  final List<CommentModel> _commentsList = [];

  final BehaviorSubject<List<PostModel>> _postsSubject = BehaviorSubject();
  final BehaviorSubject<List<CommentModel>> _commentsSubject =
      BehaviorSubject();

  Stream<List<PostModel>> posts() {
    return _postsSubject.stream;
  }

  Stream<List<CommentModel>> comments() {
    return _commentsSubject.stream;
  }

  void setPosts(List<PostModel> posts) {
    _postsList
      ..clear()
      ..addAll(posts);

    _postsSubject.sink.add(_postsList);
  }

  void setComments(List<CommentModel> comments) {
    _commentsList
      ..clear()
      ..addAll(comments);

    _commentsSubject.sink.add(_commentsList);
  }

  void dispose() {
    _postsSubject.close();
    _commentsSubject.close();
  }
}
