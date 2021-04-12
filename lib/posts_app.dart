import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/cubit/cubit.dart';
import 'package:flutter_cubit/mvvm/mvvm.dart';

import 'home_page.dart';

class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialRoute = HomePage.routeName;
    final title = 'Flutter Architecture Example';
    final routes = {
      HomePage.routeName: (_) => HomePage(),
      CubitHomePage.routeName: (_) => CubitHomePage(),
      MVVMHomePage.routeName: (_) => MVVMHomePage()
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
