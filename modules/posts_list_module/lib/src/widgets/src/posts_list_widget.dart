import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_list_module/src/domain/models/models.dart';

typedef ItemTapCallback = void Function(PostModel postModel);

class PostsListWidget extends StatelessWidget {
  final List<PostModel> _posts;
  final ItemTapCallback _itemTapCallback;
  final int _selectedPostId;

  PostsListWidget({@required List<PostModel> posts, @required ItemTapCallback itemTapCallback, int selectedPostId = -1})
      : _posts = posts,
        _itemTapCallback = itemTapCallback,
        _selectedPostId = selectedPostId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: Colors.black12,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) => ListTile(
        selected: _posts[index].id == _selectedPostId,
        onTap: () => _itemTapCallback(_posts[index]),
        title: Padding(
          padding: EdgeInsets.all(16),
          child: Text(_posts[index].title),
        ),
      ),
    );
  }
}
