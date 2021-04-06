import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostsRepository _postsRepository;
  final int _postId;

  PostDetailsCubit({
    @required PostsRepository postsRepository,
    @required int postId,
  })  : _postId = postId,
        _postsRepository = postsRepository,
        super(PostDetailsInitial());

  void loadPost() async {
    try {
      emit(PostLoaded(await _postsRepository.getPost(_postId)));
    } catch (_) {
      emit(PostLoadFailure());
    }
  }
}
