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
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.access_alarms),
              title: new Text('access_alarms'),
            ),
             new ListTile(
              leading: new Icon(Icons.satellite),
              title: new Text('satellite'),
            ),
            new ListTile(
              leading: new Icon(Icons.ac_unit),
              title: new Text('ac_unit'),
            ),
            new Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fymj13tnjmj30r60zf79k.jpg',
              width: 150,
              height: 300,
            ),
            new Image.network('https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg')

          ],
        ),
      )
    );
  }
}

