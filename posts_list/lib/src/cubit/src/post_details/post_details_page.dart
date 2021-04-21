import 'package:flutter/widgets.dart';

import 'post_details_widget.dart';

// REVIEW: Open user details/ about. Navigation from this screen.
class PostDetailsPage extends StatelessWidget {
  static const routeName = "/cubit/posts/details";

  const PostDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostDetailsWidget();
  }
}
