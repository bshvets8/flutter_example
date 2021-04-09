import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comments_cubit.dart';
import 'comments_state.dart';
import 'post_details_cubit.dart';
import 'post_details_state.dart';

// TODO: Rename to PostDetails"Widget".
class PostDetails extends StatefulWidget {
  final int postId;

  const PostDetails({Key key, @required this.postId}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PostDetailsCubit>(context).setPostId(widget.postId);
    BlocProvider.of<CommentsCubit>(context)
      ..setPostId(widget.postId)
      ..loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        if (state is PostLoaded) {
          final postModel = state.postModel;
          return Column(
            children: [
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

        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
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
