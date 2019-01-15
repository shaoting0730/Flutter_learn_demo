/**
 * 横向ListView 
 * 分开组件
 */
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: new AppBar(title: new Text('ListView')),
          body: Center(
            child: Container(
              height: 200.0,
              child: MyList(),
            ),
          ),
        ));
  }
}

class MyList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 180.0,
          color: Colors.red,
        ),
        new Container(
          width: 180.0,
          color: Colors.yellow,
        ),
        new Container(
          width: 180.0,
          color: Colors.pink,
        ),
        new Container(
          width: 200.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}
