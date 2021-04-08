import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models.dart';
import 'package:flutter_cubit/domain/repositories.dart';
import 'package:rxdart/rxdart.dart';

class CommentsVM {
  final CommentsRepository _commentsRepository;

  final BehaviorSubject<List<CommentModel>> _commentsSubject =
      BehaviorSubject();

  StreamSubscription _commentsSubscription;

  CommentsVM({@required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository;


  Stream<List<CommentModel>> get comments => _commentsSubject.stream;

  void initWithPostId(int postId) {
    _commentsSubscription =
        _commentsRepository.getComments(postId).listen((comments) {
      _commentsSubject.sink.add(comments);
    });
  }

  void dispose() {
    _commentsSubject.close();
    _commentsSubscription.cancel();
  }
}
