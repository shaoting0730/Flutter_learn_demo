import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================
// Widget
// ============================

class MyRow extends MultiChildRenderObjectWidget {
  final double spacing;

  MyRow({super.key, this.spacing = 0, required List<Widget> children}) : super(children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyRow(spacing);
  }
}

// ============================
// ParentData
// 保存 child 布局信息
// ============================

class MyRowParentData extends ContainerBoxParentData<RenderBox> {}

// ============================
// RenderObject
// ============================

class RenderMyRow extends RenderBox with ContainerRenderObjectMixin<RenderBox, MyRowParentData>, RenderBoxContainerDefaultsMixin<RenderBox, MyRowParentData> {
  double spacing;

  RenderMyRow(this.spacing);

  // 创建 ParentData

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MyRowParentData) {
      child.parentData = MyRowParentData();
    }
  }

  // ==========================
  // Layout
  // ==========================

  @override
  void performLayout() {
    double width = 0;

    double height = 0;

    RenderBox? child = firstChild;

    // 第一遍:
    // 测量所有 child

    while (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);

      final childSize = child.size;

      width += childSize.width;

      height = height > childSize.height ? height : childSize.height;

      child = childAfter(child);
    }

    // 加 spacing

    final count = childCount;

    width += spacing * (count - 1);

    size = constraints.constrain(Size(width, height));

    // 第二遍:
    // 设置 child 位置

    double dx = 0;

    child = firstChild;

    while (child != null) {
      final parentData = child.parentData as MyRowParentData;

      parentData.offset = Offset(dx, 0);

      dx += child.size.width;

      dx += spacing;

      child = childAfter(child);
    }
  }

  // ==========================
  // Paint
  // ==========================

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
