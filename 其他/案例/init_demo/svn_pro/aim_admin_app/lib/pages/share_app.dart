import 'dart:ui' as prefix0;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class ShareApp extends StatefulWidget {
  ShareApp({Key key}) : super(key: key);

  @override
  _ShareAppState createState() => new _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  final _widgetKey = GlobalKey();

  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments as CustomerModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('分享APP'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              RepaintBoundary(
                key: _widgetKey,
                child: Container(
                  width: 320,
//                  height: 490,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/share_app_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/person.jpg"),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Hi, 我是', style: AimTheme.text20White),
                            Text('${data?.FirstName}',
                                style: AimTheme.text20White),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('我的邀请码是: ', style: AimTheme.text20White),
                            Text('${data?.CustomerUniqueCode}',
                                style: AimTheme.text20White),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('邀请您下载海创小目标APP'),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Image.asset(
                                          'assets/app_download.png',
                                          width: 120,
                                          height: 120),
                                    ),
                                    Text('长按识别、扫码注册下载'),
                                    Text('海创管理平台APP'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    height: 50,
                    color: Theme.of(context).primaryColor,
                    child: Text('保存图片到相册', style: AimTheme.text16White),
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          _widgetKey.currentContext.findRenderObject();
                      var image = await boundary.toImage(pixelRatio: 3.0);
                      var byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      var pngBytes = byteData.buffer.asUint8List();
                      var filePath =
                          await ImagePickerSaver.saveFile(fileData: pngBytes);
                      displayErrorMessage(context, '已保存到系统相册');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
