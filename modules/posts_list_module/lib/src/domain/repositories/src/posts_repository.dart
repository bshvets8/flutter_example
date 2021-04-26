import 'package:posts_list_module/src/domain/models/models.dart';

import 'repository.dart';

abstract class PostsRepository extends Repository {
  // DONE: Create base repository. add dispose
  // DONE: Rename to getPosts or get method
  // DONE: Add 'force' argument to invalidate data in db
  Stream<List<PostModel>> getPosts({bool forceFetch = false});

  Stream<PostModel> getPost(int postId);
}
