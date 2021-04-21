import 'package:flutter_cubit/domain/data_providers/data_sources.dart';
import 'package:flutter_cubit/domain/data_providers/src/db/posts_database.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:http/http.dart';

import 'posts_factory.dart';

class PostsModuleFactoryImpl extends PostsModuleFactory {
  WebDataSource _webDataSource; // REVIEW: Move to constructor
  DatabaseDataSource _databaseDataSource;

  //@visibleForTesting // REVIEW: Use for constructor

  @override
  PostsRepository getPostsRepository() {
    return PostsRepositoryImpl(webDataSource: _getWebDataSource(), databaseDataSource: _getDatabaseDataSource());
  }

  @override
  CommentsRepository getCommentsRepository() {
    return CommentsRepositoryImpl(webDataSource: _getWebDataSource(), databaseDataSource: _getDatabaseDataSource());
  }

  WebDataSource _getWebDataSource() { // REVIEW: Instantiate inside constructor
    if (_webDataSource == null) _webDataSource = JsonPlaceholderWebDataSource(WebAPI(Client()));

    return _webDataSource;
  }

  DatabaseDataSource _getDatabaseDataSource() {
    if (_databaseDataSource == null) _databaseDataSource = DatabaseDataSourceImpl(PostsDatabase());

    return _databaseDataSource;
  }

  @override
  void dispose() {
    _getWebDataSource().dispose();
    _getDatabaseDataSource().dispose();
  }
}
