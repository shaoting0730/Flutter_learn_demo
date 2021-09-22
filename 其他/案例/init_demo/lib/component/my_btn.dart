import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final Color? color;
  final double width;
  final double height;
  final Function onclick;
  final Widget widget;
  const MyBtn(
      {Key? key,
      this.color = Colors.pinkAccent,
      this.widget = const Text(''),
      required this.width,
      required this.height,
      required this.onclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onclick(),
      child: Container(
        color: color,
        width: width,
        height: height,
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
