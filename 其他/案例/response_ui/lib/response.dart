/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-03 18:50:00
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-04 16:21:35
 * @FilePath: /response_ui/lib/response.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({super.key, required this.mobile, this.tablet, this.desktop});

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1024 && MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1024) {
      return desktop!;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
