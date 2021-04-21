import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';
import 'package:flutter_cubit/mvvm/src/posts_factory.dart';
import 'package:flutter_cubit/mvvm/src/posts_factory_impl.dart';
import 'package:provider/provider.dart';

import 'post_details/post_details_page.dart';
import 'posts_list/posts_list_page.dart';

class MVVMHomePage extends StatelessWidget {
  static const routeName = '/mvvm';

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final body = WillPopScope(
      onWillPop: () async {
        print('nested willpop called');
        return !await navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: PostsListPage.routeName,
        onGenerateRoute: (settings) {
          WidgetBuilder pageBuilder;
          switch (settings.name) {
            case PostDetailsPage.routeName:
              pageBuilder = (_) => PostDetailsPage(postId: settings.arguments);
              break;
            case PostsListPage.routeName:
              pageBuilder = (_) => PostsListPage();
              break;
            default:
              return null;
          }

          return Platform.isIOS ? CupertinoPageRoute(builder: pageBuilder) : MaterialPageRoute(builder: pageBuilder);
        },
      ),
    );

    final title = Text('MVVM Page');
    final scaffold = Platform.isIOS
        ? CupertinoPageScaffold(
            // REVIEW: Use parent appbar. Check if nested navigator updates top level app bar.
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

    return Provider<PostsModuleFactory>(
      create: (context) => PostsModuleFactoryImpl(),
      dispose: (context, factory) => factory.dispose(),
      child: body,
    );
  }
}
