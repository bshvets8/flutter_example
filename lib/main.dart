import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/cubit_posts.dart';
import 'package:flutter_cubit/domain/data_providers.dart';
import 'package:flutter_cubit/domain/repositories.dart';
import 'package:http/http.dart';

import 'home_page.dart';

void main() {
  final client = Client();
  final webApi = WebAPI(client);
  final jsonPlaceholderDataProvider = JsonPlaceholderWebDataProvider(webApi);
  final inMemoryDataProvider = InMemoryDataProvider();

  final postsRepository = PostsRepository(
    webDataProvider: jsonPlaceholderDataProvider,
    localDataProvider: inMemoryDataProvider,
  );

  final commentsRepository = CommentsRepository(
    webDataProvider: jsonPlaceholderDataProvider,
    localDataProvider: inMemoryDataProvider,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  runApp(MyApp(
    postsRepository: postsRepository,
    commentsRepository: commentsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository postsRepository;
  final CommentsRepository commentsRepository;

  const MyApp(
      {Key key,
      @required this.postsRepository,
      @required this.commentsRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialRoute = HomePage.routeName;
    final title = 'Flutter Architecture Example';
    final routes = {
      HomePage.routeName: (_) => HomePage(),
      PostsListPage.routeName: (_) => BlocProvider<PostsListCubit>(
            create: (_) => PostsListCubit(postsRepository)..loadPosts(),
            child: PostsListPage(),
          ),
    };

    return Platform.isIOS
        ? CupertinoApp(
            title: title,
            initialRoute: initialRoute,
            routes: routes,
            theme: CupertinoThemeData(primaryColor: Colors.purple),
          )
        : MaterialApp(
            title: title,
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            onGenerateRoute: (settings) {
              if (settings.name == PostDetails.routeName) {
                final pageBuilder = (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<PostDetailsCubit>(
                          create: (context) => PostDetailsCubit(
                              postsRepository: postsRepository,
                              postId: settings.arguments),
                        ),
                        BlocProvider<CommentsCubit>(
                          create: (context) => CommentsCubit(
                              commentsRepository: commentsRepository,
                              postId: settings.arguments)
                            ..loadComments(),
                        )
                      ],
                      child: PostDetails(),
                    );

                return Platform.isIOS
                    ? CupertinoPageRoute(builder: pageBuilder)
                    : MaterialPageRoute(builder: pageBuilder);
              }

              return null;
            },
            initialRoute: initialRoute,
            routes: routes,
          );
  }
}
