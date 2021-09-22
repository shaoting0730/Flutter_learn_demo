/*
* 用户名登录
* */
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

class UsernameLoginPage extends StatefulWidget {
  @override
  _UsernameLoginPageState createState() => _UsernameLoginPageState();
}

class _UsernameLoginPageState extends State<UsernameLoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userNameContro = TextEditingController();
  TextEditingController _passwordContro = TextEditingController();

  /*
  * 跳转注册页面
  * */
  _goRegister() {
    Application.router.navigateTo(context, "./register_page",
        transition: TransitionType.inFromBottom);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameContro.dispose();
    _passwordContro.dispose();
  }

  void _onUsernameLogin() async {
    var userName = _userNameContro.text.trim();
    var psw = _passwordContro.text.trim();

    if (userName.length != 0 && psw.length != 0) {
      WxloginRequest request = WxloginRequest();
      request.WechatCode = userName;
      request.UserInfo = psw;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '手机号登录',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
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
          Form(
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
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
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
            obscureText: true,
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
