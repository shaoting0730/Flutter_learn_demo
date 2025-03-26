/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-03-26 11:46:46
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-03-26 13:25:04
 * @FilePath: /f2c/lib/child_widget1.dart
 * @Description: 子组件2
 */
import 'package:flutter/material.dart';

class ChildWidget1 extends StatefulWidget {
  const ChildWidget1({super.key});

  @override
  State<ChildWidget1> createState() => ChildWidget1State();
}

class ChildWidget1State extends State<ChildWidget1> {
  int _count = 0;
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
