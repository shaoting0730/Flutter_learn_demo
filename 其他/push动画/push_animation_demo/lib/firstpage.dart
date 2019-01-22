import 'package:flutter/material.dart';
import 'secondpage.dart';
import 'custom_route.dart';

class FirstPage extends StatefulWidget {
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: Text('FirstPage')),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_next,
            color:Colors.white,
            size: 64.0,
          ),
          onPressed: (){
            Navigator.push(context, CustomRoute(SecondPage()));
          },
        ),
      ),
    );
  }
}