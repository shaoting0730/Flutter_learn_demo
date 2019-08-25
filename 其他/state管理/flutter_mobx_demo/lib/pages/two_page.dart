import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../mobx/counter.dart';

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('222222'),
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
