import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostsRepository _postsRepository;
  final int _postId;
  StreamSubscription _streamSubscription;

  PostDetailsCubit({
    @required PostsRepository postsRepository,
    @required int postId,
  })  : _postId = postId,
        _postsRepository = postsRepository,
        super(PostDetailsInitial()) {
    _streamSubscription = _postsRepository.getPost(_postId).listen((post) {
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
