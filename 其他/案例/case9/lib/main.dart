import 'package:flutter/material.dart';
import 'package:sliver_widgets/widgets/SliverDemo1.dart';
import 'package:sliver_widgets/widgets/SliverHeader.dart';
import './widgets/SliverAppBarDemo.dart';
import './widgets/NestedScrollViewDemo.dart';
import './widgets/SliverGridDemo.dart';
import './widgets/SliverListDemo.dart';
import './widgets/StickyDemo.dart';

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
                child: Text('SliverAppBar + SliverFixedExtentList'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NestedScrollViewDemo(),
                      ));
                },
                child: Text('NestedScrollView + SliverOverlapAbsorber'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SliverGridDemo(),
                      ));
                },
                child: Text('SliverGrid + SliverPadding + SliverSafeArea '),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SliverListDemo(),
                      ));
                },
                child: Text('SliverList'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StickyDemo(),
                      ));
                },
                child: Text('StickyDemo'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SliverPersistentHeaderDemo(),
                      ));
                },
                child: Text('SliverPersistentHeaderDemo'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SliverDemo1(),
                      ));
                },
                child: Text('下拉放大'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
