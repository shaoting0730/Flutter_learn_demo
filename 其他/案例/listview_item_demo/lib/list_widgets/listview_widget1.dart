import 'package:flutter/material.dart';

class ListViewWidget1 extends StatefulWidget {
  const ListViewWidget1({Key? key}) : super(key: key);

  @override
  State<ListViewWidget1> createState() => _ListViewWidget1State();
}

class _ListViewWidget1State extends State<ListViewWidget1> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AnimationWidget(
          duration: 900,
          child: Container(
            height: 90.0,
            decoration: const BoxDecoration(color: Colors.red),
            child: const Text('11111'),
          ),
        ),
        AnimationWidget(
          duration: 1100,
          child: Container(
            height: 200.0,
            decoration: const BoxDecoration(color: Colors.yellow),
            child: const Text('222222'),
          ),
        ),
        AnimationWidget(
          duration: 1300,
          child: Container(
            height: 500.0,
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: const Text('3333333'),
          ),
        ),
      ],
    );
  }
}

class AnimationWidget extends StatefulWidget {
  final Widget child;
  final int duration;

  const AnimationWidget({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    _animation = Tween(
      begin: const Offset(0, 8),
      end: const Offset(0, 0),
    ).animate(_controller);

    Future.delayed(Duration.zero, () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
