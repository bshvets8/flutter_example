import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:posts_list_module/src/domain/models/models.dart';
import 'package:posts_list_module/src/domain/repositories/repositories.dart';

class CommentsListVM extends ChangeNotifier {
  final CommentsRepository _commentsRepository;

  bool _isInitCalled = false;

  StreamSubscription _streamSubscription;

  int _postId;

  List<CommentModel> _comments = [];
  bool _isInitializing = true;

  List<CommentModel> get comments => _comments;

  bool get isInitializing => _isInitializing;

  CommentsListVM({@required CommentsRepository commentsRepository}) : _commentsRepository = commentsRepository;

  void init({@required int postId}) {
    assert(!_isInitCalled, '$runtimeType was initialized more than once');
    _isInitCalled = true;

    _postId = postId;

    _streamSubscription = _commentsRepository.getComments(postId: _postId).listen((comments) {
      _isInitializing = false;
      _comments = comments;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
