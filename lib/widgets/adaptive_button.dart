import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  const AdaptiveButton({Key key, this.onPressed, this.color, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: color,
            child: child,
            onPressed: onPressed,
          )
        : MaterialButton(
            color: color,
            child: child,
            onPressed: onPressed,
          );
  }
}
