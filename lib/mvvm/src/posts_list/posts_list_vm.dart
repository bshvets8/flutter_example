import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

// REVIEW: Extract to module. Expose only starting widget. Finish sequence from e.g. post details, pass some argument back.
//REVIEW: App bar on main page.
class PostsListVM extends ChangeNotifier {
  static const _defaultSelectedPostId = -1;

  bool _isInitCalled = false;

  final PostsRepository _postsRepository;

  StreamSubscription _streamSubscription;

  List<PostModel> _posts = [];
  bool _isInitializing = true;
  int _selectedPostId = _defaultSelectedPostId;

  List<PostModel> get posts => _posts;

  String _errorMessage;

  String get errorMessage => _errorMessage;

  bool get isInitializing => _isInitializing;

  int get selectedPostId => _selectedPostId;

  PostsListVM({@required PostsRepository postsRepository}) : _postsRepository = postsRepository;

  void init() {
    assert(!_isInitCalled, '$runtimeType was initialized more than once'); // DONE: Add assert for single call
    _isInitCalled = true;

    _loadPosts();

    // REVIEW: Highlight selected post on list. For tablet only
  }

  Future<void> refreshList() {
    return _loadPosts(forceRefresh: true);
  }

  void selectPostId(int postId) {
    _selectedPostId = postId;
    notifyListeners();
  }

  Future<void> _loadPosts({bool forceRefresh = false}) {
    Completer completer = Completer();
    _streamSubscription?.cancel();
    _streamSubscription = _postsRepository.getPosts(forceFetch: forceRefresh).listen((posts) {
      _isInitializing = false;
      _errorMessage = null;
      _posts = posts;

      if (!completer.isCompleted)
        completer.complete();

      notifyListeners();
    })..onError((error) {
      _isInitializing = false;
      _errorMessage = error.toString();

      if (!completer.isCompleted)
        completer.complete();

      notifyListeners();
    });

    return completer.future;
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
// Done: Use Change Notifier. Discover Provider lib. Add init to VM

// Done: pass id through navigator arguments/constructor
// Review: Sqlite. Encrypted databases / Reactive interface. Use different approaches. In memory-database.
// Review: Repository is responsible only for preparing data.
// DONE: Create separate viewmodel for separate screen.

// Done: Try to create base viewmodel and base widget to provide it.
// Done: Concrete widgets should listen to concrete properties.
// Done: Expose only constructor, init method, getters.
