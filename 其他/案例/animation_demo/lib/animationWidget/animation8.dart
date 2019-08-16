import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../animationWidget/customDialog/custom_dialog.dart';

class Animation8 extends StatefulWidget {
  @override
  _Animation8State createState() => _Animation8State();
}

class _Animation8State extends State<Animation8> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return new CustomDialog(
                        dismissCallback: () {
                          print("取消了");
                        },
                        okCallback: () {
                          print("确定了");
                        },
                      );
                    });
              },
              child: Text('点击'),
            ),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
          ],
        ),
      ],
    );
  }
}
