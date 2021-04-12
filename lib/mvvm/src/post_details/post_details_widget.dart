import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:provider/provider.dart';

import 'comments_vm.dart';
import 'post_details_vm.dart';

class PostDetailsWidget extends StatefulWidget {
  @override
  _PostDetailsWidgetState createState() => _PostDetailsWidgetState();
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final postDetailsVM = Provider.of<PostDetailsVM>(context, listen: false);

    return StreamBuilder<bool>(
      stream: postDetailsVM.isLoading,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder<PostModel>(
          stream: postDetailsVM.post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final postModel = snapshot.data;
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
                  Expanded(
                    child: _CommentsWidget(),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
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
              child: Text(
                'Select a Post',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );
  }
}

class _CommentsWidget extends StatefulWidget {
  @override
  __CommentsWidgetState createState() => __CommentsWidgetState();
}

class __CommentsWidgetState extends State<_CommentsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CommentsVM>(context, listen: false).loadComments();
  }

  @override
  Widget build(BuildContext context) {
    final commentsVM = Provider.of<CommentsVM>(context, listen: false);

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
          child: StreamBuilder<List<CommentModel>>(
            stream: commentsVM.comments,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final comments = snapshot.data;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      comments[index].body,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
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
