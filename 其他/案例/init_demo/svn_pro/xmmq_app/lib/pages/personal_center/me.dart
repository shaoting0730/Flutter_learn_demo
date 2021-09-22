import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import '../../routers/application.dart';
import '../login.dart';
import '../../serviceapi/baseapi.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/customer.dart';
import '../../bloc/isPicWall_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'supplier_referral_code.dart';
import 'official_accounts_page.dart';
import 'freight_settings.dart';
import '../../utils/customDialog/info_dialog.dart';
import '../../utils/utils.dart';
import '../message_center/message_center.dart';

class MePage extends StatefulWidget {
  @override
  State<MePage> createState() {
    return MePageState();
  }
}

class MePageState extends State<MePage> {
  LoginResponseModel _model;
  StoreInfoModel _storeInfoModel;
  Map _infoMap = {}; //  用户信息

  String _imgUrl = '';
  String _freight = '0'; // 运费设置
  int _storeNum = 1; // 用户商店数

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMyInfo();
  }

  /*
  * 获取我的信息
  * */
  _getMyInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tag = prefs.getBool(IS_ME_KEY);
    if (tag == null) {
      tag = true;
    }

    CustomerApi().GetBasicShippingFee(context).then((data) {
      var result = jsonEncode(data['Data']);
      List list = result.split('.');

      setState(() {
        _freight = list[0];
      });
    }).catchError((error) {});

    await CustomerApi().RetrieveStoreInfo(context, false).then((data) {
      var StoreGuid = data.StoreGuid;
      setState(() {
        _storeInfoModel = data;
      });
      CustomerApi().LoadUserBind(context, StoreGuid).then((data) {
//        print(jsonEncode(data));
        setState(() {
          _model = data;
          _imgUrl = data.WechatThumber;
          _infoMap = data.StoreApplication;
        });
      });
    }).catchError((error) {
      print(error);
    });

    List<StoreInfoModel> storesList =
        await CustomerApi().GetMyAccessStores(context, {});
    setState(() {
      _storeNum = storesList.length;
    });
  }

  /*
  * 跳转至设置页面
  * */
  _pushSetting() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return InfoDialog(
          infoMap: _infoMap,
          okCallback: () async {},
          dismissCallback: () {
            print("取消了");
            _getMyInfo();
          },
        );
      },
    );

//    String str = json.encode(_model);
//    Application.router.navigateTo(
//        context, "./setting_page?modelStr=${Uri.encodeComponent(str)}",
//        transition: TransitionType.inFromRight);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    double d = double.parse(_freight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        title: _imgUrl.length > 0
            ? Row(
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          _imgUrl + '?imageView2/0/w/250/h/250',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      _storeInfoModel.StoreName,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ],
              )
            : Text(''),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildHeadArea(),
            _buildCell(Image.asset('assets/icon_my_opinion.png'), "消息中心", "",
                () {
//              print(_imgUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageCenter(),
                ),
              );
            }),
            _buildSeparator(),
            _buildCell(Image.asset('assets/icon_my_order.png'), "我的销售订单", "",
                () {
              Application.router.navigateTo(context, "./order_list",
                  transition: TransitionType.inFromRight);
            }),
            _buildSeparator(),
            _buildCell(Image.asset('assets/icon_my_freight.png'), "运费设置",
                "基础运费：${Utils.stringFormat(d.toString())}元", () async {
              final result = await Application.router.navigateTo(
                  context, "./freight_settings?currentMoney=$_freight",
                  transition: TransitionType.inFromRight);
//            final result = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) =>
//                    FreightSettingsPage(currentMoney: _freight),
//              ),
//            );
              if (result != null) {
                setState(() {
                  _freight = result;
                });
              }
            }),
//            _buildSeparator(),
            _storeNum > 1
                ? Column(
                    children: <Widget>[
                      _buildCell(
                          Image.asset('assets/icon_my_see.png'), "我的小买卖", "",
                          () {
                        Application.router.navigateTo(context, "./user_role",
                            transition: TransitionType.inFromRight);
                      }),
                      _buildSeparator()
                    ],
                  )
                : Container(
                    height: 0,
                  ),
//          _buildSeparator(),
//          _buildCell(
//              Image.asset('assets/icon_my_advertisement.png'), "我的广告", "", () {
//            Application.router.navigateTo(context, "./advertising",
//                transition: TransitionType.inFromRight);
//          }),
            _buildSeparator(),
            _buildCell(Image.asset('assets/icon_my_opinion.png'), "我的供应商", "",
                () {
              Application.router.navigateTo(context, "./mine_supplier_page",
                  transition: TransitionType.inFromRight);
            }),
            _buildSeparator(),
            _buildCell(Image.asset('assets/icon_my_opinion.png'), "供应商推荐码",
                "我的推荐码：${_model?.CustomerUniqueCode} ", () async {
//              Application.router.navigateTo(context, "./supplier_referral_code",
//                  transition: TransitionType.inFromRight);
              await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return SupplierReferralCode(
                        model: _model, storeInfoModel: _storeInfoModel);
                  },
                ),
              );
            }),
            _buildSeparator(),
            _buildCell(
                Image.asset('assets/icon_my_wechat.png'), "关注微信公众号", "及时了解更多信息",
                () async {
              await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return OfficialAccountsPage();
                  },
                ),
              );
            }),
            _buildSeparator(),
            _buildCell(Image.asset('assets/icon_my_wechat.png'), "退出登录", "",
                () {
              var dialog = CupertinoAlertDialog(
                content: Text(
                  "您确定退出登录吗?",
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text("取消"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text("确定"),
                    onPressed: () async {
                      CustomerApi().cleanLoginInfo();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => route == null);
                    },
                  ),
                ],
              );

              showDialog(context: context, builder: (_) => dialog);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadArea() {
    return _imgUrl.length > 0
        ? Stack(
            children: <Widget>[
              Center(
                child: InkWell(
                  onTap: _pushSetting,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg_my_top.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(231, 231, 231, 1),
                                width: 1),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                _imgUrl + '?imageView2/0/w/250/h/250',
                              ),
                            ),
                          ),
                        ),
                        Text(_model.WechatNickName),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 65,
                right: MediaQuery.of(context).size.width / 2 - 30,
                child: Image.asset('assets/icon_my_edit.png'),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Application.router.navigateTo(
                        context, "./export_order_page",
                        transition: TransitionType.inFromRight);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.system_update_alt,
                          color: Color.fromRGBO(255, 175, 76, 1),
                          size: 15,
                        ),
                        Text(
                          ' 一键导出订单',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Text('');
  }

  Widget _buildCell(icon, title, subtitle, callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3A3A3A),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                )),
            Image.asset('assets/icon_my_right.png')
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Divider(
        color: Color(0xFFDDDDDD),
        height: 1,
      ),
    );
  }
}
