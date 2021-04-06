import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/comments_repository.dart';
import 'package:flutter_cubit/cubit/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepository _commentsRepository;
  final int _postId;

  CommentsCubit(
      {@required CommentsRepository commentsRepository, @required int postId})
      : _commentsRepository = commentsRepository,
        _postId = postId,
        super(CommentsStateInitial());

  void loadComments() async {
    try {
      emit(CommentsLoaded(await _commentsRepository.getComments(_postId)));
    } catch (_) {
      emit(CommentsLoadFailed());
    }
  }
}
