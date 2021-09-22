import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../pages/register_page.dart';
import '../routers/application.dart';
import '../models/api/customer.dart';
import '../serviceapi/customerapi.dart';
import '../utils/utils.dart';
import '../widgets/InputFields.dart';
import '../widgets/base_page.dart';
import '../serviceapi/baseapi.dart';
import '../pages/select_store_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

// 首页
class LoginPageState extends State<LoginPage> {
  bool _initialized = false;
  bool _isWeChatInstalledTag = false; // 是否安装了微信
  bool _isLogingTag = false; // 正在登录

  TextEditingController _userNameContro = TextEditingController();
  TextEditingController _passwordContro = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _userName = "";
  String _userPassword = "";
  StreamSubscription<fluwx.WeChatAuthResponse> _wxListener = null;

  Future _setupWechat() async {
    await fluwx.registerWxApi(
        appId: "wx8a57d592b64e5de4",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://www.xiaomaimaiquan.com/");
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });

//    print('isWeChatInstalled: $result');
  }

  @override
  void initState() {
    super.initState();

    if (_wxListener != null) {
      _wxListener.cancel();
      _wxListener = null;
    }
    _registerAction();
  }

  _registerAction() async {
    await _setupWechat();

    if (!_initialized) {
      _initialized = true;
      if (_wxListener != null) {
        _wxListener.cancel();
        _wxListener = null;
      }
      _wxListener = fluwx.responseFromAuth.listen((data) async {
//        print(data.errCode);
        // start to login
        final int errCode = data.errCode;
        print(errCode);
        if (errCode != 0) {
          // 授权失败
          setState(() {
            _isLogingTag = false;
          });
        }

        WxloginRequest request = WxloginRequest();
        request.AutoRegister = false;
        request.WechatCode = data.code;
        await CustomerApi().WechatLogin(context, request);

        List<StoreInfoModel> storesList =
            await CustomerApi().GetMyAccessStores(context, {});
        if (storesList.length <= 0) {
          print('你尚未开店');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectStorePage(modelList: storesList),
            ),
          );
        } else if (storesList.length == 1) {
          // 只有一个店

          await CustomerApi().LoadUserBind(context, storesList.first.StoreGuid);
          CustomerApi().verifyLoginState(context);
        } else {
          print('选择一个店');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectStorePage(modelList: storesList),
            ),
          );
//          Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(
//                  builder: (context) => SelectStorePage(
//                        modelList: storesList,
//                      )),
//              (route) => route == null);
        }
      });
    }
  }

  void _onUsernameLogin() async {
    if (_userNameContro.text.length != 0 && _passwordContro.text.length != 0) {
      WxloginRequest request = WxloginRequest();
      request.WechatCode = _userNameContro.text;
      request.UserInfo = _passwordContro.text;
      request.AutoRegister = false;

      LoginResponseModel loginModel =
          await CustomerApi().WechatLogin(context, request);
//      print('loginModel ${jsonEncode(loginModel)}');
      if (loginModel == null) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "用户名或者密码错误~",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
        return;
      }
      List<StoreInfoModel> storesList =
          await CustomerApi().GetMyAccessStores(context, {});
      if (storesList.length <= 0) {
        print('你尚未开店');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectStorePage(modelList: storesList),
          ),
        );
      } else if (storesList.length == 1) {
        // 只有一个店
        await CustomerApi().LoadUserBind(context, storesList.first.StoreGuid);
        CustomerApi().verifyLoginState(context);
      } else {
        print('选择一个店');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectStorePage(modelList: storesList),
          ),
        );
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "请输入用户名或密码",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  void _onWechatLogin() {
    setState(() {
      _isLogingTag = true;
    });

    fluwx
        .sendAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {
      print('fluwx.sendAuth: $data');
    });
  }

  /*
  * 跳转注册页面
  * */
  _goRegister() {
    Application.router.navigateTo(context, "./register_page",
        transition: TransitionType.inFromBottom);
  }

  @override
  Widget build(BuildContext context) {
    return _isLogingTag == false
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: [
                  SizedBox(height: 80),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/logo_xmmq_1024.png',
                          width: 200,
                        ),
                        Text(
                          '小买卖圈',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  _isWeChatInstalledTag == true
                      ? Column(
                          children: <Widget>[
                            InkWell(
                              onTap: _onWechatLogin,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '微信一键登录',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Application.router.navigateTo(
                                    context, "./username_login_page",
                                    transition: TransitionType.inFromBottom);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '手机号登录 >',
                                  style: TextStyle(color: Color(0xFF999999)),
                                ),
                              ),
                            )
                          ],
                        )
                      : Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: Utils.noNull(
                              [
                                _buildUsernameField(context),
                                _buildPasswordField(context),
                                SizedBox(height: 20),
                                MaterialButton(
                                  height: 44,
                                  child: Text(
                                    "登录",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                  color: Color(0xFFFFAF4C),
                                  onPressed: _onUsernameLogin,
                                ),
                                InkWell(
                                  onTap: _goRegister,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    alignment: Alignment.centerRight,
                                    child: Text('注册'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
              child: Center(
                child: SpinKitWave(
                  size: 20,
                  color: Color.fromRGBO(255, 175, 76, 1),
                  type: SpinKitWaveType.center,
                ),
              ),
            ),
          );
  }

  Widget _buildUsernameField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: Color.fromRGBO(187, 187, 187, 1),
            controller: _userNameContro,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: Color.fromRGBO(187, 187, 187, 1),
            controller: _passwordContro,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.featured_play_list),
            ),
          ),
        ),
      ],
    );
  }
}
