import 'package:flutter_cubit/comment_model.dart';
import 'package:flutter_cubit/post_model.dart';

class PostDetailsState {}

class PostDetailsInitial extends PostDetailsState {}

class PostLoaded extends PostDetailsState {
  final PostModel postModel;

  PostLoaded(this.postModel);
}

class PostLoadFailure extends PostDetailsState {}
