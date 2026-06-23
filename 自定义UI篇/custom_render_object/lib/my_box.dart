/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2026-06-23 10:55:10
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2026-06-23 10:55:13
 * @FilePath: /custom_render_object/lib/my_box.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';

class MyBox extends LeafRenderObjectWidget {
  const MyBox({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyBox();
  }
}

class RenderMyBox extends RenderBox {
  @override
  void performLayout() {
    size = const Size(200, 100);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(offset & size, Paint()..color = Colors.red);
  }
}
