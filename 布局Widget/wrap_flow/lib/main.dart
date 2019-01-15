import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /*
   *
   *  Wrap({
   *  ...
   *  this.direction = Axis.horizontal,
   *  this.alignment = WrapAlignment.start,
   *  this.spacing = 0.0,
   *  this.runAlignment = WrapAlignment.start,
   *  this.runSpacing = 0.0,
   *  this.crossAxisAlignment = WrapCrossAlignment.start,
   *  this.textDirection,
   *  this.verticalDirection = VerticalDirection.down,
   *  List<Widget> children = const <Widget>[],
   *   })
   *
   *  Flow
   *  优点: 1性能好  2灵活
   *  缺点: 使用复杂,不能自适应子widget大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(title: Text('Flow')),
          body: Column(
            children: <Widget>[
              // 不使用wrap 
              Row(
                children: <Widget>[
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('A')),
                    label: new Text('Hamilton'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('M')),
                    label: new Text('Lafayette'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('H')),
                    label: new Text('Mulligan'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('J')),
                    label: new Text('Laurens'),
                  ),
                ],
              ),
              // 使用wrap
              Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                runSpacing: 4.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: <Widget>[
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('A')),
                    label: new Text('Hamilton'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('M')),
                    label: new Text('Lafayette'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('H')),
                    label: new Text('Mulligan'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.blue, child: Text('J')),
                    label: new Text('Laurens'),
                  ),
                ],
              ),
              Flow(
                delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
                children: <Widget>[
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.red,
                  ),
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.green,
                  ),
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.blue,
                  ),
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.yellow,
                  ),
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.brown,
                  ),
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.purple,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
      }
      x += context.getChildSize(i).width + margin.left + margin.right;
    }
  }

  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
