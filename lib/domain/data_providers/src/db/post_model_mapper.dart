import 'package:flutter_cubit/domain/models/models.dart';

import 'posts_database.dart';

class PostModelMapper {
  static PostModel toModel(Post post) => PostModel(
        id: post.id,
        userId: post.userId,
        title: post.title,
        body: post.body,
      );

  static Post toDatabaseEntry(PostModel postModel) => Post(
        id: postModel.id,
        userId: postModel.userId,
        title: postModel.title,
        body: postModel.body,
      );
}
