import 'dart:io';

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
        NestedScaffold._updateScaffold(context);
        return result;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
      ),
    );
  }

  Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) {
    final result = navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
    NestedScaffold._updateScaffold(context);

    return result;
  }

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return navigatorKey.currentState.pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  void pop<T extends Object>({bool popNestedStack = false, T result}) {
    if (popNestedStack) {
      Navigator.of(context).pop(result);
    } else {
      navigatorKey.currentState.pop(result);
    }

    NestedScaffold._updateScaffold(context);
  }

  // REVIEW: Add popUntil

  bool canPop() {
    return navigatorKey.currentState.canPop();
  }
}

class _CanPopInterceptorPageRoute extends MaterialPageRoute {
  final GlobalKey<_NestedNavigatorState> nestedNavigatorKey;

  _CanPopInterceptorPageRoute({
    this.nestedNavigatorKey,
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);

  @override
  bool get canPop {
    return nestedNavigatorKey.currentState?.canPop() ?? false;
  }
}

class NestedScaffold extends StatefulWidget {
  final PreferredSizeWidget appBar;

  final NestedNavigator nestedNavigator;

  const NestedScaffold({Key key, this.appBar, this.nestedNavigator}) : super(key: key);

  static void _updateScaffold(context) {
    context.findAncestorStateOfType<_NestedScaffoldState>().setState(() {});
  }

  @override
  _NestedScaffoldState createState() => _NestedScaffoldState();
}

class _NestedScaffoldState extends State<NestedScaffold> {
  final bodyNestedNavigatorKey = GlobalKey<_NestedNavigatorState>();

  @override
  Widget build(BuildContext context) {
    final bodyNestedNavigator = NestedNavigator(
      key: bodyNestedNavigatorKey,
      initialRoute: widget.nestedNavigator.initialRoute,
      onGenerateRoute: widget.nestedNavigator.onGenerateRoute,
    );

    return NestedNavigator(
      onGenerateRoute: (settings) => _CanPopInterceptorPageRoute(
        nestedNavigatorKey: bodyNestedNavigatorKey,
        builder: (context) {
          return Platform.isIOS
              ? CupertinoPageScaffold(
                  navigationBar: widget.appBar,
                  child: bodyNestedNavigator,
                )
              : Scaffold(
                  appBar: widget.appBar,
                  body: bodyNestedNavigator,
                );
        },
      ),
    );
  }
}
