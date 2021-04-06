import 'package:bloc/bloc.dart';
import 'package:flutter_cubit/cubit/posts_state.dart';
import 'package:flutter_cubit/posts_repository.dart';

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
