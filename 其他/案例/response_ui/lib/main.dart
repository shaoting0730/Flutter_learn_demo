/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-03 18:00:00
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-05 11:25:06
 * @FilePath: /response_ui/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:response_ui/response.dart';
import 'package:response_ui/response_ui/desktop_layout.dart';
import 'package:response_ui/response_ui/mobile_layout.dart';
import 'package:response_ui/response_ui/tablet_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 响应式布局演示',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: const ResponsiveLayoutExample(),
    );
  }
}

class ResponsiveLayoutExample extends StatefulWidget {
  const ResponsiveLayoutExample({super.key});

  @override
  State<ResponsiveLayoutExample> createState() => _ResponsiveLayoutExampleState();
}

class _ResponsiveLayoutExampleState extends State<ResponsiveLayoutExample> {
  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: const MobileLayout(), tablet: const TabletLayout(), desktop: const DesktopLayout(),);
  }
}
