import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

import 'post_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  final PostsRepository _postsRepository;
  StreamSubscription _streamSubscription;

  PostsListCubit({PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(PostsListInitial()) {
    _streamSubscription = _postsRepository
        .getPosts()
        .listen((posts) => emit(PostsListLoaded(posts)))
          ..onError((e) => emit(PostsListLoadFailure()));
  }

  void loadPosts() {
    _postsRepository.getPosts(forceFetch: true);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
