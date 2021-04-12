import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class PostDetailsVM {
  final PostsRepository _postsRepository;

  final BehaviorSubject<PostModel> _postSubject = BehaviorSubject();
  final BehaviorSubject<bool> _isLoadingSubject = BehaviorSubject()..add(false);

  StreamSubscription _postSubscription;

  PostDetailsVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository;

  Stream<PostModel> get post => _postSubject.stream;

  Stream<bool> get isLoading => _isLoadingSubject.stream;

  void setPostId(int postId) {
    _isLoadingSubject.add(true);
    _postSubscription = _postsRepository.getPost(postId).listen((post) {
      _postSubject.sink.add(post);
      _isLoadingSubject.add(false);
    });
  }

  void dispose() {
    _isLoadingSubject.close();
    _postSubject.close();
    _postSubscription.cancel();
  }
}
