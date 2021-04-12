import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostsRepository _postsRepository;

  PostDetailsCubit({@required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(PostDetailsInitial());

  void setPostId(int postId) {
    emit(PostDetailsLoading());
    _postsRepository.getPost(postId).listen((post) {
      emit(PostLoaded(post));
    })
      ..onError((e) => {PostLoadFailure()});
  }
}
