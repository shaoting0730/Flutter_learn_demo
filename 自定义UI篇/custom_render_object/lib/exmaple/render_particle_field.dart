import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'particle_controller.dart';

class RenderParticleField extends RenderBox {
  RenderParticleField({required ParticleController controller}) : _controller = controller;

  ParticleController _controller;

  set controller(ParticleController c) {
    _controller = c;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final size = this.size;

    for (final p in _controller.particles) {
      final pos = Offset(offset.dx + p.pos.dx * size.width, offset.dy + p.pos.dy * size.height);

      final paint = Paint()
        ..color = Colors.white.withOpacity(p.brightness)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, 2 + p.brightness * 2, paint);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return true;
  }
}
