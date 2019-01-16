import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /*
   * Listener({
   *  Key key,
   *  this.onPointerDown, 手指按下回调
   *  this.onPointerMove,  手指移动回调
   *  this.onPointerUp, 手指抬起回调
   *  this.onPointerCancel, 触摸事件取消回调
   *  this.behavior = HitTestBehavior.deferToChild,  在命中测试期间如何表现
   *  Widget child
   *   }) 
   */
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: new PointDemo(),
    );
  }
}

class PointDemo extends StatefulWidget {
  @override
  _PointModule createState() => new _PointModule();
}

class _PointModule extends State<PointDemo> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Point')),
      body: Column(
        children: <Widget>[
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              width: 300.0,
              height: 100.0,
              child: Text(_event?.toString() ?? "",
                  style: TextStyle(color: Colors.white)),
            ),
            onPointerDown: (PointerDownEvent event) =>
                setState(() => _event = event),
            onPointerMove: (PointerMoveEvent event) =>
                setState(() => _event = event),
            onPointerUp: (PointerUpEvent event) =>
                setState(() => _event = event),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 100.0)),
              child: Center(child: Text('Box A')),
            ),
            // behavior: HitTestBehavior.opaque,
            onPointerDown: (event) => print('dowm A'),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 100.0)),
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
            onPointerDown: (event) => print("down0"),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200.0, 150.0)),
              child: Center(child: Text("左上角200*100范围内非文本区域点击")),
            ),
            onPointerDown: (event) => print("down1"),
            // behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
          ),
          Listener(
            child: AbsorbPointer(
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 50.0,
                ),
                onPointerDown: (event) => print("AbsorbPointer in"),
              ),
            ),
            onPointerDown: (event) => print("AbsorbPointer up"),
          ),
          Listener(
            child: IgnorePointer(
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 50.0,
                ),
                onPointerDown: (event) => print("IgnorePointer in"),
              ),
            ),
            onPointerDown: (event) => print("IgnorePointer up"),
          )
        ],
      ),
    );
  }
}
