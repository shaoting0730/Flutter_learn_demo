import 'package:flutter/material.dart';
import 'package:stream_demo/rxdart_demo.dart';
import './stream_demo.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream')),
      body: ListView(
        children: <Widget>[
          FlatButton(
            child: Text('Stream'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => StreamDemo(),
            ));
            },
          ),
           FlatButton(
            child: Text('Rxdart'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => RxDartDemo(),
            ));
            },
          )
        ],
      ),
    );
  }
}

