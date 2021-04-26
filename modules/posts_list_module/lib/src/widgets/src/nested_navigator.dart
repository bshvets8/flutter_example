import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//REVIEW: Rename to nested navigator.
//REVIEW: Include willPopScope and Navigator inside

class NestedNavigator extends StatefulWidget {
  final String initialRoute;

  final RouteFactory onGenerateRoute;

  final String tag;

  const NestedNavigator({Key key, this.initialRoute, this.onGenerateRoute, this.tag}) : super(key: key);

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
        print('nested willpop called, tag = ${widget.tag} canPop = ${canPop()}');
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
    final result = navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
    print("tag = ${widget.tag}");
    context.findAncestorStateOfType<NestedNavigationParentState>().setState(() {

    });

    return result;
  }

  @optionalTypeArgs
  String restorablePushNamed<T extends Object>(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.restorablePushNamed<T>(routeName, arguments: arguments);
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
  }

  bool canPop() {
    return navigatorKey.currentState.canPop();
  }
}

class NestedNavigationScaffold extends Scaffold {
  final NestedNavigator nestedNavigator;

  NestedNavigationScaffold(this.nestedNavigator);

  @override
  Widget get body => nestedNavigator;

  @override
  NestedNavigationScaffoldState createState() {
    return NestedNavigationScaffoldState();
  }
}

class NestedNavigationScaffoldState extends ScaffoldState {
  @override
  Widget build(BuildContext context) {
    final parentScaffold = super.build(context);

    // (widget as NestedNavigationScaffold).superBody;

    // return Navigator(
    //   initialRoute: '_',
    //   onGenerateRoute: (settings) =>
    //       m(
    //         navigatorKey: navigator, builder: (context) => parentScaffold,),
    // );
  }
}

class CustomRoute extends MaterialPageRoute {
  final GlobalKey<NestedNavigatorState> navigatorKey;

  CustomRoute({
    this.navigatorKey,
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);

  @override
  bool get canPop {
    print("Route canPop used, nav tag = ${navigatorKey.currentState?.widget?.tag ?? 'null'} canPop = ${navigatorKey.currentState?.canPop() ?? false}");
    return navigatorKey.currentState?.canPop() ?? false;
  }

  @override
  void changedExternalState() {
    super.changedExternalState();
    print('changedExternalState');
  }
}

///////////////////////////////////////////////

typedef NestedNavigationRootBuilder = Widget Function(BuildContext context, Widget body);

class NestedNavigationParent extends StatefulWidget {
  final NestedNavigationRootBuilder builder;

  final String initialRoute;

  final RouteFactory onGenerateRoute;

  const NestedNavigationParent({Key key, this.builder, this.initialRoute, this.onGenerateRoute}) : super(key: key);

  @override
  NestedNavigationParentState createState() => NestedNavigationParentState();
}

class NestedNavigationParentState extends State<NestedNavigationParent> {
  final nestedNavigatorKey = GlobalKey<NestedNavigatorState>();

  @override
  Widget build(BuildContext context) {
    final nestedNavigator = NestedNavigator(
      tag: "body",
      key: nestedNavigatorKey,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
    );

    return NestedNavigator(
      tag: "root",
      initialRoute: '_',
      onGenerateRoute: (settings) => CustomRoute(
        navigatorKey: nestedNavigatorKey,
        builder: (context) => widget.builder(context, nestedNavigator),
      ),
    );
  }
}
