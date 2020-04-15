import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 设置这一属性即可
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController _controller;
  var _cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  /*
  *   初始化相机
  * */
  initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || _controller?.value == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CameraPreview(_controller),
//          顶部导航
          Positioned(
            top: 0,
            left: 0,
            child: _topNav(rpx),
          ),
//          底部菜单
          Positioned(
            bottom: 0,
            left: 0,
            child: _bottomNav(rpx),
          ),
        ],
      ),
    );
  }

  /*
  * 顶部导航
  * */
  Widget _topNav(double rpx) {
    return SafeArea(
      child: Container(
        width: 750 * rpx,
        height: 100 * rpx,
        color: Colors.red,
        child: Row(
          children: <Widget>[],
        ),
      ),
    );
  }

  /*
  *  底部导航
  * */
  Widget _bottomNav(double rpx) {
    return Container(
      width: 750 * rpx,
      height: 150 * rpx,
      color: Colors.yellow,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.panorama,
                size: 80 * rpx,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TakePhotoBtn(rpx: rpx),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.switch_camera,
                size: 80 * rpx,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TakePhotoBtn extends StatefulWidget {
  TakePhotoBtn({Key key, @required this.rpx}) : super(key: key);
  final double rpx;
  @override
  _TakePhotoBtnState createState() => _TakePhotoBtnState();
}

class _TakePhotoBtnState extends State<TakePhotoBtn> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        print('拍照');
      },
      child: Container(
        padding: EdgeInsets.all(4),
        width: 100 * widget.rpx,
        height: 100 * widget.rpx,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Center(
          child: Container(
            width: 80 * widget.rpx,
            height: 80 * widget.rpx,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
