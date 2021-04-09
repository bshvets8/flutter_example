import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/cubit.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/widgets/widgets.dart';

import '../post_details/post_details.dart';
import '../post_details/post_details_page.dart';
import 'post_list_state.dart';
import 'posts_list_cubit.dart';
import 'package:flutter_cubit/utils/utils.dart';

import 'posts_list_selection_state.dart';

class PostsListPage extends StatefulWidget {
  static const routeName = "/cubit/posts";

  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  Completer _completer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PostsListCubit>(context).loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Page"),
      ),
      body: BlocConsumer<PostsListCubit, PostsListState>(
        builder: (context, state) {
          if (state is PostsListLoaded) {
            final isTablet = MediaQuery.of(context).isTablet();
            final postsList = _buildPostsList(
              context,
              posts: state.posts,
              itemTapCallback: (post) => isTablet
                  ? BlocProvider.of<PostsListSelectionCubit>(context)
                      .selectPost(post.id)
                  : Navigator.of(context)
                      .pushNamed(PostDetailsPage.routeName, arguments: post.id),
            );

            if (!isTablet)
              return postsList; // TODO: Visibility widget. Keep in tree

            return Row(
              children: [
                Flexible(
                  flex: 2,
                  child: postsList,
                ),
                Flexible(
                  child: BlocConsumer<PostsListSelectionCubit, PostsListSelectionState>(
                    builder: (context, state) {
                      if (state is PostsListPostSelected) {
                        return PostDetails(
                          // TODO: Visibility widget. Keep in tree.
                          postId: state.postId,
                        );
                      }

                      return Container(
                        alignment: Alignment.center,
                        child: Text('Select a Post'),
                      );
                    },
                    listener: (context, state) {
                      if (state is PostsListPostSelected) {
                        BlocProvider.of<PostDetailsCubit>(context)
                            .setPostId(state.postId);
                      }
                    },
                  ),
                  flex: 3,
                )
              ],
            );
          }

          if (state is PostsListLoadFailure) {
            return Container(
              alignment: Alignment.center,
              child: Text('Load Failure'),
            );
          }

          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {
          if (state is PostsListInitial) {
            BlocProvider.of<PostsListCubit>(context).loadPosts();
          }

          if (state is PostsListLoaded || state is PostsListLoadFailure) {
            _completer?.complete();
          }
        },
      ),
    );
  }

  Widget _buildPostsList(BuildContext context,
      {@required List<PostModel> posts,
      @required ItemTapCallback itemTapCallback}) {
    return RefreshIndicator(
      onRefresh: () async {
        _completer = Completer();
        BlocProvider.of<PostsListCubit>(context).loadPosts();
        return _completer.future;
      },
      child: PostsList(
        posts: posts,
        itemTapCallback: itemTapCallback,
      ),
    );
  }
}
