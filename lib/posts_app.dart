import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/abc_page.dart';
import 'package:posts_list_module/posts_list_module.dart';

import 'home_page.dart';

class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Flutter Architecture Example';

    final routes = {
      ABCPage.routeName: (context) => ABCPage(),
      HomePage.routeName: (context) => HomePage(),
      MVVMHomePage.routeName: (context) => MVVMHomePage(),
      CubitHomePage.routeName: (context) => CubitHomePage(),
    };

    return Platform.isIOS
        ? CupertinoApp(
            initialRoute: ABCPage.routeName,
            routes: routes,
            title: title,
            // initialRoute: initialRoute,
            // routes: routes,
            theme: CupertinoThemeData(primaryColor: Colors.purple),
          )
        : MaterialApp(
            initialRoute: ABCPage.routeName,
            routes: routes,
            title: title,
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            // initialRoute: initialRoute,
            // routes: routes,
          );
  }
}
