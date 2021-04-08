import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/models/models.dart';

typedef ItemTapCallback = void Function(PostModel postModel);

class PostsList extends StatelessWidget {
  final List<PostModel> _posts;
  final ItemTapCallback _itemTapCallback;

  PostsList(
      {@required List<PostModel> posts,
      @required ItemTapCallback itemTapCallback})
      : _posts = posts,
        _itemTapCallback = itemTapCallback;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: Colors.black12,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => _itemTapCallback(_posts[index]),
        title: Padding(
          padding: EdgeInsets.all(16),
          child: Text(_posts[index].title),
        ),
      ),
    );
  }
}
