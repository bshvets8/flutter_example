import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/domain/data_providers/data_providers.dart';
import 'package:flutter_cubit/domain/repositories/repositories.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'post_details/post_details_page.dart';
import 'posts_list/posts_list_page.dart';

class MVVMHomePage extends StatefulWidget {
  static const routeName = '/mvvm';

  @override
  _MVVMHomePageState createState() => _MVVMHomePageState();
}

class _MVVMHomePageState extends State<MVVMHomePage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final body = WillPopScope(
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: navigatorKey,
        initialRoute: PostsListPage.routeName,
        onGenerateRoute: (settings) {
          WidgetBuilder pageBuilder;
          if (settings.name == PostDetailsPage.routeName) {
            pageBuilder = (_) => PostDetailsPage(postId: settings.arguments);
          }

          if (settings.name == PostsListPage.routeName) {
            pageBuilder = (_) => PostsListPage();
          }

          if (pageBuilder == null) return null;

          return Platform.isIOS ? CupertinoPageRoute(builder: pageBuilder) : MaterialPageRoute(builder: pageBuilder);
        },
      ),
    );

    final title = Text('MVVM Page');
    final scaffold = Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: title,
            ),
            child: body,
          )
        : Scaffold(
            appBar: AppBar(
              title: title,
            ),
            body: body,
          );

    // REVIEW: Create inside widget
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
      child: scaffold,
    );
  }
}
