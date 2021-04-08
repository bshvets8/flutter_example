import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostsRepository _postsRepository;
  StreamSubscription _streamSubscription;

  PostDetailsCubit({@required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(PostDetailsInitial());

  void setPostId(int postId) {
    _streamSubscription = _postsRepository.getPost(postId).listen((post) {
      emit(PostLoaded(post));
    })
      ..onError((e) => {PostLoadFailure()});
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
