import 'package:flutter/material.dart';

class ListViewWidget2 extends StatefulWidget {
  const ListViewWidget2({Key? key}) : super(key: key);

  @override
  State<ListViewWidget2> createState() => _ListViewWidget2State();
}

class _ListViewWidget2State extends State<ListViewWidget2> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 4), vsync: this)..forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SlidingBox(controller: controller, interval: Interval(0.0, 0.2), color: Colors.amber[100]!),
          SlidingBox(controller: controller, interval: Interval(0.2, 0.4), color: Colors.amber[300]!),
          SlidingBox(controller: controller, interval: Interval(0.4, 0.6), color: Colors.amber[500]!),
          SlidingBox(controller: controller, interval: Interval(0.6, 0.8), color: Colors.amber[700]!),
          SlidingBox(controller: controller, interval: Interval(0.8, 1.0), color: Colors.amber[900]!),
        ],
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  const SlidingBox({Key? key, required this.controller, required this.color, required this.interval}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(
        begin: Offset.zero,
        end: Offset(0.1, 0),
      )
          .chain(
            CurveTween(curve: Curves.bounceOut),
          )
          .chain(
            CurveTween(curve: interval),
          )
          .animate(controller),
      child: Container(
        width: 300,
        height: 100,
        color: color,
      ),
    );
  }
}
