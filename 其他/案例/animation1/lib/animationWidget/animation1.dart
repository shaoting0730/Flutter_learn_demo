import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Animation1 extends StatefulWidget {
  @override
  _Animation1State createState() => _Animation1State();
}

class _Animation1State extends State<Animation1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    // .. 联级运算符 等同于
    /*
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addListener(() {
      setState(() {
        // the animation object’s value is the changed state
      });
    });
    */

    controller.forward();
  }

  // 防止内存泄露
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
