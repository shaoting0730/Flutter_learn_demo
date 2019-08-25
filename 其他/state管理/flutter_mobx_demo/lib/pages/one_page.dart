import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../mobx/counter.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('111111'),
      ),
      body: ListView(
        children: <Widget>[
          Observer(
            builder: (_) => Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.display1,
                ),
          ),
          RaisedButton(
            child: Text('加'),
            onPressed: counter.increment,
          ),
          RaisedButton(
            child: Text('减'),
            onPressed: counter.decrement,
          ),
        ],
      ),
    );
  }
}
