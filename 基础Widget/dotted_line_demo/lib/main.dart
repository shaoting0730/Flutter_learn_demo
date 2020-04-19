import 'package:flutter/material.dart';
import './dotted_line.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                height: 1,
                width: 200,
                child: DashedRect(
                  color: Colors.red,
                  strokeWidth: 0.5,
                  gap: 3.0,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 80.0,
                child: DashedRect(
                  color: Colors.black,
                  strokeWidth: 4.5,
                  gap: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
