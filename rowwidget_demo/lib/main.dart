import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('rowwidget')),
        body: Row(
          children: <Widget>[
            new RaisedButton(
              onPressed: (){},
              color: Colors.blue,
              child: Text('blue'),
            ),
            Expanded(child: new RaisedButton(
              onPressed: (){},
              color: Colors.red,
              child: Text('red'),
            ),),
            new RaisedButton(
              onPressed: (){},
              color: Colors.blue,
              child: Text('blue'),
            ),
          ],
        )
      )
    );
  }
}

