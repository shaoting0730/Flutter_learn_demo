import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//================================================
// Stack Widget
//================================================

class MyStack extends MultiChildRenderObjectWidget {
  const MyStack({super.key, required super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyStack();
  }
}

//================================================
// Positioned Widget
//================================================

class MyPositioned extends ParentDataWidget<MyStackParentData> {
  final double left;

  final double top;

  const MyPositioned({super.key, required this.left, required this.top, required super.child});

  @override
  void applyParentData(RenderObject renderObject) {
    final data = renderObject.parentData as MyStackParentData;

    bool needsLayout = false;

    if (data.left != left) {
      data.left = left;

      needsLayout = true;
    }

    if (data.top != top) {
      data.top = top;

      needsLayout = true;
    }

    if (needsLayout) {
      final parent = renderObject.parent;

      if (parent is RenderObject) {
        parent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => MyStack;
}

//================================================
// ParentData
// 保存 child 位置信息
//================================================

class MyStackParentData extends ContainerBoxParentData<RenderBox> {
  double left = 0;

  double top = 0;
}

//================================================
// RenderObject
//================================================

class RenderMyStack extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, MyStackParentData>, RenderBoxContainerDefaultsMixin<RenderBox, MyStackParentData> {
  // 创建 ParentData

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MyStackParentData) {
      child.parentData = MyStackParentData();
    }
  }

  //===========================
  // Layout
  //===========================

  @override
  void performLayout() {
    double width = 0;

    double height = 0;

    RenderBox? child = firstChild;

    while (child != null) {
      // 让 child 自己决定大小

      child.layout(constraints.loosen(), parentUsesSize: true);

      final data = child.parentData as MyStackParentData;

      width = width > data.left + child.size.width ? width : data.left + child.size.width;

      height = height > data.top + child.size.height ? height : data.top + child.size.height;

      child = childAfter(child);
    }

    // Stack 自己大小

    size = constraints.constrain(Size(width, height));
  }

  //===========================
  // Paint
  //===========================

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    while (child != null) {
      final data = child.parentData as MyStackParentData;

      context.paintChild(child, offset + Offset(data.left, data.top));

      child = childAfter(child);
    }
  }
}

