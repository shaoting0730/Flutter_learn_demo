/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-03-26 11:46:29
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-03-26 13:51:13
 * @FilePath: /f2c/lib/father_widget2.dart
 * @Description: 父组件1
 */
import 'package:f2c/two/child_widget2.dart';
import 'package:flutter/material.dart';

class FatherWidget2 extends StatefulWidget {
  const FatherWidget2({super.key});

  @override
  State<FatherWidget2> createState() => _FatherWidget2State();
}

class _FatherWidget2State extends State<FatherWidget2> {
  VoidCallback? addNum;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('父组件2'),
        ElevatedButton(
          onPressed: () {
            addNum?.call();
          },
          child: const Text('点击+1'),
        ),
        ChildWidget2(
          addAction: (add) => addNum = add,
        ),
        const Divider(),
      ],
    );
  }
}
