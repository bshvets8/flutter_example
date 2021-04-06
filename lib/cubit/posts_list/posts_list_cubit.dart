import 'package:bloc/bloc.dart';
import 'package:flutter_cubit/domain/repositories.dart';

import 'post_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  final PostsRepository _postsRepository;

  PostsListCubit(this._postsRepository) : super(PostsListInitial());

  void loadPosts() async {
    try {
      final posts = await _postsRepository.getPosts();
      emit(PostsListLoaded(posts));
    } catch (_) {
      emit(PostsListLoadFailure());
    }
  }
}
