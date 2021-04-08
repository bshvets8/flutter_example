import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/cubit/cubit_posts.dart' as cubit;
import 'package:flutter_cubit/mvvm/mvvm.dart' as mvvm;
import 'package:flutter_cubit/widgets/widgets.dart';

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
            "Architecture Sample:",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          AdaptiveButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(cubit.PostsListPage.routeName),
            child: Text(
              "CUBIT",
              style: TextStyle(color: Colors.white),
            ),
          ),
          AdaptiveButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(mvvm.PostsListPage.routeName),
            child: Text(
              "MVVM",
              style: TextStyle(color: Colors.white),
            ),
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
