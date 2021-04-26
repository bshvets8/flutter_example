import 'package:posts_list_module/src/domain/models/models.dart';

import 'posts_database.dart';

class CommentModelMapper {
  static CommentModel toModel(Comment comment) => CommentModel(
        postId: comment.postId,
        id: comment.id,
        name: comment.name,
        email: comment.email,
        body: comment.body,
      );

  static Comment toDatabaseEntry(CommentModel commentModel) => Comment(
        postId: commentModel.postId,
        id: commentModel.id,
        name: commentModel.name,
        email: commentModel.email,
        body: commentModel.body,
      );
}
