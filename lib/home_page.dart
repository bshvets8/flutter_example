import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_list_module/posts_list_module.dart';

import 'adaptive_button.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/";

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final title = Text('Flutter Architecture Example');

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: HomeWidget(),
            navigationBar: CupertinoNavigationBar(
              middle: title,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: title,
            ),
            body: HomeWidget(),
          );

    // final nestedNavigator = NestedNavigator(
    //   initialRoute: HomeWidget.routeName,
    //   onGenerateRoute: (settings) {
    //     WidgetBuilder pageBuilder;
    //
    //     switch (settings.name) {
    //       case HomeWidget.routeName:
    //         pageBuilder = (_) => HomeWidget();
    //         break;
    //
    //       case MVVMHomePage.routeName:
    //         pageBuilder = (_) => MVVMHomePage();
    //         break;
    //
    //       case CubitHomePage.routeName:
    //         pageBuilder = (_) => CubitHomePage();
    //         break;
    //
    //       default:
    //         return null;
    //     }
    //
    //     return Platform.isIOS
    //         ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
    //         : MaterialPageRoute(builder: pageBuilder, settings: settings);
    //   },
    // );
  }
}

class HomeWidget extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Architecture Sample:",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          AdaptiveButton(
            onPressed: () => Navigator.of(context).pushNamed(CubitHomePage.routeName),
            child: Text(
              "CUBIT",
              style: TextStyle(color: Colors.white),
            ),
          ),
          AdaptiveButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(MVVMHomePage.routeName)
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value))))
                .onError((error, stackTrace) {}),
            child: Text(
              "MVVM",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
