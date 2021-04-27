import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_list_module/src/mvvm/src/posts_factory.dart';
import 'package:posts_list_module/src/utils/utils.dart';
import 'package:posts_list_module/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../post_details/post_details_page.dart';
import '../post_details/post_details_widget.dart';
import 'posts_list_vm.dart';

class PostsListPage extends StatelessWidget {
  static const routeName = '/mvvm/posts';

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).isTablet();
    return ColoredBox(
      color: Colors.white,
      child: ChangeNotifierProvider<PostsListVM>(
        create: (context) =>
            PostsListVM(postsRepository: Provider.of<PostsModuleFactory>(context, listen: false).getPostsRepository())
              ..init(),
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
              ),
            ),
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
              selectedPostId: MediaQuery.of(context).isTablet() ? postsListVM.selectedPostId : -1,
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
