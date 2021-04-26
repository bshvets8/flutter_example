import 'package:posts_list_module/src/domain/repositories/repositories.dart';

abstract class PostsModuleFactory {
  PostsRepository getPostsRepository();

  CommentsRepository getCommentsRepository();

  void dispose();
}
