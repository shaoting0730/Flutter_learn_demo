/*
* 输入框
* */

import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  Function dismissCallback; // 取消回调
  Function okCallback; // 确认回调
  bool isNeedTag; // 外部传入的参数,控制显示slide还是input

  CustomDialog({
    Key key,
    this.dismissCallback,
    this.okCallback,
    this.isNeedTag,
  }) : super(key: key);
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String commitStr;
  double slideValue = 0.0;

  /*
  * 取消按钮点击事件
  * */
  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  /*
  * 确定按钮点击事件
  * */
  _okCallback(String txt) {
    if (widget.okCallback != null) {
      widget.okCallback(txt);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 240,
          height: 240,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(120.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                widget.isNeedTag == true ? _topWidget() : _topWidget1(),
                Spacer(),
                _bottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  * 上方输入UI
  * */
  Widget _topWidget() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Container(
        child: TextField(
          onSubmitted: (e) {
            setState(() {
              commitStr = e;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "请输入字符",
          ),
        ),
      ),
    );
  }

  /*
  * 上方输入UI-1
  * */
  Widget _topWidget1() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Slider(
        value: slideValue,
        max: 100.0,
        min: 0.0,
        activeColor: Colors.blue,
        onChanged: (double val) {
          setState(() {
            slideValue = val;
            commitStr = val.toString();
          });
        },
      ),
    );
  }

  /*
  * 底部选择widget
  * */
  Widget _bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () {
            _okCallback(commitStr);
          },
          child: Container(
            height: 50,
            width: 120,
            color: Colors.yellow[800],
            child: Center(
              child: Text(
                '确定',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _dismissDialog();
          },
          child: Container(
            height: 50,
            width: 120,
            color: Colors.red[800],
            child: Center(
              child: Text(
                '取消',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
