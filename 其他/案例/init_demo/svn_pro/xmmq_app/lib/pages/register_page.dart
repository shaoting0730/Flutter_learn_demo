/*
* 注册页面
* */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';

import '../routers/application.dart';
import '../models/api/customer.dart';
import '../serviceapi/customerapi.dart';
import '../pages/select_store_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userNameContro = TextEditingController();
  TextEditingController _passwordContro = TextEditingController();
  TextEditingController _passwordAgainContro = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameContro.dispose();
    _passwordContro.dispose();
    _passwordAgainContro.dispose();
  }

  

  /*
  * 注册请求
  * */
  _registerAction() async {
    String name = _userNameContro.text.trim();
    String psw = _passwordContro.text.trim();
    String pswAgain = _passwordAgainContro.text.trim();

    if (name.length == 0 || psw.length == 0 || pswAgain.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "以上的值均不能为空~",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }

    if (psw != pswAgain) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "两次输入密码不一致",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }

    WxloginRequest request = WxloginRequest();
    request.WechatCode = _userNameContro.text;
    request.UserInfo = _passwordContro.text;
    request.AutoRegister = true;

    LoginResponseModel loginModel =
        await CustomerApi().WechatLogin(context, request);
//    print('loginModel ${jsonEncode(loginModel)}');

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectStorePage(modelList: storesList),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
        brightness: Brightness.dark,
      ),
      body: Column(
        children: <Widget>[
          _buildUsernameField(context),
          _buildPasswordField(context),
          _buildPasswordAgainField(context),
          Spacer(),
          InkWell(
            onTap: _registerAction,
            child: Container(
              color: Color.fromRGBO(255, 175, 76, 1),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  '注册',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 用户名
  * */
  Widget _buildUsernameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        controller: _userNameContro,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: '请输入用户名',
        ),
      ),
    );
  }

  /*
  * 密码
  * */
  Widget _buildPasswordField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        obscureText: true,
        controller: _passwordContro,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.featured_play_list),
          hintText: '请输入密码',
        ),
      ),
    );
  }

  /*
  * 再次密码
  * */
  Widget _buildPasswordAgainField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        obscureText: true,
        controller: _passwordAgainContro,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.featured_play_list),
          hintText: '请再次输入密码',
        ),
      ),
    );
  }
}
