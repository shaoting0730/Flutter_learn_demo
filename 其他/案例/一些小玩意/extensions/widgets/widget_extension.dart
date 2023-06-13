import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../widget/no_ripple_scroll_behavior.dart';

extension WidgetExtension on Widget {
  /// 设置边距
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  /// 设置边距
  Widget withPaddingOnly(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return Padding(
        padding:
            EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this);
  }

  /// 设置边距
  Widget withPaddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this);
  }

  /// 设置边距
  Widget withPaddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  /// 设置背景色
  Widget withBackgroundColor(Color color) {
    return ColoredBox(color: color, child: this);
  }

  /// 设置高度
  Widget withHeight(double height) {
    return SizedBox(height: height, child: this);
  }

  /// 设置宽度
  Widget withWidth(double width) {
    return SizedBox(width: width, child: this);
  }

  /// 设置圆角
  Widget withCircularRadius(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// 设置顶部圆角
  Widget withCircularTopRadius(double radius) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        child: this);
  }

  /// 设置底部圆角
  Widget withCircularBottomRadius(double radius) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        child: this);
  }

  /// 高斯模糊
  Widget withBackdropFilter(double sigmaX, double sigmaY, double radius) {
    return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: this)
        .withCircularRadius(radius);
  }

  /// 设置是否显示
  Widget withVisible(bool visible) {
    return Visibility(visible: visible, child: this);
  }

  /// 设置点击事件
  Widget withOnTap(VoidCallback onTap,
      {HitTestBehavior? behavior = HitTestBehavior.opaque}) {
    return GestureDetector(onTap: onTap, behavior: behavior, child: this);
  }

  /// 设为扩展
  Widget withExpanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// 设为弹性
  Widget withFlexible({int flex = 1}) {
    return Flexible(flex: flex, child: this);
  }

  /// 设为滚动
  Widget withScrolled({bool noRippleBehavior = false, ScrollPhysics? physics}) {
    return noRippleBehavior
        ? ScrollConfiguration(
            behavior: NoRippleScrollBehavior(),
            child: SingleChildScrollView(
              physics: physics,
              child: this,
            ),
          )
        : SingleChildScrollView(
            physics: physics,
            child: this,
          );
  }

  /// 设为去除滚动水波纹特效
  Widget withNoRipple() {
    return ScrollConfiguration(
      behavior: NoRippleScrollBehavior(),
      child: this,
    );
  }

  /// 设置点击时收起键盘
  Widget unFocusWhenTap() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: this,
    );
  }
}

class Width extends SizedBox {
  const Width(double width, {Key? key}) : super(key: key, width: width);
}

class Height extends SizedBox {
  const Height(double height, {Key? key}) : super(key: key, height: height);
}
