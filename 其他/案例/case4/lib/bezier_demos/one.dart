import 'package:flutter/material.dart';

class One extends StatefulWidget {
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ClipPath(
          clipper: Demo(),
          child: Container(
            color: Colors.deepOrangeAccent,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}

class Demo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height - 50.0);

    var firstControlPoint = Offset(size.width * 0.5, size.height); // 控制点
    var firstEndPoint = Offset(size.width, size.height - 50.0); // 结束点

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height - 50.0);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
