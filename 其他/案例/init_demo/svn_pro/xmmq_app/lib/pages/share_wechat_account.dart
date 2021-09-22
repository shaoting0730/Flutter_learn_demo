import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../widgets/avatar.dart';
import '../serviceapi/customerapi.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShareWechatAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShareWechatAccountPageState();
  }
}

class ShareWechatAccountPageState extends State<ShareWechatAccountPage> {
  String _imageUrl = '';
  bool _isShareing = false; // 是否点击了分享按钮

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomerApi().GetMySharePicture(context, 1).then((val) {
      setState(() {
        _imageUrl = val['ImageUrl'];
      });
    }).catchError((error) {
      print(error);
    });

    fluwx.responseFromShare.listen((data) {
//      print('分享回调$data');
      setState(() {
        _isShareing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
        appBar: AppBar(
          title: Text('分享好友'),
        ),
        body: Stack(
          children: <Widget>[
            shareContentWidget(),
            Positioned(
              child: _isShareing == true
                  ? SpinKitWave(
                      size: 20,
                      color: Color.fromRGBO(255, 175, 76, 1),
                      type: SpinKitWaveType.center,
                    )
                  : Text(''),
            ),
          ],
        ));
  }

  Widget shareContentWidget() {
    return Column(
      children: <Widget>[
//          店面图片
        Expanded(
          child: ListView(
            children: <Widget>[
              _imageUrl != ''
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Image.network(
                        _imageUrl,
                        width: ScreenUtil().setWidth(400),
                        height: ScreenUtil().setHeight(800),
                      ),
                    )
                  : Center(
                      child: Text('图片生成中...'),
                    ),
            ],
          ),
        ),
//           底部UI
        Container(
          color: Colors.white,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: _saveImgShare,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(253, 159, 60, 1.0),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '分享到朋友圈',
                      style: TextStyle(
                        color: Color.fromRGBO(253, 159, 60, 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: _shareToFriend,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 159, 60, 1.0),
                    border: Border.all(
                        width: 1, color: Color.fromRGBO(255, 175, 76, 1)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '分享给好友',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*
  * 分享到朋友圈
  * */
  _saveImgShare() async {
    if (_imageUrl.length != 0) {
      setState(() {
        _isShareing = true;
      });
//      var response = await http.get(_imageUrl);
//
////      debugPrint(response.statusCode.toString());
//
//      var filePath =
//          await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
//
//      if (filePath != null) {
//        Fluttertoast.showToast(
//            backgroundColor: Color(0xFF666666),
//            msg: "图片保存成功",
//            toastLength: Toast.LENGTH_LONG,
//            gravity: ToastGravity.CENTER);
//      }
      fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;

      fluwx.share(
        fluwx.WeChatShareImageModel(
            image: _imageUrl,
            thumbnail: _imageUrl,
            transaction: _imageUrl,
            scene: scene,
            description: ''),
      );
    }
  }

  /*
  * 分享给好友
  * */
  _shareToFriend() {
    if (_imageUrl.length != 0) {
      setState(() {
        _isShareing = true;
      });
      fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;

      fluwx.share(
        fluwx.WeChatShareImageModel(
            image: _imageUrl,
            thumbnail: _imageUrl,
            transaction: _imageUrl,
            scene: scene,
            description: ''),
      );
    }
  }
}
