import 'package:flutter/widgets.dart';

//REVIEW: Rename to nested navigator.
//REVIEW: Include willPopScope and Navigator inside

class NestedNavigator extends StatefulWidget {
  final String initialRoute;

  final RouteFactory onGenerateRoute;

  final Scaffold scaffold;

  const NestedNavigator({Key key, this.initialRoute, this.onGenerateRoute}) : super(key: key);

  @override
  NestedNavigatorState createState() => NestedNavigatorState();

  static NestedNavigatorState of(BuildContext context) {
    return context.findAncestorStateOfType<NestedNavigatorState>();
  }
}

class NestedNavigatorState extends State<NestedNavigator> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('nested willpop called');
        return !await navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
      ),
    );
  }

  // REVIEW: Add all navigator methods
  Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) {
    navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object>({bool popNestedStack = false, T result = null}) {
    if (popNestedStack) {
      Navigator.of(context).pop(result);
    } else {
      navigatorKey.currentState.pop(result);
    }
  }
}
