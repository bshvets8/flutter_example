import 'package:flutter_cubit/domain/models/models.dart';

class CommentsState {}

class CommentsStateInitial extends CommentsState {}

class CommentsLoaded extends CommentsState {
  final List<CommentModel> comments;

  CommentsLoaded(this.comments);
}

class CommentsLoadFailed extends CommentsState {}