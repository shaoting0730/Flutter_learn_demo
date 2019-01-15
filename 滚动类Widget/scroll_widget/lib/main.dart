import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*
   * 
   *  Scrollable({
   *  ...
   *  this.axisDirection = AxisDirection.down,
   *  this.controller,
   *  this.physics,
   *  @required this.viewportBuilder, //后面介绍
   *   }) 
   */
  /*
   *   SingleChildScrollView({
   *   this.scrollDirection = Axis.vertical, //滚动方向，默认是垂直方向
   *   this.reverse = false, 
   *   this.padding, 
   *   bool primary, 
   *   this.physics, 
   *   this.controller,
   *   this.child,
   *  })
   */
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo222',
      home: Scaffold(
        appBar: AppBar(title: Text('Scroll')),
        body: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: str.split("")
                      .map((c)=>Text(c,textScaleFactor:2.0))
                      .toList()
              ),
            ),
          ),
        ),
      ),
    );
  }
}
