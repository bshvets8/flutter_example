import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class PostDetailsVM {
  final PostsRepository _postsRepository;

  final BehaviorSubject<PostModel> _postSubject = BehaviorSubject();

  StreamSubscription _postSubscription;

  PostDetailsVM({@required PostsRepository postsRepository})
      : _postsRepository = postsRepository;

  Stream<PostModel> get post => _postSubject.stream;

  void initWithPostId(int postId) {
    _postSubscription = _postsRepository.getPost(postId).listen((post) {
      _postSubject.sink.add(post);
    });
  }

  void dispose() {
    _postSubject.close();
    _postSubscription.cancel();
  }
}
