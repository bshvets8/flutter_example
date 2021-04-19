import 'package:flutter_cubit/domain/models/models.dart';

import 'comment_model_mapper.dart';
import 'database_data_provider.dart';
import 'post_model_mapper.dart';
import 'posts_database.dart';

// REVIEW: Rename to more specific. (e.g. Database). Hold separate db for every module
class DatabaseDataSourceImpl extends DatabaseDataSource {
  final PostsDatabase database;

  DatabaseDataSourceImpl(this.database);

  @override
  Stream<List<CommentModel>> getComments() =>
      database.getComments().map((comments) => comments.map(CommentModelMapper.toModel).toList());

  @override
  Stream<List<PostModel>> getPosts() => database.getPosts().map((posts) => posts.map(PostModelMapper.toModel).toList());

  @override
  Future<bool> get hasComments => database.areCommentsExist();

  @override
  Future<bool> get hasPosts => database.arePostsExist();

  @override
  Future<void> deleteComments() => database.deleteComments();

  @override
  Future<void> deletePosts() => database.deletePosts();

  @override
  Future<void> insertComments(List<CommentModel> comments) =>
      database.insertComments(comments.map((comment) => CommentModelMapper.toDatabaseEntry(comment)).toList());

  @override
  Future<void> insertPosts(List<PostModel> posts) =>
      database.insertPosts(posts.map((post) => PostModelMapper.toDatabaseEntry(post)).toList());

  @override
  void dispose() {
    database.close();
  }
}
