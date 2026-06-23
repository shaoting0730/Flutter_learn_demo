import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//================================================
// Stack Widget
//================================================

class MyHitTestStack extends MultiChildRenderObjectWidget {
  const MyHitTestStack({super.key, required super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyHitTestStack();
  }
}

//================================================
// ParentData
//================================================

class MyHitTestStackParentData extends ContainerBoxParentData<RenderBox> {
  double left = 0;
  double top = 0;

  String name = "";
}

//================================================
// RenderStack（核心）
//================================================

class RenderMyHitTestStack extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, MyHitTestStackParentData>, RenderBoxContainerDefaultsMixin<RenderBox, MyHitTestStackParentData> {
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MyHitTestStackParentData) {
      child.parentData = MyHitTestStackParentData();
    }
  }

  //========================
  // Layout
  //========================

  @override
  void performLayout() {
    double maxW = 0;
    double maxH = 0;

    RenderBox? child = firstChild;

    while (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);

      final data = child.parentData as MyHitTestStackParentData;

      maxW = maxW > data.left + child.size.width ? maxW : data.left + child.size.width;

      maxH = maxH > data.top + child.size.height ? maxH : data.top + child.size.height;

      child = childAfter(child);
    }

    size = constraints.constrain(Size(maxW, maxH));
  }

  //========================
  // Paint
  //========================

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    while (child != null) {
      final data = child.parentData as MyHitTestStackParentData;

      context.paintChild(child, offset + Offset(data.left, data.top));

      child = childAfter(child);
    }
  }

  //========================
  // HIT TEST（收集命中）
  //========================

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = lastChild;

    bool hit = false;

    while (child != null) {
      final data = child.parentData as MyHitTestStackParentData;

      final childPosition = position - Offset(data.left, data.top);

      if (child.hitTest(result, position: childPosition)) {
        hit = true;
      }

      child = childBefore(child);
    }

    return hit;
  }

  //========================
  // POINTER EVENT（关键）
  //========================

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    if (event is PointerDownEvent) {
      _dispatchTap(entry, event.position);
    }
  }

  //========================
  // 手动广播点击
  //========================

  void _dispatchTap(HitTestEntry entry, Offset globalPosition) {
    RenderBox? child = firstChild;

    while (child != null) {
      final data = child.parentData as MyHitTestStackParentData;

      final rect = Offset(data.left, data.top) & child.size;

      if (rect.contains(globalPosition)) {
        debugPrint("${data.name} CLICKED");
      }

      child = childAfter(child);
    }
  }
}
