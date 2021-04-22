import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_list/src/mvvm/src/posts_factory.dart';
import 'package:posts_list/src/mvvm/src/posts_factory_impl.dart';
import 'package:posts_list/src/widgets/src/sub_navigation_scope.dart';
import 'package:provider/provider.dart';

import 'post_details/post_details_page.dart';
import 'posts_list/posts_list_page.dart';

class MVVMHomePage extends StatefulWidget {
  static const routeName = '/mvvm';

  @override
  MVVMHomePageState createState() => MVVMHomePageState();
}

class MVVMHomePageState extends State<MVVMHomePage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    final body = NestedNavigator(
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

        return Platform.isIOS
            ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
            : MaterialPageRoute(builder: pageBuilder, settings: settings);
      },
    );

    // final bodtempy = SubNavigationScope(
    //   child: WillPopScope(
    //     onWillPop: () async {
    //       print('nested willpop called');
    //       return !await navigatorKey.currentState.maybePop();
    //     },
    //     child: Navigator(
    //       key: navigatorKey,
    //       initialRoute: PostsListPage.routeName,
    //       onGenerateRoute: (settings) {
    //         WidgetBuilder pageBuilder;
    //
    //         switch (settings.name) {
    //           case PostDetailsPage.routeName:
    //             pageBuilder = (_) => PostDetailsPage(postId: settings.arguments);
    //             break;
    //
    //           case PostsListPage.routeName:
    //             pageBuilder = (_) => PostsListPage();
    //             break;
    //
    //           default:
    //             return null;
    //         }
    //
    //         return Platform.isIOS
    //             ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
    //             : MaterialPageRoute(builder: pageBuilder, settings: settings);
    //       },
    //     ),
    //   ),
    // );

    return Provider<PostsModuleFactory>(
      create: (context) => PostsModuleFactoryImpl(),
      dispose: (context, factory) => factory.dispose(),
      child: body,
    );
  }
}
