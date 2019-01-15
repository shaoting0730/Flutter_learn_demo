import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Transform')),
        body: Padding(
          padding: EdgeInsets.all(100.0),
          child: Column(
            children: <Widget>[
              // 倾斜
              Container(
                color: Colors.black,
                child: new Transform(
                  alignment: Alignment.topRight, // 相对于坐标原点的对齐方式
                  transform: new Matrix4.skewY(0.6), // 沿Y轴倾斜0.3弧度
                  child: new Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.deepOrange,
                    child: Text('go 1234'),
                  ),
                ),
              ),
              Spacer(), // 类似iOS中弹簧约束
              // 平移
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Transform.translate(
                  offset: Offset(-20.0, -5.0),
                  child: Text('平移-20,-5'),
                ),
              ),
              Spacer(), // 类似iOS中弹簧约束
              // 旋转
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Text('旋转90°'),
                ),
              ),
              Spacer(), // 类似iOS中弹簧约束
              // 缩放
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
                child: Transform.scale(
                  scale: 1.5,
                  child: Text('放大1.5倍'),
                ),
              ),
              Spacer(), // 类似iOS中弹簧约束
              // Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子widget应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
              // 即: Transform 的位置大小是变化之前的
              // 例子:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.indigo),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Text('hello world'),
                    ),
                  ),
                  Text('您好',
                      style: TextStyle(color: Colors.red, fontSize: 18.0)),
                ],
              ),
              // 可以使用RotatedBox,RotatedBox和Transform.rotate功能相似，它们都可以对子widget进行旋转变换，但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子widget的位置和大小
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.indigo),
                    child: RotatedBox(
                      quarterTurns: 1, // 旋转90度(1/4圈)
                      child: Text('hello world'),
                    ),
                  ),
                  Text('您好',
                      style: TextStyle(color: Colors.red, fontSize: 18.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
