import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/loginmodel.dart';
import '../pages/input_dialog.dart';
import '../services/baseapi.dart';
import '../services/serviceapi.dart';

class Settings extends StatefulWidget {
  final String portraitStr;
  Settings({Key key, this.portraitStr}) : super(key: key);

  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
  File _image; // 头像
  CustomerModel data;
  PackageInfo packageInfo;
  String _portrait = '';
//  String telStr = ''; // ****遮挡后的手机号666
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () async {
      packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _portrait = widget.portraitStr;
      });
    });
  }

  Widget build(BuildContext context) {
    if (data == null) {
      data = ModalRoute.of(context).settings.arguments as CustomerModel;

      print('---- $_portrait');
//      if (data.PhoneNumber != null) {
//        print(data.PhoneNumber);
//        print(data.PhoneNumber);
//        print(data.PhoneNumber);
//        print(data.PhoneNumber);
//        print(data.PhoneNumber);
//        print(data.PhoneNumber);
//        telStr =
//            telStr.replaceRange(telStr.length - 8, telStr.length - 4, '****');
//        setState(() {
//          telStr = telStr;
//        });
//      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, _portrait);
          },
          child: Icon(
            Icons.navigate_before,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Text('个人设置'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 85,
            alignment: Alignment.center,
            child: ListTile(
              title: Text('头像'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _portrait.length == 0
                      ? CircleAvatar(
                          backgroundImage: AssetImage("assets/person.jpg"),
                        )
                      : ClipOval(
                          child: Image.network(
                            _portrait,
                            fit: BoxFit.fill,
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                ],
              ),
              onTap: () => this._changePortrait(context),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('昵称'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(data != null &&
                          data.FirstName != null &&
                          data.FirstName.isNotEmpty
                      ? data.FirstName
                      : '请输入昵称'),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                ],
              ),
              onTap: () async {
                final result = await Navigator.pushNamed(context, '/input',
                    arguments: InputDialogParams(
                        title: '填写昵称',
                        field: '昵称：',
                        tip: '昵称会显示在邀请朋友截图上')) as InputDialogReturn;
                if (result == null) return;
                if (await UserServerApi()
                    .updateCustomerInfo(context, name: result.value)) {
                  _refresh();
                }
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),
          data != null && data.PhoneNumber != null
              ? Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Text('登录手机'),
                    trailing: Text(data.PhoneNumber),
                  ),
                )
              : Container(height: 0),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('帮助与客服'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('微信号：17319087769'),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                ],
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: '17319087769'));
                displayErrorMessage(context, "微信号 17319087769 已复制到剪贴板");
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('关于我们'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () {
                Navigator.pushNamed(context, "/topic",
                    arguments: {'name': 'AboutUs'});
              },
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
          Container(
            color: Colors.white,
            child: InkWell(
              onTap: () async {
                await BaseApi.clearLoginResponse();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  ModalRoute.withName('/'),
                );
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: Text('退出登录'),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '当前app版本：${packageInfo?.version}.${packageInfo?.buildNumber}'),
            ],
          ),
        ],
      ),
    );
  }

  _refresh() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      data = await UserServerApi().getCustomerInfo(context);
      setState(() {});
    });
  }

  /*
  * 修改头像
  * */
  _changePortrait(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () => this._openCamera(context),
                  child: Container(
                    height: 45,
                    width: ScreenUtil().setWidth(750),
                    alignment: Alignment.center,
                    child: Text(
                      '相机',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => this._openPhotoAlbum(context),
                  child: Container(
                    height: 45,
                    width: ScreenUtil().setWidth(750),
                    alignment: Alignment.center,
                    child: Text(
                      '相册',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /*
  * 打开相机
  * */
  Future _openCamera(context) async {
    print('相机');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    print('本地数据0 $image');
    _uploadImg(EditableActivityItem(thumbnail: image.path));

    Navigator.pop(context);
  }

  /*
   * 打开相册
   * */
  Future _openPhotoAlbum(context) async {
    print('相册');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print('本地数据1 $image');

    _uploadImg(EditableActivityItem(thumbnail: image.path));
    Navigator.pop(context);
  }

  /*
  * 上传图片
  * */
  _uploadImg(EditableActivityItem e) async {
    int nowDateMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var imgName = nowDateMilliseconds.toString();
    // 上传图片
    Response _response;
    Dio dio = Dio();
    File img_file = File(e.thumbnail);
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(img_file.path, filename: '$imgName.png'),
    });
    // https://content.xiaomaimaiquan.com/api/v2b/Content/UploadImageFiles
    // http://uatwebapi.51cpk.com/api/FileAdmin/UploadQiniuFile
    var url = 'http://uatwebapi.51cpk.com/api/FileAdmin/UploadQiniuFile';
    _response = await dio.post(
      url,
      options: Options(
        headers: {
          "token": BaseApi().getToken(),
          "FileDescription": jsonEncode(
            {
              "FileName": "$imgName.png",
              "FileType": "image",
            },
          )
        },
      ),
      data: formData,
    );
    if (_response.data['Success'] == true) {
      print(_response);
      var _img_url = _response.data['Message'];
      setState(() {
        _portrait = _img_url;
      });
      _updatePortrait(_img_url);
    }
  }

  /*
  * 更新头像
  * */
  _updatePortrait(String str) async {
    Map params = {'Url': str};

    UserServerApi().updateStoreCustomerHead(context, params).then((e) {
      if (e['Success'] == true) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "修改成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "修改失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    }).catchError((e) {
      print(e);
    });
  }
}

class EditableActivityItem {
  String thumbnail;

  EditableActivityItem({this.thumbnail});
}
