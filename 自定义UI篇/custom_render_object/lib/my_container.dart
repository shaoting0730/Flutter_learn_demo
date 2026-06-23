/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2026-06-23 11:02:12
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2026-06-23 11:05:00
 * @FilePath: /custom_render_object/lib/my_container.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


// ================================
// Widget 层
// ================================

class MyContainer extends SingleChildRenderObjectWidget {
  final EdgeInsets padding;

  final Color color;

  const MyContainer({super.key, this.padding = EdgeInsets.zero, this.color = Colors.blue, Widget? child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyContainer(padding, color);
  }

  @override
  void updateRenderObject(BuildContext context, RenderMyContainer renderObject) {
    renderObject
      ..padding = padding
      ..color = color;
  }
}

// ================================
// RenderObject 层
// ================================

class RenderMyContainer extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  EdgeInsets _padding;

  Color _color;

  RenderMyContainer(this._padding, this._color);

  set padding(EdgeInsets value) {
    if (_padding != value) {
      _padding = value;

      markNeedsLayout();
    }
  }

  set color(Color value) {
    if (_color != value) {
      _color = value;

      markNeedsPaint();
    }
  }

  // -------------------------------
  // Layout
  // -------------------------------

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints.deflate(_padding), parentUsesSize: true);

      final childData = child!.parentData as BoxParentData;

      childData.offset = Offset(_padding.left, _padding.top);
    }

    final childSize = child?.size ?? Size.zero;

    size = constraints.constrain(Size(childSize.width + _padding.horizontal, childSize.height + _padding.vertical));
  }

  // -------------------------------
  // Paint
  // -------------------------------

  @override
  void paint(PaintingContext context, Offset offset) {
    // 1. 绘制自己的背景

    context.canvas.drawRect(offset & size, Paint()..color = _color);

    // 2. 绘制 child

    if (child != null) {
      final childData = child!.parentData as BoxParentData;

      context.paintChild(child!, offset + childData.offset);
    }
  }
}
