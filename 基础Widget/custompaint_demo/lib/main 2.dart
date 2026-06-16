import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 320,
            height: 220,
            child: CustomPaint(
              isComplex: true,
              willChange: true,
              painter: MyPainter(
                progress: _progress,
                baseColor: Colors.indigo,
                accentColor: Colors.cyanAccent,
                showGrid: true,
              ),
              foregroundPainter: MyForegroundPainter(progress: _progress),
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'CustomPaint Demo\n背景 + 子组件 + 前景',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, height: 1.4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({
    required this.progress,
    this.baseColor = Colors.indigo,
    this.accentColor = Colors.cyanAccent,
    this.showGrid = true,
  }) : super(repaint: progress);

  final Listenable progress;
  final Color baseColor;
  final Color accentColor;
  final bool showGrid;

  double get _t => progress is Animation<double> ? (progress as Animation<double>).value : 0;

  @override
  void paint(Canvas canvas, Size size) {
    final t = _t;
    final bgRect = Offset.zero & size;

    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(baseColor, accentColor, t * 0.6)!,
          Color.lerp(baseColor.withValues(alpha: 0.4), accentColor, t)!,
        ],
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    if (showGrid) {
      _drawGrid(canvas, size, t);
    }
    _drawWave(canvas, size, t);
    _drawRings(canvas, size, t);
  }

  void _drawGrid(Canvas canvas, Size size, double t) {
    const step = 24.0;
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;

    final offset = (t * step) % step;
    for (double x = -offset; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = -offset; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawWave(Canvas canvas, Size size, double t) {
    final path = Path();
    final waveHeight = size.height * 0.12;
    final baseY = size.height * 0.65;

    path.moveTo(0, baseY);
    for (double x = 0; x <= size.width; x += 2) {
      final y = baseY + math.sin((x / size.width * 2 * math.pi) + (t * 2 * math.pi)) * waveHeight;
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final wavePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [accentColor.withValues(alpha: 0.35), accentColor.withValues(alpha: 0.05)],
      ).createShader(Offset.zero & size);

    canvas.drawPath(path, wavePaint);
  }

  void _drawRings(Canvas canvas, Size size, double t) {
    final center = Offset(size.width * 0.75, size.height * 0.28);
    for (int i = 0; i < 3; i++) {
      final radius = 30.0 + i * 18 + t * 12;
      final ringPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5 - i * 0.5
        ..color = Colors.white.withValues(alpha: 0.25 - i * 0.05);
      canvas.drawCircle(center, radius, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.baseColor != baseColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.progress != progress;
  }
}

class MyForegroundPainter extends CustomPainter {
  MyForegroundPainter({required this.progress}) : super(repaint: progress);

  final Listenable progress;

  double get _t => progress is Animation<double> ? (progress as Animation<double>).value : 0;

  @override
  void paint(Canvas canvas, Size size) {
    final scanY = size.height * _t;
    final scanPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.white.withValues(alpha: 0.15), Colors.transparent],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, scanY - 20, size.width, 40));

    canvas.drawRect(Rect.fromLTWH(0, scanY - 20, size.width, 40), scanPaint);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withValues(alpha: 0.35);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(1, 1, size.width - 2, size.height - 2), const Radius.circular(16)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant MyForegroundPainter oldDelegate) => oldDelegate.progress != progress;
}
