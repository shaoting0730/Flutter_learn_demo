import 'package:flutter/material.dart';
import './widgets/SliverAppBarDemo.dart';
import './widgets/NestedScrollViewDemo.dart';

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
      appBar: AppBar(title: Text('Sliver集合')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SliverAppBarDemo(),
                      ));
                },
                child: Text('SliverAppBar'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NestedScrollViewDemo(),
                      ));
                },
                child: Text('NestedScrollView'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
