import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class CommentsListVM extends ChangeNotifier {
  final CommentsRepository _commentsRepository;

  StreamSubscription _streamSubscription;

  int _postId;

  List<CommentModel> _comments = [];
  bool _isInitializing;

  List<CommentModel> get comments => _comments;

  bool get isInitializing => _isInitializing;

  CommentsListVM({@required CommentsRepository commentsRepository}) : _commentsRepository = commentsRepository;

  void init({@required int postId}) {
    _postId = postId;

    _isInitializing = true;
    _comments = [];
    notifyListeners();

    _streamSubscription?.cancel();
    _streamSubscription = _commentsRepository.getComments(_postId).listen((comments) {
      _isInitializing = false;
      _comments = comments;
      notifyListeners();
    });

    _loadComments();
  }

  void _loadComments() {
    _commentsRepository.loadComments();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
