import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/post_details.dart';
import 'package:flutter_cubit/cubit/posts_list_cubit.dart';
import 'package:flutter_cubit/cubit/posts_state.dart';

import '../posts_list.dart';

class PostsListPage extends StatefulWidget {
  static const routeName = "/posts";

  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  Completer _completer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Page"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _completer = Completer();
          BlocProvider.of<PostsListCubit>(context).loadPosts();
          return _completer.future;
        },
        child: BlocConsumer<PostsListCubit, PostsListState>(
          builder: (context, state) {
            if (state is PostsListLoaded) {
              return PostsList(
                posts: state.posts,
                itemTapCallback: (post) => Navigator.of(context)
                    .pushNamed(PostDetails.routeName, arguments: post.id),
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
      ),
    );
  }
}
