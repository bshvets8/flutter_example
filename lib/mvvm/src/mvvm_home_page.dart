import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:flutter_cubit/mvvm/src/dependencies_provider_widget.dart';

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

    return DependenciesProviderWidget(child: scaffold);
  }
}
