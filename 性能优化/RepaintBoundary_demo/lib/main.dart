import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _addAction() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const BasicPaintPage(),
            InkWell(
              onTap: () => _addAction(),
              child: Text('$_counter'),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicPaintPage extends StatelessWidget {
  const BasicPaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: BackgroundPainter(),
      ),
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return CustomPaint(
  //     painter: BackgroundPainter(),
  //   );
  // }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint一次');
    canvas.drawColor(const Color(0xFFF1F1F1), BlendMode.color);
    var center = size / 2;
    var paint = Paint()..color = const Color(0xFF2080E5);
    paint.strokeWidth = 2.0;
    canvas.drawRect(
      const Rect.fromLTWH(0, 20, 100, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
