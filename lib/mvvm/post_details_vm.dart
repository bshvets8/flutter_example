import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models.dart';
import 'package:flutter_cubit/domain/repositories.dart';
import 'package:rxdart/rxdart.dart';

class PostDetailsVM {
  final PostsRepository _postsRepository;
  final CommentsRepository _commentsRepository;

  final BehaviorSubject<PostModel> _postSubject = BehaviorSubject();
  final BehaviorSubject<List<CommentModel>> _commentsSubject =
      BehaviorSubject();

  StreamSubscription _postSubscription;
  StreamSubscription _commentsSubscription;

  PostDetailsVM(
      {@required PostsRepository postsRepository,
      @required CommentsRepository commentsRepository})
      : _postsRepository = postsRepository,
        _commentsRepository = commentsRepository;

  Stream<PostModel> get post => _postSubject.stream;

  Stream<List<CommentModel>> get comments => _commentsSubject.stream;

  void initWithPostId(int postId) {
    _postSubscription = _postsRepository.getPost(postId).listen((post) {
      _postSubject.sink.add(post);
    });

    _commentsSubscription =
        _commentsRepository.getComments(postId).listen((comments) {
      _commentsSubject.sink.add(comments);
    });
  }

  void dispose() {
    _postSubject.close();
    _commentsSubject.close();

    _postSubscription.cancel();
    _commentsSubscription.cancel();
  }
}
