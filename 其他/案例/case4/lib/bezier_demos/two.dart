import 'package:flutter/material.dart';

class Two extends StatefulWidget {
  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {
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
    path.lineTo(0.0, size.height - 40.0);

    var firstControlPoint = Offset(size.width / 4, size.height); // 控制点
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0); // 结束点
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 4 * 3, size.height - 90);
    var secondEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
