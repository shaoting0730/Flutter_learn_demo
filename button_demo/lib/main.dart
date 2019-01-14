import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '按钮 button',
      home: Scaffold(
        appBar: AppBar(title: Text('按钮')),
        body: Padding(
          padding: new EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              // "漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
              RaisedButton(
                child: Text('RaisedButton'),
                onPressed: () {
                  print('RaisedButton');
                },
              ),
              // 扁平按钮，默认背景透明并不带阴影。按下后，会有背景色：
              FlatButton(
                child: Text('FlatButton'),
                onPressed: () {
                  print('FlatButton');
                },
              ),
              // 默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
              OutlineButton(
                child: Text('OutlineButton'),
                onPressed: () {
                  print('OutlineButton');
                },
              ),
              // IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
              IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  print('IconButton');
                },
              ),
              // 自定义按钮外观 FlatButton为例
              /**
               *  
               *  @required this.onPressed, //按钮点击回调
               *  this.textColor, //按钮文字颜色
               *  this.disabledTextColor, //按钮禁用时的文字颜色
               *  this.color, //按钮背景颜色
               *  this.disabledColor,//按钮禁用时的背景颜色
               *  this.highlightColor, //按钮按下时的背景颜色
               *  this.splashColor, //点击时，水波动画中水波的颜色
               * this.colorBrightness,//按钮主题，默认是浅色主题 
               * this.padding, //按钮的填充
               * this.shape, //外形
               * @required this.child, //按钮的内容
               */
              FlatButton(
                child: Text('自定义按钮外观'),
                color: Colors.pink,
                highlightColor: Colors.red[700],
                splashColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.00)),
                onPressed: () {
                  print('自定义样式外观');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
