import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<Polar> polar =
      ValueNotifier(Polar(len: 0.6, deg: 45 * pi / 180));

  Widget buildDiyChildLayout() {
    return CustomSingleChildLayout(
      delegate: PolarLayoutDelegate(polar: polar),
      child: const SizedBox(
        width: 20,
        height: 20,
        child: ColoredBox(
          color: Colors.blue,
          child: Center(
              child: Text(
            '子',
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    polar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ColoredBox(
                  color: Colors.orange.withOpacity(0.2),
                  child: buildDiyChildLayout(),
                ),
              ),
            ),
            buildTools()
          ],
        ),
      ),
    );
  }

  Widget buildTools() {
    return ValueListenableBuilder<Polar>(
      valueListenable: polar,
      builder: (_, Polar value, __) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Slider(
                value: value.deg,
                max: 2 * pi,
                min: 0,
                onChanged: (v) {
                  polar.value = Polar(len: value.len, deg: v);
                }),
          ),
          Expanded(
              flex: 1,
              child: Text("角度: ${(value.deg * 180 / pi).toStringAsFixed(1)}")),
          Expanded(
            flex: 2,
            child: Slider(
                value: value.len,
                max: 1,
                min: 0,
                onChanged: (v) {
                  polar.value = Polar(len: v, deg: value.deg);
                }),
          ),
          Expanded(child: Text("长度分率:${value.len.toStringAsFixed(1)}")),
        ],
      ),
    );
  }
}

class Polar {
  final double len;
  final double deg;

  Polar({required this.len, required this.deg});
}

class PolarLayoutDelegate extends SingleChildLayoutDelegate {
  final ValueListenable<Polar> polar;

  PolarLayoutDelegate({required this.polar}) : super(relayout: polar);

  @override
  bool shouldRelayout(covariant PolarLayoutDelegate oldDelegate) =>
      oldDelegate.polar != polar;

  @override
  Size getSize(BoxConstraints constraints) {
    final radius = constraints.biggest.shortestSide;
    return Size(radius, radius);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double r = size.width / 2 * polar.value.len;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset offset = Offset(r * cos(polar.value.deg), r * sin(polar.value.deg));
    Offset childSizeOffset = Offset(childSize.width / 2, childSize.height / 2);
    return center + offset - childSizeOffset;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }
}
