import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class RainDropWidget extends StatefulWidget {

  RainDropWidget({Key key, this.width, this.height}) : super(key: key);

  final double width;
  final double height;

  @override
  State<StatefulWidget> createState() {
    return RainDropState(width, height);
  }
}

class RainDropState extends State<RainDropWidget>
    with TickerProviderStateMixin {
  List<RainDropDrawer> _rainList;
  AnimationController _animation;
  double _width = 300;
  double _height = 300;

  RainDropState(double width, double height) {
    _width = width ?? _width;
    _height = height ?? _height;
  }

  @override
  void initState() {
    super.initState();
    _rainList = List();
    _animation = new AnimationController(
      // 因为是repeat的，这里的duration其实不care
        duration: const Duration(milliseconds: 200),
        vsync: this)
      ..addListener(() {
        if (_rainList.isEmpty) {
          _animation.stop();
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: _width,
      height: _height,
      child: GestureDetector(
        onTapUp: (TapUpDetails tapUp) {
          RenderBox getBox = context.findRenderObject();
          var localOffset = getBox.globalToLocal(tapUp.globalPosition);

          var rainDrop = RainDropDrawer(localOffset.dx, localOffset.dy);
          _rainList.add(rainDrop);
          _animation.repeat();
        },
        child: CustomPaint(
          painter: RainDrop(_rainList),
        ),
      ),
    );
  }
}

class RainDrop extends CustomPainter {
  RainDrop(this.rainList);

  List<RainDropDrawer> rainList = List();
  Paint _paint = new Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    rainList.forEach((item) {
      item.drawRainDrop(canvas, _paint);
    });
    rainList.removeWhere((item) {
      return !item.isValid();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RainDropDrawer {
  static const double MAX_RADIUS = 30;
  double posX;
  double posY;
  double radius = 5;

  RainDropDrawer(this.posX, this.posY);

  drawRainDrop(Canvas canvas, Paint paint) {
    double opt = (MAX_RADIUS - radius) / MAX_RADIUS;
    paint.color = Color.fromRGBO(0, 0, 0, opt);
    canvas.drawCircle(Offset(posX, posY), radius, paint);
    radius += 0.5;
  }

  bool isValid() {
    return radius < MAX_RADIUS;
  }
}
