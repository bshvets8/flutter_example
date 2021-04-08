import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/domain/models/models.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:flutter_cubit/utils/utils.dart';
import 'package:flutter_cubit/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../post_details/post_details.dart';
import '../post_details/post_details_page.dart';
import 'posts_list_vm.dart';

class PostsListPage extends StatefulWidget {
  static const routeName = '/mvvm/posts';

  @override
  _PostsListPageState createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  PostsListVM _postsListVM;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _postsListVM = PostsListVM(
        postsRepository: RepositoryProvider.of<PostsRepository>(context));
    _postsListVM.loadPosts();

    if (!MediaQuery.of(context).isTablet()) {
      _postsListVM.selectedPostId.listen((postId) {
        final screenWidgetBuilder = (_) => Provider<PostsListVM>(
              create: (_) => _postsListVM,
              child: PostDetailsPage(),
            );

        final route = Platform.isIOS
            ? CupertinoPageRoute(builder: screenWidgetBuilder)
            : MaterialPageRoute(builder: screenWidgetBuilder);
        Navigator.of(context).push(route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVM Page"),
      ),
      body: StreamBuilder<List<PostModel>>(
        initialData: [],
        stream: _postsListVM.posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isTablet = MediaQuery.of(context).isTablet();
            final postsList = RefreshIndicator(
                onRefresh: () async {
                  _postsListVM.loadPosts();
                },
                child: PostsList(
                  posts: snapshot.data,
                  itemTapCallback: (postModel) =>
                      _postsListVM.selectPost(postModel.id),
                ));

            if (!isTablet) return postsList;

            return Row(
              children: [
                Flexible(
                  flex: 2,
                  child: postsList,
                ),
                Flexible(
                  child: StreamBuilder<int>(
                    stream: _postsListVM.selectedPostId,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Provider<PostsListVM>(
                          create: (context) => _postsListVM,
                          child: PostDetails(),
                        );
                      }
                      return Container(
                        alignment: Alignment.center,
                        child: Text('Select a Post'),
                      );
                    },
                  ),
                  flex: 3,
                )
              ],
            );
          }

          return Container(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
