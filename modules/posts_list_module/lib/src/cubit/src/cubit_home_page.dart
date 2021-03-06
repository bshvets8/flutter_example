import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:posts_list_module/src/domain/data_providers/data_sources.dart';
import 'package:posts_list_module/src/domain/data_providers/src/db/posts_database.dart';
import 'package:posts_list_module/src/domain/repositories/repositories.dart';

import 'post_details/comments_cubit.dart';
import 'post_details/post_details_cubit.dart';
import 'post_details/post_details_page.dart';
import 'posts_list/posts_list_cubit.dart';
import 'posts_list/posts_list_page.dart';

class CubitHomePage extends StatefulWidget {
  static const routeName = '/cubit';

  @override
  _CubitHomePageState createState() => _CubitHomePageState();
}

// Review: Replace with Stateless
class _CubitHomePageState extends State<CubitHomePage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  PostsRepository _postsRepository; // Done: Centralize initiation (Class or widget) abstract factory. Singleton factory
  CommentsRepository _commentsRepository;

  @override
  void initState() {
    super.initState();

    final WebDataSource webDataProvider = JsonPlaceholderWebDataSource(WebAPI(Client()));
    final DatabaseDataSource databaseDataSource = DatabaseDataSourceImpl(PostsDatabase());

    _postsRepository = PostsRepositoryImpl(
      webDataSource: webDataProvider,
      databaseDataSource: databaseDataSource,
    );

    _commentsRepository = CommentsRepositoryImpl(
      webDataSource: webDataProvider,
      databaseDataSource: databaseDataSource,
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

    final title = Text('Cubit Page');
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

    return MultiBlocProvider(
      providers: [
        // REVIEW: Provide per page. Avoid boilerplate
        BlocProvider<PostsListCubit>(
          create: (context) => PostsListCubit(postsRepository: _postsRepository),
        ),
        BlocProvider<PostDetailsCubit>(
          create: (context) => PostDetailsCubit(postsRepository: _postsRepository),
        ),
        BlocProvider<CommentsCubit>(
          create: (context) => CommentsCubit(commentsRepository: _commentsRepository),
        )
      ],
      child: scaffold,
    );
  }
}
