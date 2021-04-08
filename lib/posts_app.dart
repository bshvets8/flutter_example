import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/cubit/cubit.dart' as cubit;
import 'package:flutter_cubit/mvvm/mvvm.dart' as mvvm;

import 'home_page.dart';

class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialRoute = HomePage.routeName;
    final title = 'Flutter Architecture Example';
    final routes = {
      HomePage.routeName: (_) => HomePage(),
      cubit.PostsListPage.routeName: (_) => cubit.PostsListPage(),
      cubit.PostDetailsPage.routeName: (_) => cubit.PostDetailsPage(),
      mvvm.PostsListPage.routeName: (_) => mvvm.PostsListPage(),
      mvvm.PostDetailsPage.routeName: (_) => mvvm.PostDetailsPage()
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
            initialRoute: initialRoute,
            routes: routes,
          );
  }
}
