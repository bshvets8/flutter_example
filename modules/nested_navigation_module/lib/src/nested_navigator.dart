import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NestedNavigator extends StatefulWidget {
  final String initialRoute;

  final RouteFactory onGenerateRoute;

  NestedNavigator({Key key, this.initialRoute, this.onGenerateRoute}) : super(key: key);

  @override
  _NestedNavigatorState createState() => _NestedNavigatorState();

  static _NestedNavigatorState of(BuildContext context) {
    return context.findAncestorStateOfType<_NestedNavigatorState>();
  }
}

class _NestedNavigatorState extends State<NestedNavigator> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = !await navigatorKey.currentState.maybePop();
        return result;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
      ),
    );
  }

  void popStack<T extends Object>([T result]) {
    Navigator.of(context).pop(result);
  }
}
