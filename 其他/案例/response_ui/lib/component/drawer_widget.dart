/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-05 10:27:05
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-05 10:27:31
 * @FilePath: /response_ui/lib/component/drawer_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(children: [ListTile(title: Text('Home'), onTap: () {}), ListTile(title: Text('Mine'), onTap: () {})]));
  }
}
