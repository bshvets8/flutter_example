import 'package:flutter_cubit/domain/data_providers.dart';
import 'package:flutter_cubit/domain/models.dart';

class PostsRepository {
  final WebDataProvider webDataProvider;

  PostsRepository(this.webDataProvider);

  Future<List<PostModel>> getPosts() => webDataProvider.getPosts();

  Future<PostModel> getPost(int postId) async {
    final posts = await getPosts();
    return posts.firstWhere((element) => element.id == postId);
  }
}
