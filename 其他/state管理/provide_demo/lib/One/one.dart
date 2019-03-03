import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:provide_demo/model/counter.dart';

class One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('One')),
      body: Padding(
        padding: EdgeInsets.only(top: 400.0,left: 200.0),
        child: Column(
          children: <Widget>[
            Provide<Counter>(
              builder: (context, child, counter) {
                return Text(
                  '${counter.value}',
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Provide.value<Counter>(context).increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
