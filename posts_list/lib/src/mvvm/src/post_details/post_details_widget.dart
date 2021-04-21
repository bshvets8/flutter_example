import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_list/src/widgets/src/sub_navigation_scope.dart';
import 'package:provider/provider.dart';

import '../posts_factory.dart';
import 'comments_list_widget.dart';
import 'post_details_vm.dart';

class PostDetailsWidget extends StatelessWidget {
  final int postId;

  const PostDetailsWidget({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DONE: Try to change to simple ChangeNotifierProvider
    // DONE: Create instance in "create". Investigate if it helps
    // REVIEW: Check if VM is persisted between rebuilds
    return ChangeNotifierProvider<PostDetailsVM>(
      create: (context) =>
          PostDetailsVM(postsRepository: Provider.of<PostsModuleFactory>(context, listen: false).getPostsRepository())
            ..init(postId: postId),
      child: Consumer<PostDetailsVM>(
        builder: (context, postDetailsVM, child) {
          if (postDetailsVM.isInitializing) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          if (!postDetailsVM.isPostSelected) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Select a Post',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => SubNavigationScope.of(context).finish('YESS!!!'),
                      child: Text('Pop with YES'),
                    ),
                    ElevatedButton(
                      onPressed: () => SubNavigationScope.of(context).finish('NO((('),
                      child: Text('Pop with NO'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              postDetailsVM.postTitle,
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              postDetailsVM.postBody,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CommentsWidget(postId: postDetailsVM.postId),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
