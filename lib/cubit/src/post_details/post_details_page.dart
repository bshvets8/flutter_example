import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/cubit/cubit.dart';

class PostDetailsPage extends StatelessWidget {
  static const routeName = "/cubit/posts/details";

  const PostDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments; // TODO: Remove. Pass to cubit. Change only title
    final body = PostDetails(postId: postId);

    final title = Text('PostDetails');

    return Platform.isIOS // TODO: Remove Scaffold recreation.
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: title,
            ),
            child: body)
        : Scaffold(
            appBar: AppBar(
              title: title,
            ),
            body: body,
          );
  }
}
