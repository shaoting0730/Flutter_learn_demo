import 'package:flutter/material.dart';
import 'dart:async';

enum Option { A, B, C }

class SimpleDialogDemo extends StatefulWidget {
  @override
  _SimpleDialogDemoState createState() => _SimpleDialogDemoState();
}

class _SimpleDialogDemoState extends State<SimpleDialogDemo> {
  String _result = 'value';
  Future _openSimpleDialog() async {
    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('SimpleDialog'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Option A'),
                onPressed: () {
                  Navigator.pop(context, Option.A);
                },
              ),
              SimpleDialogOption(
                child: Text('Option B'),
                onPressed: () {
                  Navigator.pop(context, Option.B);
                },
              ),
              SimpleDialogOption(
                child: Text('Option C'),
                onPressed: () {
                  Navigator.pop(context, Option.C);
                },
              )
            ],
          );
        });
    switch (option) {
      case Option.A:
        setState(() {
          _result = 'Option A';
        });
        break;
      case Option.B:
        setState(() {
          _result = 'Option B';
        });
        break;
      case Option.C:
        setState(() {
          _result = 'Option C';
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SimpleDialogDemo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_result'),
            FlatButton(
                child: Text('SimpleDialogDemo'), onPressed: _openSimpleDialog),
          ],
        ),
      ),
    );
  }
}
