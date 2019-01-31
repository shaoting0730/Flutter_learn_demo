import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // q取消debug图标
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
      home: Scaffold(
        appBar: AppBar(title: Text('案例4 贝塞尔曲线')),
        body: HomePage()
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          clipper: BottomClipper(),
          // clipper: BottomClipperTest(),
          child: Container(
            color: Colors.deepOrangeAccent,
            height: 200.0,
          ),
        )
      ],
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
    Path getClip(Size size) {
      var path = Path();
      path.lineTo(0.0, 0.0);
      path.lineTo(0.0, size.height - 50.0);

      var firstControlPoint = Offset(size.width * 0.5, size.height);   // 控制点
      var firstEndPoint = Offset(size.width, size.height-50.0); // 结束点

      path.quadraticBezierTo(
        firstControlPoint.dx, 
        firstControlPoint.dy, 
        firstEndPoint.dx, 
        firstEndPoint.dy);

      path.lineTo(size.width, size.height - 50.0);
      path.lineTo(size.width, 0.0);  

      return path; 

    }

    @override
      bool shouldReclip(CustomClipper<Path> oldClipper) {
        return false;
      }

    
    


}


class BottomClipperTest extends CustomClipper<Path> {
  @override
    Path getClip(Size size) {
      var path = Path();
      path.lineTo(0.0, 0.0);
      path.lineTo(0.0, size.height - 40.0);

      var firstControlPoint = Offset(size.width/4, size.height);   // 控制点
      var firstEndPoint = Offset(size.width/2.25, size.height-30.0); // 结束点
      path.quadraticBezierTo(
        firstControlPoint.dx, 
        firstControlPoint.dy, 
        firstEndPoint.dx, 
        firstEndPoint.dy);

      var secondControlPoint = Offset(size.width/4*3, size.height-90);
      var secondEndPoint = Offset(size.width, size.height-60);
      path.quadraticBezierTo(
        secondControlPoint.dx, 
        secondControlPoint.dy, 
        secondEndPoint.dx, 
        secondEndPoint.dy);

      path.lineTo(size.width, size.height-60);
      path.lineTo(size.width, 0.0);  

      return path; 

    }

    @override
      bool shouldReclip(CustomClipper<Path> oldClipper) {
        return false;
      }

    
    


}

