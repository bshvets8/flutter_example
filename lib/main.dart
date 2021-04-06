import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/comments_repository.dart';
import 'package:flutter_cubit/cubit/comments_cubit.dart';
import 'package:flutter_cubit/cubit/post_details.dart';
import 'package:flutter_cubit/cubit/post_details_cubit.dart';
import 'package:flutter_cubit/cubit/posts_list_page.dart';
import 'package:flutter_cubit/cubit/posts_list_cubit.dart';
import 'package:flutter_cubit/posts_repository.dart';
import 'package:flutter_cubit/web_api.dart';
import 'package:http/http.dart';

void main() {
  final client = Client();
  final webApi = WebAPI(client);
  final postsRepository = PostsRepository(webApi);
  final commentsRepository = CommentsRepository(webApi);

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
                              postId: settings.arguments)
                            ..loadPost(),
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

class HomePage extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    final title = Text('Flutter Architecture Example');

    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Navigate to a page:",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: () =>
                Navigator.of(context).pushNamed(PostsListPage.routeName),
            child: Text("CUBIT"),
          ),
        ],
      ),
    );

    return Platform.isIOS
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
            body: body);
  }
}
