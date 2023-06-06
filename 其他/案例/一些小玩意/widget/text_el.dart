import 'package:flutter/material.dart';


class RLText extends StatelessWidget {
  /// 文本内容
  final String? text;

  /// 文本颜色
  final Color? color;

  /// 行间距
  final double? lineHeight;

  /// 行数
  final int? maxLines;

  /// 文本字号
  final double? fontSize;

  /// 文本字重
  final FontWeight? fontWeight;

  /// 文本对齐方式
  final TextAlign? textAlign;

  ///文字方向
  final TextDirection? textDirection;

  /// 整体对齐方式
  final Alignment? alignment;

  /// 边框
  final double? borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 圆角
  final double? circularRadius;

  /// 背景颜色
  final Color? backgroundColor;

  /// 背景颜色
  final String? fontFamily;

  final StrutStyle? strutStyle;
  final TextOverflow? overflow;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;
  final BoxConstraints? constraints;

  /// 文本样式
  final TextStyle? textStyle;

  const RLText(
    this.text, {
    Key? key,
    this.color = Colors.black,
    this.lineHeight,
    this.maxLines,
    this.fontSize = 14,
    this.textAlign,
    this.alignment,
    this.borderWidth,
    this.borderColor,
    this.circularRadius,
    this.backgroundColor,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.strutStyle,
    this.decoration,
    this.constraints,
    this.textDirection,
    this.fontFamily,
    this.overflow,
    this.fontWeight = FontWeight.normal,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            //背景
            color: backgroundColor,
            //设置四周圆角 角度
            borderRadius:
                BorderRadius.all(Radius.circular(circularRadius ?? 0.0)),
            //设置四周边框
            border: Border.all(
              width: borderWidth ?? 0,
              color: borderColor ?? Colors.transparent,
            ),
          ),
      alignment: alignment,
      constraints: constraints,
      child: Text(
        text ?? '',
        textAlign: textAlign,
        overflow: maxLines != null ? (overflow ?? TextOverflow.ellipsis) : null,
        maxLines: maxLines,
        strutStyle: strutStyle,
        textDirection: textDirection,
        style: textStyle ??
            TextStyle(
              height: lineHeight,
              color: color,
              fontFamily:
                  fontFamily ?? DefaultTextStyle.of(context).style.fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      ),
    );
  }
}
