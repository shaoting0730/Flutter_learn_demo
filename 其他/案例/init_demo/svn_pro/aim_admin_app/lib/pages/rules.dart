import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  Rules({Key key}) : super(key: key);

  @override
  _RulesState createState() => new _RulesState();
}

class _RulesState extends State<Rules> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('客户管理'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMyCustomers(context),
          ],
        ),
      ),
    );
  }

  _buildMyCustomers(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("我的客户"),
          Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              margin: const EdgeInsets.only(top: 5),
              child: Column(children: [
              ]))
        ]));
  }
}
