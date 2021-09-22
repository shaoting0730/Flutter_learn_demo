/*
* 设置界面
* */
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../models/api/customer.dart';
import '../../routers/application.dart';
import '../../serviceapi/baseapi.dart';

class SettingPage extends StatefulWidget {
  final String modelStr;
  SettingPage({Key key, @required this.modelStr}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  LoginResponseModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginResponseModel model =
        LoginResponseModel.fromJson(json.decode(widget.modelStr));
    setState(() {
      _model = model;
    });
  }

  /*
  * 点击事件
  * */
  _onclickAction(String str) async {
    print(str);
    if (str == '地址管理') {
      //
      String str = json.encode(_model);

      Application.router.navigateTo(
          context, "./manage_address_page?modelStr=${Uri.encodeComponent(str)}",
          transition: TransitionType.inFromRight);
    } else if (str == '供应商推荐码') {
      var CustomerUniqueCode = _model.CustomerUniqueCode;
      Clipboard.setData(ClipboardData(text: CustomerUniqueCode));
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "推荐码： $CustomerUniqueCode 已经复制~",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF999999),
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
          '设置',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _contextWidget(
            '头像',
            ClipOval(
              child: Image.network(
                _model.WechatThumber,
                width: 60.0,
                height: 60.0,
              ),
            ),
          ),
          _contextWidget(
            '昵称',
            Text(_model.WechatNickName),
          ),
          _contextWidget(
            '手机号',
            Icon(Icons.keyboard_arrow_right),
          ),
          _contextWidget(
            '供应商推荐码',
            Text(''),
          ),
          Container(
            color: Color(0xFF999999),
            height: 10,
          ),
//          _contextWidget(
//            '地址管理',
//            Icon(Icons.keyboard_arrow_right),
//          ),
        ],
      ),
    );
  }

  /*
  * 主体UI
  * */
  Widget _contextWidget(String str, Widget widget) {
    return InkWell(
      onTap: () => this._onclickAction(str),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFF999999)),
          ),
        ),
        height: 80,
        child: Center(
          child: ListTile(
            leading: Text(str),
            trailing: widget,
          ),
        ),
      ),
    );
  }
}
