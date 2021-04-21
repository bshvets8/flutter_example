import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_list/src/widgets/src/user_title_widget.dart';

import 'comments_cubit.dart';
import 'comments_state.dart';
import 'post_details_cubit.dart';
import 'post_details_state.dart';

class PostDetailsWidget extends StatefulWidget {
  @override
  _PostDetailsWidgetState createState() => _PostDetailsWidgetState();
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        if (state is PostLoaded) {
          final postModel = state.postModel;
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: UserTitleWidget(username: 'some_user'),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  postModel.title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  postModel.body,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Expanded(child: _CommentsWidget())
            ],
          );
        }

        if (state is PostLoadFailure) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'Post Load Failed',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is PostDetailsLoading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          alignment: Alignment.center,
          child: Text(
            'Select a Post',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

class _CommentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Comments',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.black26),
          ),
        ),
        Expanded(
          child: BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
              if (state is CommentsLoaded) {
                return ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      state.comments[index].body,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }

              if (state is CommentsLoadFailed) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Comments Load Failed',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}
