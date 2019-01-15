import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
    /**
   * Column({
   *  ...  
   *  TextDirection textDirection,    
   *  MainAxisSize mainAxisSize = MainAxisSize.max,    
   *  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
   *  VerticalDirection verticalDirection = VerticalDirection.down,  
   *  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
   *  List<Widget> children = const <Widget>[],
   *   })
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(title: Text('垂直布局')),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 自身元素对齐
            mainAxisAlignment: MainAxisAlignment.center, // 主轴对齐
            children: <Widget>[
              Text('我是Flutter的ColumnWidget'),
              Expanded(child:Text('crossAxisAlignment:自身元素对齐')),
              Text('mainAxisAlignment:主轴对齐方向'),
            ],
          ),
        ));
  }
}
