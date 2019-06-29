import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


///  自定义 密码输入框

class CustomJPasswordField extends StatelessWidget {

  ///  传入当前密码
  String data;
  CustomJPasswordField(this.data);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustom(data),
    );
  }
}

class MyCustom extends CustomPainter {


  String pwdLength;
  MyCustom(this.pwdLength);


  @override
  void paint(Canvas canvas, Size size) {

    int PWD_SPACING = 5;
    int PWD_SIZE = 5;
    int mWidth;

    // 密码长度
    int PWD_LENGTH = 6;

    // 密码画笔
    Paint mPwdPaint;
    Paint mRectPaint;
    Rect mRect;
    int mInputLength;
    

    // 初始化密码画笔  
    mPwdPaint = new Paint();
    mPwdPaint..color = Colors.black;

//   mPwdPaint.setAntiAlias(true);
    // 初始化密码框  
    mRectPaint = new Paint();
    mRectPaint..color = Color(0xff707070);


    RRect r = new RRect.fromLTRBR(
        0.0, 0.0, size.width, size.height, new Radius.circular(size.height / 12));
    mRectPaint.style = PaintingStyle.stroke;
    canvas.drawRRect(r, mRectPaint);


    var per = size.width / 6.0;
    var offsetX = per;
    while (offsetX < size.width) {
      canvas.drawLine(
          new Offset(offsetX, 0.0), new Offset(offsetX, size.height), mRectPaint);
      offsetX += per;
    }

    var half = per/2;
    var radio = per/8;
    

    mPwdPaint.style = PaintingStyle.fill;
    for(int i =0; i< pwdLength.length && i< 6; i++){
      canvas.drawArc(new Rect.fromLTRB(i*per+half-radio, size.height/2-radio, i*per+half+radio, size.height/2+radio), 0.0, 2*pi, true, mPwdPaint);
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
