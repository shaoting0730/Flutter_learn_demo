import 'package:flutter/material.dart';

///
///Android去除默认的水波纹动画效果
///
class NoRippleScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}