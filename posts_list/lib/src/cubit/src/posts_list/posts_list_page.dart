import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_list/src/domain/models/models.dart';
import 'package:posts_list/src/widgets/widgets.dart';

import '../post_details/post_details_widget.dart';
import '../post_details/post_details_page.dart';
import '../post_details/post_details_cubit.dart';
import '../post_details/comments_cubit.dart';
import 'post_list_state.dart';
import 'posts_list_cubit.dart';
import 'package:posts_list/src/utils/utils.dart';

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
    return BlocConsumer<PostsListCubit, PostsListState>(
      builder: (context, state) {
        if (state is PostsListLoaded) {
          final isTablet = MediaQuery.of(context).isTablet();
          final postsList = _buildPostsList(context, posts: state.posts, itemTapCallback: (post) {
            BlocProvider.of<PostDetailsCubit>(context).setPostId(post.id);
            BlocProvider.of<CommentsCubit>(context).setPostId(post.id);
            if (!isTablet) {
              Navigator.of(context).pushNamed(PostDetailsPage.routeName);
            }
          });

          return Row(
            children: [
              Flexible(
                flex: 2,
                child: postsList,
              ),
              Visibility(
                visible: isTablet,
                child: Flexible(
                  child: PostDetailsWidget(),
                  flex: 3,
                ),
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
        if (state is PostsListLoaded || state is PostsListLoadFailure) {
          _completer?.complete();
        }
      },
    );
  }

  Widget _buildPostsList(BuildContext context,
      {@required List<PostModel> posts, @required ItemTapCallback itemTapCallback}) {
    return RefreshIndicator(
      onRefresh: () async {
        _completer = Completer();
        BlocProvider.of<PostsListCubit>(context).loadPosts();
        return _completer.future;
      },
      child: PostsListWidget(
        posts: posts,
        itemTapCallback: itemTapCallback,
      ),
    );
  }
}
