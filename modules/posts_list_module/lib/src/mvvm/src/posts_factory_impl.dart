import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:posts_list_module/src/domain/data_providers/data_sources.dart';
import 'package:posts_list_module/src/domain/repositories/repositories.dart';

import 'posts_factory.dart';

class PostsModuleFactoryImpl extends PostsModuleFactory {
  final WebDataSource _webDataSource;
  final DatabaseDataSource _databaseDataSource;

  PostsModuleFactoryImpl()
      : _webDataSource = JsonPlaceholderWebDataSource(WebAPI(Client())),
        _databaseDataSource = DatabaseDataSourceImpl(PostsDatabase());

  @visibleForTesting
  PostsModuleFactoryImpl.mocked(
      {@required WebDataSource webDataSource, @required DatabaseDataSource databaseDataSource})
      : _webDataSource = webDataSource,
        _databaseDataSource = databaseDataSource;

  @override
  PostsRepository getPostsRepository() {
    return PostsRepositoryImpl(webDataSource: _webDataSource, databaseDataSource: _databaseDataSource);
  }

  @override
  CommentsRepository getCommentsRepository() {
    return CommentsRepositoryImpl(webDataSource: _webDataSource, databaseDataSource: _databaseDataSource);
  }

  @override
  void dispose() {
    _webDataSource.dispose();
    _databaseDataSource.dispose();
  }
}
