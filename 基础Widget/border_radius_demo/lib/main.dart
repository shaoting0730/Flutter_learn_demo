import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BorderRadiusDemo(),
    );
  }
}

class BorderRadiusDemo extends StatelessWidget {
  final Widget child;

  BorderRadiusDemo({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('切圆'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // ClipOval
          ClipOval(
            child: Image.asset(
              'images/cute.jpeg',
              width: 100.0,
              height: 100.0,
            ),
          ),

          // CircleAvatar
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('images/cute.jpeg'),
          ),

          // BoxDecoration BoxShape.circle
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('images/cute.jpeg'))),
          ),

          // ClipRRect
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: new Image.asset(
              'images/cute.jpeg',
              width: 100.0,
              height: 100.0,
            ),
          ),

          //BoxDecoration BoxShape.rectangle
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100.0),
              image: DecorationImage(
                image: AssetImage(
                  'images/cute.jpeg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
