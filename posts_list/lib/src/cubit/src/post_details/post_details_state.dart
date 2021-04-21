import 'package:posts_list/src/domain/models/models.dart';

class PostDetailsState {}

class PostDetailsInitial extends PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostLoaded extends PostDetailsState {
  final PostModel postModel;

  PostLoaded(this.postModel);
}

class PostLoadFailure extends PostDetailsState {}
