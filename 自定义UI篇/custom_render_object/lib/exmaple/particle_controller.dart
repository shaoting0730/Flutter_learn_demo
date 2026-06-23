import 'dart:math';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'particle.dart';

class ParticleController {
  ParticleController({required int count, required this.onUpdate}) {
    _init(count);
    _ticker = Ticker(_tick)..start();
  }

  final VoidCallback onUpdate;

  final List<Particle> particles = [];
  final Random _random = Random();

  late final Ticker _ticker;

  Offset pointer = Offset.zero;
  bool hasPointer = false;

  double _time = 0;

  void _init(int count) {
    particles.clear();

    for (int i = 0; i < count; i++) {
      particles.add(
        Particle(
          Offset(_random.nextDouble(), _random.nextDouble()),
          Offset((_random.nextDouble() - 0.5) * 0.002, (_random.nextDouble() - 0.5) * 0.002),
          _random.nextDouble(),
        ),
      );
    }
  }

  void _tick(Duration _) {
    _time += 0.016;
    _update();
    onUpdate();
  }

  void _update() {
    for (final p in particles) {
      p.pos += p.vel;

      if (p.pos.dx < 0 || p.pos.dx > 1) p.vel = Offset(-p.vel.dx, p.vel.dy);
      if (p.pos.dy < 0 || p.pos.dy > 1) p.vel = Offset(p.vel.dx, -p.vel.dy);

      if (hasPointer) {
        final dx = p.pos.dx - pointer.dx;
        final dy = p.pos.dy - pointer.dy;

        final d = sqrt(dx * dx + dy * dy);

        if (d < 0.2) {
          p.vel += Offset(dx, dy) * -0.0005;
          p.brightness = 1.0;
        } else {
          p.brightness *= 0.98;
        }
      }

      p.brightness = (p.brightness + 0.01).clamp(0.2, 1.0);
    }
  }

  void updatePointer(Offset local, Size size) {
    if (size == Size.zero) return;

    pointer = Offset(local.dx / size.width, local.dy / size.height);

    hasPointer = true;
  }

  void dispose() {
    _ticker.dispose();
  }
}
