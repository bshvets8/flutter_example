import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:flutter_cubit/utils/utils.dart';
import 'package:flutter_cubit/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../post_details/post_details_widget.dart';
import 'posts_list_vm.dart';

class PostsListPage extends StatelessWidget {
  static const routeName = '/mvvm/posts';

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).isTablet();
    return ChangeNotifierProxyProvider<PostsRepository, PostsListVM>(
      create: null,
      update: (context, postsRepository, previous) => PostsListVM(postsRepository: postsRepository)..init(),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: _buildPostsList(),
          ),
          Visibility(
              visible: isTablet,
              child: Container(
                width: 1,
                color: Colors.black12,
              )),
          Visibility(
            visible: isTablet,
            child: Flexible(
              child: Consumer<PostsListVM>(
                builder: (context, postsListVM, child) => PostDetailsWidget(postId: postsListVM.selectedPostId),
              ),
              flex: 3,
            ),
          ),
        ],
      ),
    );
  }


  // REVIEW: Try to create heavy widget with list. Check if lagging during scroll
  Widget _buildPostsList() {
    return Builder(
      builder: (context) => RefreshIndicator(
        onRefresh: () => Provider.of<PostsListVM>(context, listen: false).refreshList(),
        child: Consumer<PostsListVM>(
          builder: (context, postsListVM, child) {
            if (postsListVM.isInitializing) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }

            return PostsListWidget(
              posts: postsListVM.posts,
              itemTapCallback: (postModel) {
                // REVIEW: Do not reselect on same id
                // REVIEW: Use context.select
                // REVIEW: Use library for navigation
                // REVIEW: Try deeplinks. On start - open post
                postsListVM.selectPostId(postModel.id);

                if (!MediaQuery.of(context).isTablet()) {
                  Navigator.of(context).pushNamed(PostDetailsPage.routeName, arguments: postModel.id);
                }
              },
            );
          },
        ),
      ),
    );
  }
}