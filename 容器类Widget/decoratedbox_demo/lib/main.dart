import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /* 
   * const DecoratedBox({
   * Decoration decoration,
   * DecorationPosition position = DecorationPosition.background,
   * Widget child
   * }) 
   */

  /*
   * BoxDecoration({
   * Color color, //颜色
   * DecorationImage image,//图片
   * BoxBorder border, //边框
   * BorderRadiusGeometry borderRadius, //圆角
   * List<BoxShadow> boxShadow, //阴影,可以指定多个
   * Gradient gradient, //渐变
   * BlendMode backgroundBlendMode, //背景混合模式
   * BoxShape shape = BoxShape.rectangle, //形状
   *  }) 
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('DecoratedBox')),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red, Colors.orange[400]]), // 背景渐变
            borderRadius: BorderRadius.circular(4.0), // 圆角4.0
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
            child: Text('文字', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
