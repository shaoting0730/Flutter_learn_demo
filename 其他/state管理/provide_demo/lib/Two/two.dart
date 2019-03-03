import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:provide_demo/model/counter.dart';

class Two extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Two')),
      body: Center(
        child: Provide<Counter>(
          builder: (context, child, counter) {
            return Text(
              '${counter.value}',
            );
          },
        ),
      ),
    );
  }
}
