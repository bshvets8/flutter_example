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

  PostsRepository _postsRepository;
  CommentsRepository _commentsRepository;

  @override
  void initState() {
    super.initState();

    final WebDataProvider webDataProvider = JsonPlaceholderWebDataProvider(WebAPI(Client()));
    final LocalDataProvider localDataProvider = InMemoryDataProvider();

    _postsRepository = PostsRepositoryImpl(
      webDataProvider: webDataProvider,
      localDataProvider: localDataProvider,
    );

    _commentsRepository = CommentsRepositoryImpl(
      webDataProvider: webDataProvider,
      localDataProvider: localDataProvider,
    );
  }

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
            pageBuilder = (_) => PostDetailsPage();
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

    return MultiProvider(
      providers: [
        Provider<PostsListVM>(
          create: (context) => PostsListVM(postsRepository: _postsRepository),
        ),
        Provider<PostDetailsVM>(
          create: (context) => PostDetailsVM(postsRepository: _postsRepository),
        ),
        Provider<CommentsVM>(
          create: (context) => CommentsVM(commentsRepository: _commentsRepository),
        ),
      ],
      child: scaffold,
    );
  }
}
