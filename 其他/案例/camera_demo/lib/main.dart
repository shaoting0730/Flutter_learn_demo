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
  CameraController _cameraControlle;
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
    _cameraControlle = CameraController(_cameras[0], ResolutionPreset.medium);
    _cameraControlle.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraControlle?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraControlle == null || _cameraControlle?.value == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    double rpx = MediaQuery.of(context).size.width / 750;

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
//          相机取景view
//          CameraPreview(_cameraControlle), 取景框会出现变形
          Transform.scale(
            scale: _cameraControlle.value.aspectRatio / deviceRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: _cameraControlle.value.aspectRatio,
                child: CameraPreview(_cameraControlle),
              ),
            ),
          ),
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
            child: _bottomNav(rpx, _cameraControlle),
          ),
        ],
      ),
    );
  }

  /*
  * 顶部导航
  * */
  Widget _topNav(double rpx) {
    return Container(
      width: 750 * rpx,
      height: 100 * rpx,
      color: Colors.red,
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.flash_on,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  /*
  *  底部导航
  * */
  Widget _bottomNav(double rpx, CameraController controller) {
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
            child: TakePhotoBtn(
              rpx: rpx,
              controller: controller,
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {
                _cameraControlle =
                    CameraController(_cameras[1], ResolutionPreset.medium);
                _cameraControlle.initialize().then((_) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {});
                });
              },
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
  TakePhotoBtn({Key key, @required this.rpx, @required this.controller})
      : super(key: key);
  final double rpx;
  final CameraController controller;
  @override
  _TakePhotoBtnState createState() => _TakePhotoBtnState();
}

class _TakePhotoBtnState extends State<TakePhotoBtn>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = new Tween(begin: 60.0, end: 40.0).animate(_animationController)
      ..addStatusListener((status) {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });
  }

  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _animationController.forward();
      },
      child: Center(
        child: Container(
          padding: EdgeInsets.all(4),
          width: _animation.value,
          height: _animation.value,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Container(
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
