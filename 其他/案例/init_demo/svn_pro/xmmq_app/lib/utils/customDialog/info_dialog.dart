/*
* 店主信息
* */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../models/editable_activity_item.dart';
import 'dart:core';
import 'dart:io';

import '../../serviceapi/customerapi.dart';
import '../../utils/utils.dart';

class InfoDialog extends StatefulWidget {
  String loadingText;
  String radioValue;
  Map infoMap;
  bool outsideDismiss;
  Function dismissCallback;
  Function okCallback;
  Function otherCallback;

  InfoDialog({
    Key key,
    this.loadingText = "我是自定义标题",
    this.outsideDismiss = true,
    this.radioValue = '一口价',
    this.infoMap,
    this.dismissCallback,
    this.okCallback,
    this.otherCallback,
  }) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  FocusNode _inputNode = FocusNode();
  FocusNode _cannelNode = FocusNode();
  bool _wechatNumEnabledTag = false; // 键盘不可使用
  String _btnTxt = '修改';

  final _controller = TextEditingController();
  String _headImg = '';
  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.infoMap['WechatId'];
    setState(() {
      _headImg =
          '${widget.infoMap['WechatPaymentQRCode']}?imageView2/0/w/250/h/250';
    });
  }

  /*
  *  修改微信
  * */
  _updateWeChat() {
    if (_btnTxt == '修改') {
      setState(() {
        _wechatNumEnabledTag = true;
        _btnTxt = '保存';
      });
      FocusScope.of(context).requestFocus(_inputNode);
    } else {
      var text = _controller.text;
      Map map = {
        'Guid': '${widget.infoMap['Guid']}',
        'WechatId': text,
      };
      CustomerApi().UpdateStoreApplicationWechatInfo(context, map).then((e) {
        if (e['Success'] == true) {
          Fluttertoast.showToast(
              backgroundColor: Color(0xFF666666),
              msg: '微信号修改成功～',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER);
          setState(() {
            _wechatNumEnabledTag = false;
            _btnTxt = '修改';
          });

          FocusScope.of(context).requestFocus(_cannelNode);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  /*
  * 拍照
  * */
  _openCamera() async {
    Navigator.of(context).pop();
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: picture.path));
    }
  }

  /*
  * 打开相册
  * */
  _openGallery() async {
    Navigator.of(context).pop();
    var gallery = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (gallery != null) {
      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: gallery.path));
    }
  }

  /*
  * 得到图片就上传 单张
  * */
  _uploadImg(EditableActivityItem e) async {
    int nIndex = e.thumbnail.lastIndexOf("/");
    var imgName = e.thumbnail.substring(nIndex + 1);

    ///nowDateMilliseconds.toString();
    // 上传图片
    Response _response;
    Dio dio = Dio();
    File img_file = File(e.thumbnail);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(img_file.path, filename: '$imgName'),
    });
    var url =
        'https://content.xiaomaimaiquan.com/api/v2b/Content/UploadImageFiles';
    _response = await dio
        .post(url,
            options: Options(headers: {
              "wbhost": CustomerApi().getStoreHost(),
              "StoreGuid": CustomerApi().getStoreGuid(),
              "token": CustomerApi().getToken(),
              "Platform": "app",
              "FileDescription": jsonEncode(
                {
                  "FileName": "$imgName",
                  "FileType": "image",
                },
              )
            }),
            data: formData)
        .catchError((e) {});
    if (_response.data['Success'] == true) {
      var _img_url = _response.data['Data']['$imgName'];
      Map map = {
        'Guid': '${widget.infoMap['Guid']}',
        'wechatPaymentQrCode': _img_url,
      };
      CustomerApi().UpdateStoreApplicationWechatInfo(context, map).then((e) {
        setState(() {
          _headImg = _img_url;
        });
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '收款码修改成功～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }).catchError((e) {
        print(e);
      });
    } else {}
  }

  /*
  * 选择相册对话框
  * */
  Future<void> _optionsDialogBox() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('相机拍照'),
                    onTap: _openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('从相册选择'),
                    onTap: _openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
//    print(widget.infoMap);
    var date = widget.infoMap['CreatedOn'];
    var text =
        DateFormat('yyyy-MM-dd').format(Utils.fromAspDateTimeTicks(date));

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 300.0,
            height: 560.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '姓名',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        '${widget.infoMap['FullName']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '邮箱',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        '${widget.infoMap['Email']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '手机号',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 45,
                                      ),
                                      Text(
                                        '${widget.infoMap['PhoneNumber']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '创建时间',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        '$text',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '微信号',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 44,
                                      ), //
                                      Container(
                                        width: 150,
                                        child: TextField(
                                          cursorColor:
                                              Color.fromRGBO(187, 187, 187, 1),
                                          enabled: _wechatNumEnabledTag,
                                          style: TextStyle(fontSize: 15),
                                          focusNode: _inputNode,
                                          controller: _controller,
                                          onSubmitted: (e) {
                                            _controller.text = e;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: _updateWeChat,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 175, 76, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(left: 100),
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    width: 94,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/icon_share_edit.png'),
                                        Text(
                                          '  $_btnTxt',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 15, bottom: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '微信收款码    ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      Container(
                                        width: 140,
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          '$_headImg',
                                          width: 140,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: _optionsDialogBox,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 175, 76, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(left: 100, top: 10),
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    width: 94,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/icon_apply_upload.png'),
                                        Text(
                                          '  重新上传',
                                          style: TextStyle(color: Colors.white),
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
                      Positioned(
                        left: 115,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(42),
                              )),
                          child: Material(
                            borderRadius: BorderRadius.circular(35.0),
//                          shadowColor: Colors.yellow.shade200,
//                          elevation: 5.0,
                            child: ClipOval(
                              child: Image.network(
                                '${widget.infoMap['ApplicationAvatar']}',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 0,
                  child: InkWell(
                    onTap: widget.outsideDismiss ? _dismissDialog : null,
                    child: Container(
                      width: 50,
                      height: 50,
//                    color: Colors.red,
                      child: Center(
                        child: Image.asset(
                          'assets/icon_grey_delete.png',
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
