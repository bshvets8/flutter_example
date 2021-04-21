import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/comments_table.dart';
import 'tables/posts_table.dart';

part 'posts_database.g.dart';

// Review: Add migration: Add column Posts.id1. copy value from id. Use id1 instead of id
@UseMoor(tables: [Posts, Comments])
class PostsDatabase extends _$PostsDatabase {
  static const _databaseName = 'posts.db';
  static const _databaseVersion = 1;

  PostsDatabase() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, _databaseName));
      return VmDatabase(file);
    });
  }

  @override
  int get schemaVersion => _databaseVersion;

  Stream<List<Post>> getPosts() {
    return select(posts).watch();
  }

  Stream<List<Comment>> getComments() {
    return select(comments).watch();
  }

  Future<bool> arePostsExist() async => (await select(posts).get()).isNotEmpty;

  Future<bool> areCommentsExist() async => (await select(comments).get()).isNotEmpty;

  Future<void> insertPosts(List<Post> postsEntries) => batch((batch) {
        batch.insertAll(posts, postsEntries);
      });

  Future<void> insertComments(List<Comment> commentsEntries) => batch((batch) {
        batch.insertAll(comments, commentsEntries);
      });

  Future<void> deletePosts() async => await delete(posts).go();

  Future<void> deleteComments() async => await delete(comments).go();
}
