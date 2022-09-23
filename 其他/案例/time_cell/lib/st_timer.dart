import 'dart:async';
import 'package:flutter/material.dart';

class STTimer extends StatefulWidget {
  final int current;
  const STTimer({Key? key, required this.current}) : super(key: key);

  @override
  State<STTimer> createState() => _STTimerState();
}

class _STTimerState extends State<STTimer> {
  var a = 0;
  static Timer _timer = Timer as Timer;
  @override
  void initState() {
    super.initState();
    a = widget.current;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (e) {
      if (a > 0) {
        setState(() {
          a -= 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(a > 0 ? '还剩下$a秒' : '活动已结束'),
    );
  }
}
