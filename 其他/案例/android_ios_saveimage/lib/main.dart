import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('android保存图片'),
      ),
      body: SnackBtn(),
    );
  }
}

class SnackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onLongPress: () {
          _save();
        },
        child: Image.network(
            'https://gank.io/images/882afc997ad84f8ab2a313f6ce0f3522'),
      ),
    );
  }

  /*
   * 请求相册权限
   */
  requestPhotoPermissionIOS() {
    return Permission.photos.request().then((it) => it.isGranted);
  }

  requestPhotoPermissionAndroid() {
    return Permission.storage.request().then((it) => it.isGranted);
  }

  /// 打开权限设置界面
  // ignore: missing_return
  Future<bool> _openAppSetting() async {
    await openAppSettings();
  }

  _save() async {
    if (Platform.isAndroid) {
      if (await requestPhotoPermissionAndroid()) {
        try {
          var response = await Dio().get(
              'https://gank.io/images/882afc997ad84f8ab2a313f6ce0f3522',
              options: Options(responseType: ResponseType.bytes));
          final result = await ImageGallerySaver.saveImage(
              Uint8List.fromList(response.data));
          if (result != null) {
            print(result);
          }
        } catch (e) {
          print(e);
        }
        return null;
      } else {
        _openAppSetting();
      }
    } else {
      if (await requestPhotoPermissionIOS()) {
        try {
          var response = await Dio().get(
              'https://gank.io/images/882afc997ad84f8ab2a313f6ce0f3522',
              options: Options(responseType: ResponseType.bytes));
          final result = await ImageGallerySaver.saveImage(
              Uint8List.fromList(response.data));
          if (result != null) {
            print(result);
          }
        } catch (e) {
          print(e);
        }
        return null;
      } else {
        _openAppSetting();
      }
    }
  }
}
