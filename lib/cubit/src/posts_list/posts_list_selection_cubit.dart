import 'package:bloc/bloc.dart';

import 'posts_list_selection_state.dart';

class PostsListSelectionCubit extends Cubit<PostsListSelectionState> {

  PostsListSelectionCubit() : super(PostsListNoPostSelected());

  void selectPost(int postId) {
    emit(PostsListPostSelected(postId));
  }
}