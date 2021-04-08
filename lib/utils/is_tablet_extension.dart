import 'package:flutter/cupertino.dart';

extension IsTablet on MediaQueryData {
  static const tabletWidthBreakPoint = 600;

  bool isTablet() => size.shortestSide >= IsTablet.tabletWidthBreakPoint;
}
