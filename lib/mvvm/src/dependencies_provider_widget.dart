import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
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
        Provider<WebDataProvider>(
          create: (context) => JsonPlaceholderWebDataProvider(WebAPI(Client())),
        ),
        Provider<LocalDataProvider>(
          create: (context) => InMemoryDataProvider(),
        ),
        ProxyProvider2<WebDataProvider, LocalDataProvider, PostsRepository>(
          update: (context, webDataProvider, localDataProvider, previous) =>
              PostsRepositoryImpl(webDataProvider: webDataProvider, localDataProvider: localDataProvider),
        ),
        ProxyProvider2<WebDataProvider, LocalDataProvider, CommentsRepository>(
          update: (context, webDataProvider, localDataProvider, previous) =>
              CommentsRepositoryImpl(webDataProvider: webDataProvider, localDataProvider: localDataProvider),
        ),
      ],
      child: _child,
    );
  }
}
