import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'post_details.dart';

class PostDetailsPage extends StatelessWidget {
  static const routeName = '/mvvm/posts/details';

  @override
  Widget build(BuildContext context) {
    final body = PostDetails();

    final title = Text('PostDetails');

    return Platform.isIOS
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