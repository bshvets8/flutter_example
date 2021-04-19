import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';

import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepository _commentsRepository;

  CommentsCubit({@required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository,
        super(CommentsStateInitial());

  void setPostId(int postId) {
    _commentsRepository.getComments(postId: postId).listen((comments) {
      emit(CommentsLoaded(comments));
    })
      ..onError((e) => emit(CommentsLoadFailed()));
  }
}
