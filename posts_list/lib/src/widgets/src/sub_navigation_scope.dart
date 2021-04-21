import 'package:flutter/widgets.dart';

class SubNavigationScope extends StatefulWidget {
  final Widget child;

  const SubNavigationScope({Key key, this.child}) : super(key: key);

  @override
  SubNavigationScopeState createState() => SubNavigationScopeState();

  static SubNavigationScopeState of(BuildContext context) {
    return context.findAncestorStateOfType<SubNavigationScopeState>();
  }
}

class SubNavigationScopeState extends State<SubNavigationScope> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void finish<T extends Object>([T result]) {
    Navigator.of(context).pop(result);
  }
}
