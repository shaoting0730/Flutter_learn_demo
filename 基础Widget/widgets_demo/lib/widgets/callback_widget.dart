import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallBackWidget extends StatefulWidget {
  @override
  _CallBackWidgetState createState() => _CallBackWidgetState();
}

class _CallBackWidgetState extends State<CallBackWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('演示回调和监听')),
      body: Column(
        children: <Widget>[
          // 点击回调
          InkWell(
            onTap: () {
              Navigator.pop(context, '123456789艹');
            },
            child: Text('回调演示'),
          ),
          // 点击导航条返回并回调
          Container(
            child: WillPopScope(
              onWillPop: () {
                Navigator.pop(context, '123456789艹艹');
                return Future.value(false);
              },
              child: Text(''),
            ),
            height: 0,
            width: 0,
          ),
        ],
      ),
    );
  }
}
