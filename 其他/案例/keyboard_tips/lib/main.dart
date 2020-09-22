import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*
*  键盘缩回 
* https://segmentfault.com/a/1190000021314427
* https://www.cnblogs.com/LiuPan2016/p/10347423.html
* https://www.jianshu.com/p/f6b994fdb9fb
*
* */
// 监听键盘弹出  https://segmentfault.com/a/1190000022495736

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  FocusNode nodeOne = FocusNode();

  // 输入框的焦点实例
  FocusNode _focusNode = FocusNode();
  // 当前键盘是否是激活状态
  bool isKeyboardActived = false;

  @override
  void initState() {
    super.initState();
    // 监听输入框焦点变化
    _focusNode.addListener(_onFocus);
    // 创建一个界面变化的观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNode.hasFocus) {
        // 在焦点聚焦的情况下

        if (isKeyboardActived) {
          setState(() {
            isKeyboardActived = false;
          });
          // 使输入框失去焦点
          _focusNode.unfocus();
        } else {
          setState(() {
            isKeyboardActived = true;
          });
        }
      }
    });
  }

  // 既然有监听当然也要有卸载，防止内存泄漏嘛
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // 焦点变化时触发的函数
  _onFocus() {
    if (_focusNode.hasFocus) {
      // 聚焦时候的操作
      return;
    }

    // 失去焦点时候的操作
    setState(() {
      isKeyboardActived = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('keyboard tips'),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: '名字'),
                        focusNode: nodeOne,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(nodeOne);
                      },
                      child: Text('弹起'),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(hintText: '密码'),
                focusNode: _focusNode,
                textInputAction: TextInputAction.done,
              ),
              Text('密码键盘是否弹出$isKeyboardActived')
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
