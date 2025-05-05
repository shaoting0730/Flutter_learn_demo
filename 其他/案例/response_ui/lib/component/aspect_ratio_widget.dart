/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-05 10:15:07
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-05 11:37:51
 * @FilePath: /response_ui/lib/component/aspect_ratio_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class AspectRatioWidget extends StatefulWidget {
  const AspectRatioWidget({super.key});

  @override
  State<AspectRatioWidget> createState() => _AspectRatioWidgetState();
}

class _AspectRatioWidgetState extends State<AspectRatioWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9, child: Container(width: double.infinity, color: Colors.red));
  }
}
