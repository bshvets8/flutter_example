import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const AdaptiveButton({Key key, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            child: child,
            onPressed: onPressed,
          )
        : ElevatedButton(
            child: child,
            onPressed: onPressed,
          );
  }
}
