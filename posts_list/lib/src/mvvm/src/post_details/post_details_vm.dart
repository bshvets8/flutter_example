import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:posts_list/src/domain/models/models.dart';
import 'package:posts_list/src/domain/repositories/repositories.dart';

class PostDetailsVM extends ChangeNotifier {
  final PostsRepository _postsRepository;

  int _postId;

  bool _isInitializing = false;
  PostModel _post;

  bool get isInitializing => _isInitializing;

  int get postId => _postId;

  bool get isPostSelected => _post != null;

  String get postTitle => _post.title;

  String get postBody => _post.body;

  StreamSubscription _streamSubscription;

  PostDetailsVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository;

  void init({@required int postId}) {
    _postId = postId;

    _isInitializing = true;
    _post = null;
    _streamSubscription?.cancel();

    notifyListeners();

    _streamSubscription = _postsRepository.getPost(_postId).listen((postModel) {
      _isInitializing = false;
      _post = postModel;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
