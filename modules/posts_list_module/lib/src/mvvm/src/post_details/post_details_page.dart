import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  static const routeName = '/mvvm/posts/details';

  final int postId;

  const PostDetailsPage({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostDetailsWidget(postId: postId);
  }
}
