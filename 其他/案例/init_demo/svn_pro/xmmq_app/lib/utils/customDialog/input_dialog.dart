/*
* 输入框
* */
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../serviceapi/baseapi.dart';
import '../../serviceapi/customerapi.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/api/goodsGroup.dart';

class InputDialog extends StatefulWidget {
  Function dismissCallback;
  Function okCallback;

  InputDialog({
    Key key,
    this.dismissCallback,
    this.okCallback,
  }) : super(key: key);
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  bool outsideDismiss;
  String commitStr;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
//    print('----- ${jsonEncode(model)}');
    _dismissDialog() {
      if (widget.dismissCallback != null) {
        widget.dismissCallback();
      }
      Navigator.of(context).pop();
    }

    _okCallback(String txt) {
      if (widget.okCallback != null) {
        widget.okCallback(txt);
      }
      Navigator.of(context).pop();
    }

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: _dismissDialog,
        child: Center(
          child: SizedBox(
            width: 250,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(13.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      cursorColor: Color.fromRGBO(187, 187, 187, 1),
                      onSubmitted: (e) {
                        setState(() {
                          commitStr = e;
                        });
                      },
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "输入供应商推荐码",
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      _okCallback(commitStr);
                    },
                    child: Container(
                      height: 50,
                      color: Color.fromRGBO(255, 175, 76, 1),
                      child: Center(
                        child: Text(
                          '绑 定',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
