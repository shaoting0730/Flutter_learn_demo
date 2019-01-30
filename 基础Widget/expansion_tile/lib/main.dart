import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar:AppBar(title: Text('')),
        body: ExpansionTileDemo(),
      ),
    );
  }
}

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
         title: Text('ExpansionTile Title'),
         leading: Icon(Icons.ac_unit),
         backgroundColor: Colors.white12,
         children: <Widget>[
           Text('subTitle'),
         ],
         initiallyExpanded: false,  // 默认是否打开
    );
  }
}
