import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:provider/provider.dart';

import 'comments_list_widget.dart';
import 'post_details_vm.dart';

class PostDetailsWidget extends StatelessWidget {
  final int postId;

  const PostDetailsWidget({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<PostsRepository, PostDetailsVM>(
      create: null,
      update: (context, postsRepository, previous) =>
          PostDetailsVM(postsRepository: postsRepository)..init(postId: postId),
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
