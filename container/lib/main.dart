import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*
   * Container({
   * this.alignment,
   * this.padding, //容器内补白，属于decoration的装饰范围
   * Color color, // 背景色
   * Decoration decoration, // 背景装饰
   * Decoration foregroundDecoration, //前景装饰
   * double width,//容器的宽度
   * double height, //容器的高度
   * BoxConstraints constraints, //容器大小的限制条件
   * this.margin,//容器外补白，不属于decoration的装饰范围
   * this.transform, //变换
   * this.child,
   * })
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',    
      home: Scaffold(
        body: Center(
          child: Container(
              child: new Text('今天学习下 Container',style:TextStyle(fontSize: 40.0,)),
              alignment: Alignment.topLeft,
              width: 500.0,
              height: 400.0,
              padding: const EdgeInsets.fromLTRB(10.0, 100.0, 0.0, 0.0),
              margin: const EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.lightBlue,Colors.greenAccent,Colors.purple]
                ),
                border: Border.all(width: 10.0,color: Color.fromRGBO(178, 123, 123, 1))
              ),
          ),
        ),
      ),
    );
  }
}



