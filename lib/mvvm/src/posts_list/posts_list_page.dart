import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:flutter_cubit/utils/utils.dart';
import 'package:flutter_cubit/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../post_details/post_details_widget.dart';
import 'posts_list_vm.dart';

class PostsListPage extends StatefulWidget {
  static const routeName = '/mvvm/posts';

  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  Completer _completer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PostsListVM>(context, listen: false).loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    final postsListVM = Provider.of<PostsListVM>(context, listen: false);

    return StreamBuilder<List<PostModel>>(
      initialData: [],
      stream: postsListVM.posts,
      builder: (context, snapshot) {
        if (_completer?.isCompleted == false) {
          _completer.complete();
        }

        if (snapshot.hasData) {
          final isTablet = MediaQuery.of(context).isTablet();
          final postsList = RefreshIndicator(
            onRefresh: () async {
              _completer = Completer();
              postsListVM.loadPosts();
              _completer.future;
            },
            child: PostsListWidget(
              posts: snapshot.data,
              itemTapCallback: (postModel) {
                Provider.of<PostDetailsVM>(context, listen: false).setPostId(postModel.id);
                Provider.of<CommentsVM>(context, listen: false).setPostId(postModel.id);

                if (!isTablet) {
                  Navigator.of(context).pushNamed(PostDetailsPage.routeName);
                }
              },
            ),
          );

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
              ),
            ],
          );
        }

        return Container(child: CircularProgressIndicator());
      },
    );
  }
}
