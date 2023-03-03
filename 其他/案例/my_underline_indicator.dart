import 'package:flutter/material.dart';

class UnderlineDecoration extends Decoration {
  final Color color;
  final double? thickness;
  final double? length;

  UnderlineDecoration({required this.color, this.thickness, this.length});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(color: color, thickness: thickness, length: length);
  }
}

class _UnderlinePainter extends BoxPainter {
  final Paint _paint;
  final double _thickness;
  final double _length;

  _UnderlinePainter({required Color color, double? thickness, double? length})
      : _paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill,
        _thickness = thickness ?? 1.0,
        _length = length ?? 20.0;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(
      offset.dx + (configuration.size!.width - _length) / 2,
      configuration.size!.height - _thickness,
    ) &
    Size(_length, _thickness);

    canvas.drawRect(rect, _paint);
  }
}
