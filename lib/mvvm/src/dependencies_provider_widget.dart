import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/data_providers/src/db/posts_database.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class DependenciesProviderWidget extends StatelessWidget {
  final Widget _child;

  const DependenciesProviderWidget({Key key, Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WebDataSource>(
          create: (context) => JsonPlaceholderWebDataSource(WebAPI(Client())),
        ),
        Provider<DatabaseDataSource>(
          create: (context) => DatabaseDataSourceImpl(PostsDatabase()),
          dispose: (context, value) => value.dispose(),
        ),
        // REVIEW: Register factory
        ProxyProvider2<WebDataSource, DatabaseDataSource, PostsRepository>(
          update: (context, webDataProvider, databaseDataSource, previous) =>
              PostsRepositoryImpl(webDataProvider: webDataProvider, databaseDataSource: databaseDataSource),
        ),
        ProxyProvider2<WebDataSource, DatabaseDataSource, CommentsRepository>(
          update: (context, webDataProvider, databaseDataSource, previous) =>
              CommentsRepositoryImpl(webDataSource: webDataProvider, databaseDataSource: databaseDataSource),
        ),
      ],
      child: _child,
    );
  }
}
