import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepository _commentsRepository;
  final int _postId;
  StreamSubscription _streamSubscription;

  CommentsCubit(
      {@required CommentsRepository commentsRepository, @required int postId})
      : _commentsRepository = commentsRepository,
        _postId = postId,
        super(CommentsStateInitial()) {
    _streamSubscription =
        _commentsRepository.getComments(_postId).listen((comments) {
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
