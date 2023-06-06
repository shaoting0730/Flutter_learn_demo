import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RLButton extends StatelessWidget {
  ///按钮宽度
  final double? width;

  ///按钮高度
  final double? height;

  /// button文字
  final String? text;

  ///文字大小
  final double? fontSize;

  /// 文字颜色
  final Color? textColor;

  /// 文字粗细
  final FontWeight? fontWeight;

  ///点击事件
  final VoidCallback? onClick;

  ///背景色
  final Color? backgroundColor;

  ///前景色
  final Color? foregroundColor;

  ///高亮时的按钮颜色，水波纹颜色
  final Color? overlayColor;

  ///按钮左内边距
  final double? paddingLeft;

  ///按钮右内边距
  final double? paddingRight;

  /// 阴影效果.
  final double? elevation;

  /// 阴影颜色.
  final Color? shadowColor;

  ///圆角的值是否用同一个
  final bool? isAllShape;

  /// 按钮圆角大小.
  final double? shape;

  final double? shapeTopLeft;

  final double? shapeTopRight;

  final double? shapeBottomLeft;

  final double? shapeBottomRight;

  ///边框宽度.
  final double? sideWidth;

  ///边框宽度颜色，默认黑色.
  final Color? sideColor;

  /// 异步点击事件 自动限制重复点击
  final AsyncCallback? onAsyncTap;

  RLButton({
    Key? key,
    this.text,
    this.width,
    this.height,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight,
    this.paddingLeft,
    this.paddingRight,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.isAllShape,
    this.shapeTopLeft,
    this.shapeTopRight,
    this.shapeBottomLeft,
    this.shapeBottomRight,
    this.sideWidth,
    this.sideColor,
    this.onClick,
    this.onAsyncTap,
  })  : content = null,
        super(key: key);

  final Widget? content;

  /// 自定义按钮内容
  RLButton.content({
    Key? key,
    this.content,
    this.width,
    this.height,
    this.paddingLeft,
    this.paddingRight,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.shadowColor,
    this.shape,
    this.isAllShape,
    this.shapeTopLeft,
    this.shapeTopRight,
    this.shapeBottomLeft,
    this.shapeBottomRight,
    this.sideWidth,
    this.sideColor,
    this.onClick,
    this.onAsyncTap,
  })  : text = null,
        fontSize = 14,
        textColor = null,
        fontWeight = FontWeight.normal,
        super(key: key);

  final Duration _kDelay = const Duration(milliseconds: 300);
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 80,
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(
              width: sideWidth ?? 0, color: sideColor ?? Colors.transparent)),
          shape: isAllShape ?? true
              ? MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(shape ?? 0)))
              : MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(shapeTopLeft ?? 0),
                      topRight: Radius.circular(shapeTopRight ?? 0),
                      bottomLeft: Radius.circular(shapeBottomLeft ?? 0),
                      bottomRight: Radius.circular(shapeBottomRight ?? 0)))),
          // 背景色
          backgroundColor:
              MaterialStateProperty.all(backgroundColor ?? Colors.white),
          foregroundColor:
              MaterialStateProperty.all(foregroundColor ?? Colors.transparent),
          // 高亮时的按钮颜色(水波纹颜色，目前统一处理为没有水波纹颜色)
          overlayColor:
              MaterialStateProperty.all(overlayColor ?? Colors.transparent),
          // 阴影效果
          elevation: MaterialStateProperty.all(elevation ?? 0.0),
          shadowColor: MaterialStateProperty.all(shadowColor ?? Colors.black),
          padding: MaterialStateProperty.all(EdgeInsets.only(
              left: paddingLeft ?? 0,
              right: paddingRight ?? 0,
              top: 0,
              bottom: 0)),
        ),
        onPressed: () {
          if (onAsyncTap != null) {
            if (_isEnabled) {
              _isEnabled = false;
              onAsyncTap!().then((_) {
                _isEnabled = true;
              });
            }
          } else {
            if (_isEnabled) {
              onClick?.call();
              _isEnabled = false;
              Future.delayed(_kDelay, () {
                _isEnabled = true;
              });
            }
          }
        },
        child: content ??
            Text(
              text ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
      ),
    );
  }
}
