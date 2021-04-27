import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/home_page.dart';

class ABCPage extends StatefulWidget {
  static const routeName = "/abc";

  @override
  _ABCPageState createState() => _ABCPageState();
}

class _ABCPageState extends State<ABCPage> {

  @override
  void initState() {
    Future.microtask(() => Navigator.of(context).pushNamed(HomePage.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Splash Screen"),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
