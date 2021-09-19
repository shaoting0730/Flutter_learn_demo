import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final Color? color;
  final double width;
  final double height;
  final Function onclick;
  const MyBtn(
      {Key? key,
      this.color = Colors.pinkAccent,
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
      ),
    );
  }
}
