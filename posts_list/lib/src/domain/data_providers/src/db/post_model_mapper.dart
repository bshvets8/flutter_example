import 'package:posts_list/src/domain/models/models.dart';

import 'posts_database.dart';

class PostModelMapper {
  static PostModel toModel(Post post) => PostModel(
        id: post.id1,
        userId: post.userId,
        title: post.title,
        body: post.body,
      );

  static Post toDatabaseEntry(PostModel postModel) => Post(
        id: postModel.id,
        id1: postModel.id,
        userId: postModel.userId,
        title: postModel.title,
        body: postModel.body,
      );
}
