import 'package:posts_list/src/domain/models/models.dart';

import 'repository.dart';

abstract class CommentsRepository extends Repository {
  Stream<List<CommentModel>> getComments({int postId, bool forceFetch = false});
}
