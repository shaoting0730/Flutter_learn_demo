import 'package:flutter/material.dart';
import 'package:renlv_flutter/common/theme_provider.dart';


class DecorationExtension extends BoxDecoration {
  static Color get _borderColor => ThemeProvider.dividerColor;

  /// 添加默认边框线条
  DecorationExtension.allBorder({
    Color? color,
    double width = 0.5,
    double radius = 0,
    Color backgroundColor = Colors.transparent,
    BoxShadow? shadow,
  }) : super(
            color: backgroundColor,
            borderRadius:
                (radius > 0 ? BorderRadius.all(Radius.circular(radius)) : null),
            border: Border.all(
                color: color ?? _borderColor,
                width: width,
                style: BorderStyle.solid),
            boxShadow: shadow == null ? null : [shadow]);

  /// 添加默认顶部线条
  DecorationExtension.topBorder({
    Color? color,
    double width = 0.5,
    Color? backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            border: Border(
              top: BorderSide(
                color: color ?? _borderColor,
                width: width,
                style: BorderStyle.solid,
              ),
            ));

  /// 添加默认底部线条
  DecorationExtension.bottomBorder({
    Color? color,
    double width = 0.5,
    Color? backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            border: Border(
              bottom: BorderSide(
                color: color ?? _borderColor,
                width: width,
                style: BorderStyle.solid,
              ),
            ));

  /// 添加默认左边线条
  DecorationExtension.leftBorder({
    Color? color,
    double width = 0.5,
    Color? backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            border: Border(
              left: BorderSide(
                color: color ?? _borderColor,
                width: width,
                style: BorderStyle.solid,
              ),
            ));

  /// 添加默认右边线条
  DecorationExtension.rightBorder({
    Color? color,
    double width = 0.5,
    Color? backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            border: Border(
              right: BorderSide(
                color: color ?? _borderColor,
                width: width,
                style: BorderStyle.solid,
              ),
            ));

  /// 添加默认水平方向线条
  DecorationExtension.horizontalBorder({
    Color? color,
    double width = 0.5,
    Color? backgroundColor = Colors.white,
  }) : super(
          color: backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: color ?? _borderColor,
              width: width,
              style: BorderStyle.solid,
            ),
          ),
        );

  /// 添加圆角
  DecorationExtension.circularBorder({
    required double radius,
    Color backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(radius)));

  /// 添加leftTop、rightTop圆角
  DecorationExtension.circularBorderTop({
    required double radius,
    Color backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)));

  /// 添加leftBottom、rightBottom圆角
  DecorationExtension.circularBorderBottom({
    required double radius,
    Color backgroundColor = Colors.white,
  }) : super(
            color: backgroundColor,
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(radius)));
}
