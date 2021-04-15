import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

class PostsListVM extends ChangeNotifier {
  final PostsRepository _postsRepository;

  StreamSubscription _streamSubscription;

  List<PostModel> _posts = [];
  bool _isInitializing = true;
  int _selectedPostId = -1;

  List<PostModel> get posts => _posts;

  String get errorMessage or message; // REVIEW: Handle error

  bool get isInitializing => _isInitializing;

  int get selectedPostId => _selectedPostId;

  PostsListVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository {

  }

  void init() {
    _streamSubscription?.cancel(); // REVIEW: Add assert for single call
    _streamSubscription = _postsRepository.posts().listen((posts) {
      _isInitializing = false;
      _posts = posts;
      notifyListeners();
    })..onError() // REVIEW: Handle error;

    _loadPosts(); // REVIEW: Remove and auto handle in repository
    // REVIEW: Highlight selected post on list. For table only
  }

  Future<void> refreshList() => _loadPosts();

  Future<void> _loadPosts() => _postsRepository.loadPosts();

  void selectPostId(int postId) {
    _selectedPostId = postId;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
// Review: Use Change Notifier. Discover Provider lib. Add init to VM

// Review: pass id through navigator arguments/constructor
// Review: Sqlite. Encrypted databases / Reactive interface. Use different approaches. In memory-database.
// Review: Repository is responsible only for preparing data.
// Review: Create separate viewmodel for separate screen.

// Review: Try to create base viewmodel and base widget to provide it.
// Review: Concrete widgets should listen to concrete properties.
// Review: Expose only constructor, init method, getters.
