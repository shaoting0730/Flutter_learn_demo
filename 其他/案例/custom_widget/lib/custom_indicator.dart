// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';

// class ImageTabIndicator extends Decoration {
//   final ImageProvider image;
//   final double width;
//   final double height;
//   final double paddingBottom;

//   const ImageTabIndicator({required this.image, required this.width, required this.height, this.paddingBottom = 0});

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _ImageTabIndicatorPainter(this, onChanged);
//   }
// }

// class _ImageTabIndicatorPainter extends BoxPainter {
//   final ImageTabIndicator decoration;

//   ImageStream? _imageStream;
//   ui.Image? _resolvedImage;

//   _ImageTabIndicatorPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

//   void _resolveImage(ImageConfiguration configuration) {
//     final ImageStream newStream = decoration.image.resolve(configuration);

//     if (_imageStream?.key == newStream.key) return;

//     _imageStream?.removeListener(imageLen);

//     _imageStream = newStream;
//     newStream.addListener(imageLen);
//   }

//   late var imageLen = ImageStreamListener(_imageListener);

//   void _imageListener(ImageInfo info, bool _) {
//     _resolvedImage = info.image;
//     onChanged?.call();
//   }

//   @override
//   void dispose() {
//     _imageStream?.removeListener(imageLen);
//     super.dispose();
//   }

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     _resolveImage(configuration);

//     if (_resolvedImage == null) return;

//     final image = _resolvedImage!;
//     final tabWidth = configuration.size!.width;

//     final dx = offset.dx + (tabWidth - decoration.width) / 2;
//     final dy = offset.dy + configuration.size!.height - decoration.height - decoration.paddingBottom;

//     final rect = Rect.fromLTWH(dx, dy, decoration.width, decoration.height);

//     paintImage(canvas: canvas, rect: rect, image: image, fit: BoxFit.fill);
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class UnderlineDecoration extends Decoration {
  final Color color;
  final double? thickness;
  final double? length;
  final ui.Image? image;

  const UnderlineDecoration({required this.color, this.thickness, this.length, this.image});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(color: color, thickness: thickness, length: length, image: image);
  }
}

class _UnderlinePainter extends BoxPainter {
  final Paint _paint;
  final double _thickness;
  final double _length;
  final ui.Image? _image;

  _UnderlinePainter({required Color color, double? thickness, double? length, ui.Image? image})
    : _paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill,
      _thickness = thickness ?? 1.0,
      _length = length ?? 20,
      _image = image;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(offset.dx + (configuration.size!.width - _length) / 2, configuration.size!.height - _thickness) & Size(_length, _thickness);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(_thickness / 2));
    if (_image == null) {
      canvas.drawRRect(rRect, _paint);
    } else {
      canvas.drawImage(_image, Offset(offset.dx + (configuration.size!.width - _length) / 2, configuration.size!.height - _thickness - 5), _paint);
    }
  }
}
