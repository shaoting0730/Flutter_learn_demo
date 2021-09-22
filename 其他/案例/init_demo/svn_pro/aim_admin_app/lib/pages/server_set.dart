import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/baseapi.dart';

class ServerSet extends StatefulWidget {
  @override
  _ServerSetState createState() => _ServerSetState();
}

class _ServerSetState extends State<ServerSet> {
  String _value = '0'; // 默认正式服务器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUrl();
  }

  /*
  * 设置初始化
  * */
  _getUrl() async {
    // 取值
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = await prefs.get('serVerValue');
    if (str == null) {
      str = '0';
    }
    setState(() {
      _value = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置服务器'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              RadioListTile<String>(
                value: '0',
                title: Text('正式服务器'),
                groupValue: _value,
                onChanged: (value) => this._setServerTag(value),
              ),
              RadioListTile<String>(
                value: '1',
                title: Text('测试服务器'),
                groupValue: _value,
                onChanged: (value) => this._setServerTag(value),
              ),
            ],
          )
        ],
      ),
    );
  }

  /*
  * 切换 + 存值
  * */
  _setServerTag(serVerValue) async {
    // 切换
    setState(() {
      _value = serVerValue;
    });
    // 存值
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('serVerValue', serVerValue);
    // 提示

    Fluttertoast.showToast(
        backgroundColor: Color(0xFF666666),
        msg: serVerValue == '0'
            ? "切换至正式服务器: http://webapi.51taouk.com,请重新登录"
            : "切换至测试服务器: http://uatwebapi.51cpk.com,请重新登录",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
    // 注销登录
    await BaseApi.clearLoginResponse();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      ModalRoute.withName('/'),
    );
  }
}
