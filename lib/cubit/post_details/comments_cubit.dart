import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepository _commentsRepository;
  StreamSubscription _streamSubscription;

  CommentsCubit({@required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository,
        super(CommentsStateInitial());

  void setPostId(int postId) {
    _streamSubscription =
    _commentsRepository.getComments(postId).listen((comments) {
      emit(CommentsLoaded(comments));
    })
      ..onError((e) => emit(CommentsLoadFailed()));
  }

  void loadComments() {
    _commentsRepository.loadComments();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
