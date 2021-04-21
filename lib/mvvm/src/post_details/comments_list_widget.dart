import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:provider/provider.dart';

import '../posts_factory.dart';

class CommentsWidget extends StatelessWidget {
  final int postId;

  const CommentsWidget({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentsListVM>(
      create: (context) => CommentsListVM(
          commentsRepository: Provider.of<PostsModuleFactory>(context, listen: false).getCommentsRepository())
        ..init(postId: postId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Comments',
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: Consumer<CommentsListVM>(
              builder: (context, commentsListVM, child) {
                if (commentsListVM.isInitializing) {
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: commentsListVM.comments.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        color: Colors.cyan[100],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            commentsListVM.comments[index].body,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
