/*
* 供应商推荐码
* */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'dart:ui';

import '../../serviceapi/customerapi.dart';
import '../../models/api/customer.dart';
import '../../widgets/loading_widget.dart';

class SupplierReferralCode extends StatefulWidget {
  final StoreInfoModel storeInfoModel;
  final LoginResponseModel model;
  SupplierReferralCode({Key key, this.storeInfoModel, this.model})
      : super(key: key);

  @override
  _SupplierReferralCodeState createState() => _SupplierReferralCodeState();
}

class _SupplierReferralCodeState extends State<SupplierReferralCode> {
  List _list = [
    {
      'Q': '什么是供货商推荐码?',
      'A':
          '每位店主都有一个供货商推荐码，分享给别人，别人开店成功后，您会自动成为他的供应商，他可以直接发布您店铺里的商品，客户下单后该订单由他再分享给您，您处理发货即可。'
    },
    {'Q': '成为供货商方法一', 'A': '您分享二维码给好友，好友微信扫描后跳转至公众号开店，开店成功后您将自动绑定成为他的供应商。'},
    {'Q': '成为供货商方法二', 'A': '复制上方文字部分的推荐码，当别人在公众号开店时输入您的推荐码，开店成功后您将自动绑定成为他的供应商。'}
  ];
  String Img_str = '';
  bool _showLoadingTag = true;
  GlobalKey _rootWidgetKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _showLoadingTag = true;
    });
    CustomerApi().GetGZHQRCode(context).then((e) {
      setState(() {
        _showLoadingTag = false;
      });
//      print(e['Data']['ImageUrl']);
      setState(() {
        Img_str = e['Data']['ImageUrl'];
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _showLoadingTag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF999999),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          '供应商推荐码',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _showLoadingTag == true
          ? LoadingWidget(
              title: '数据加载中...',
            )
          : Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    RepaintBoundary(
                      key: _rootWidgetKey,
                      child: _topWidget(),
                    ),
                    _bottomWidget(),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        // 保存图片分享
                        InkWell(
                          onTap: () async {
                            RenderRepaintBoundary boundary = _rootWidgetKey
                                .currentContext
                                .findRenderObject();
                            var image = await boundary.toImage(pixelRatio: 3.0);
                            var byteData = await image.toByteData(
                                format: ImageByteFormat.png);
                            var pngBytes = byteData.buffer.asUint8List();
                            var filePath = await ImagePickerSaver.saveFile(
                                fileData: pngBytes);
                            Fluttertoast.showToast(
                                backgroundColor: Color(0xFF666666),
                                msg: "图片保存本地成功",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER);
                          },
                          child: Container(
                            height: 55,
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              border: Border.all(
                                  color: Color.fromRGBO(255, 175, 76, 1),
                                  width: 1),
                            ),
                            child: Center(
                              child: Text(
                                '保存图片分享',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 175, 76, 1),
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        // 分享给好友
                        InkWell(
                          onTap: () async {
                            try {
                              RenderRepaintBoundary boundary = _rootWidgetKey
                                  .currentContext
                                  .findRenderObject();

                              ui.Image image = await boundary.toImage(
                                pixelRatio: 3.0,
                              );

                              ByteData byteData = await image.toByteData(
                                format: ui.ImageByteFormat.png,
                              );

                              Uint8List uint8list =
                                  byteData.buffer.asUint8List();
//                        Image img = Image.memory(uint8list, fit: BoxFit.fill);

                              Future.delayed(Duration(microseconds: 200))
                                  .then((e) {
                                fluwx.WeChatScene scene =
                                    fluwx.WeChatScene.SESSION;
                                String _webPageUrl = "http://www.qq.com";
                                String _thumbnail = "";
                                String _title = "Fluwx";
                                String _userName = "gh_fa3f54a90163";
                                String _path = "/pages/media";
                                String _description = "";

//                          var model = new fluwx.WeChatShareMiniProgramModel(
//                              webPageUrl: _webPageUrl,
//                              userName: _userName,
//                              title: _title,
//                              path: _path,
//                              description: _description,
//                              scene: fluwx.WeChatScene.SESSION,
//                              hdImagePath: _thumbnail,
//                              thumbnail: _thumbnail);
//                          fluwx.share(model);

                                var model =
                                    fluwx.WeChatShareImageModel.fromUint8List(
                                        imageData: uint8list);
                                fluwx.share(model);
                              });
                            } catch (e) {}
                          },
                          child: Container(
                            height: 55,
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 175, 76, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '分享给好友',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  /*
  * 顶部Widget
  * */
  _topWidget() {
    return Container(
      height: 345,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(212, 86, 40, 1), width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          // 头
          Container(
            height: 44,
            color: Color.fromRGBO(212, 86, 40, 1),
            child: Center(
              child: Text(
                '"${widget.storeInfoModel.StoreName}"的供货商推荐码',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          // 推荐码一栏
          _codeWidget(),
//          二维码
          Center(
              child: Image.network(
            Img_str,
            width: 200,
          )),
//          微信
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icon_wechat_logo_green.png'),
                Text(
                  '  微信扫描推荐码开店',
                  style: TextStyle(
                    color: Color.fromRGBO(58, 183, 41, 1),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  *  邀请码一栏
  * */
  Widget _codeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 17),
            child: Row(
              children: <Widget>[
                Text(
                  '供货商推荐码',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '${widget.model.CustomerUniqueCode}',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromRGBO(255, 173, 78, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: widget.model.CustomerUniqueCode));
              Fluttertoast.showToast(
                  backgroundColor: Color(0xFF666666),
                  msg: " 推荐码 ${widget.model.CustomerUniqueCode} 已经复制~",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER);
            },
            child: Container(
              margin: EdgeInsets.only(right: 17),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_my_code_copy.png'),
                  Text(
                    '  复制',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 175, 76, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 底部视图
  * */
  Widget _bottomWidget() {
    List<Widget> _listWidget = _list.map((e) {
      return Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: 'Q:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(255, 173, 78, 1),
                ),
                children: [
                  TextSpan(
                    text: '     ${e['Q']}',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                text: 'A:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(136, 136, 136, 1),
                ),
                children: [
                  TextSpan(
                    text: '     ${e['A']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(102, 102, 102, 1),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 1,
              color: Color.fromRGBO(221, 221, 221, 1),
            )
          ],
        ),
      );
    }).toList();

    return Column(children: _listWidget);
  }
}
