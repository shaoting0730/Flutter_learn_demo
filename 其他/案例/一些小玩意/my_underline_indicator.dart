
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class UnderlineDecoration extends Decoration {
  final Color color;
  final double? thickness;
  final double? length;
  final ui.Image? image;

  const UnderlineDecoration(
      {required this.color, this.thickness, this.length, this.image});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(
        color: color, thickness: thickness, length: length, image: image);
  }
}

class _UnderlinePainter extends BoxPainter {
  final Paint _paint;
  final double _thickness;
  final double _length;
  final ui.Image? _image;

  _UnderlinePainter(
      {required Color color,
      double? thickness,
      double? length,
      ui.Image? image})
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        _thickness = thickness ?? 1.0,
        _length = length ?? 20.w,
        _image = image;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(
          offset.dx + (configuration.size!.width - _length) / 2,
          configuration.size!.height - _thickness,
        ) &
        Size(_length, _thickness);
    RRect rRect =
        RRect.fromRectAndRadius(rect, Radius.circular(_thickness / 2));
    if (_image == null) {
      canvas.drawRRect(rRect, _paint);
    } else {
      canvas.drawImage(
          _image,
          Offset(offset.dx + (configuration.size!.width - _length) / 2,
              configuration.size!.height - _thickness - 5),
          _paint);
    }
  }
}
