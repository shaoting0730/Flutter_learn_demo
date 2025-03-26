/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-03-26 11:46:29
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-03-26 13:43:45
 * @FilePath: /f2c/lib/father_widget1.dart
 * @Description: 父组件1
 */
import 'package:f2c/one/child_widget1.dart';
import 'package:flutter/material.dart';

class FatherWidget1 extends StatefulWidget {
  const FatherWidget1({super.key});

  @override
  State<FatherWidget1> createState() => _FatherWidget1State();
}

class _FatherWidget1State extends State<FatherWidget1> {
  GlobalKey childWidget1Key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('父组件1'),
        ElevatedButton(
          onPressed: () {
            (childWidget1Key.currentState as ChildWidget1State).add();
          },
          child: const Text('点击+1'),
        ),
        ChildWidget1(
          key: childWidget1Key,
        ),
        Divider(),
      ],
    );
  }
}
