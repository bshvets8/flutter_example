import 'package:flutter_cubit/domain/repositories/repositories.dart';

abstract class PostsModuleFactory {
  PostsRepository getPostsRepository();

  CommentsRepository getCommentsRepository();

  void dispose();
}
