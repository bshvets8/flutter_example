import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'file:///D:/flutter_cubit/flutter_cubit/lib/mvvm/src/post_details/comments_vm.dart';
import 'file:///D:/flutter_cubit/flutter_cubit/lib/mvvm/src/post_details/post_details_vm.dart';

class PostDetails extends StatefulWidget {
  final int _postId;

  const PostDetails({Key key, @required int postId})
      : _postId = postId,
        super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  PostDetailsVM _postDetailsVM;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postDetailsVM = PostDetailsVM(
        postsRepository: RepositoryProvider.of<PostsRepository>(context));

    _postDetailsVM.initWithPostId(widget._postId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostModel>(
      stream: _postDetailsVM.post,
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
                child: _CommentsWidget(
                  postId: widget._postId,
                ),
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
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _CommentsWidget extends StatefulWidget {
  final int _postId;

  const _CommentsWidget({Key key, @required int postId})
      : _postId = postId,
        super(key: key);

  @override
  __CommentsWidgetState createState() => __CommentsWidgetState();
}

class __CommentsWidgetState extends State<_CommentsWidget> {
  CommentsVM _commentsVM;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentsVM = CommentsVM(
        commentsRepository: RepositoryProvider.of<CommentsRepository>(context));
    _commentsVM.initWithPostId(widget._postId);
  }

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
          child: StreamBuilder<List<CommentModel>>(
            stream: _commentsVM.comments,
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
