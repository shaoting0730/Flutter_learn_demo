import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
var stack = new Stack(
   alignment: const FractionalOffset(0.5, 0.8),
   children: <Widget>[
     new CircleAvatar(
       backgroundImage: new NetworkImage('https://ws1.sinaimg.cn/large/610dc034ly1fiednrydq8j20u011itfz.jpg'),
       radius: 100.0,
     ),
     new Positioned(
       top: 10.0,
       left: 10.0,
       child: new Text('position'),
     ),
     new Positioned(
       bottom: 40.0,
       left: 40.0,
       child: new Text('定位'),
     ),
   ],
);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('position')),
        body: Center(
          child: stack,
        ),
      )
    );
  }
}

