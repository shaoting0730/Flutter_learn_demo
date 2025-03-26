/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-03-26 11:46:46
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-03-26 13:50:32
 * @FilePath: /f2c/lib/child_widget2.dart
 * @Description: 子组件2
 */
import 'package:flutter/material.dart';

class ChildWidget2 extends StatefulWidget {
  final Function(VoidCallback) addAction;
  const ChildWidget2({super.key, required this.addAction});

  @override
  State<ChildWidget2> createState() => _ChildWidget2State();
}

class _ChildWidget2State extends State<ChildWidget2> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    widget.addAction(() {
      add();
    });
  }

  add() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_count.toString());
  }
}
