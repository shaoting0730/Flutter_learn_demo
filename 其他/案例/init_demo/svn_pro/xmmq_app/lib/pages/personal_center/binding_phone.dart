import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../serviceapi/customerapi.dart';

// 用户绑定手机页面，在微信登录后，如果检查没有这个用户手机信息
// 会弹窗，force 用户去填写手机信息

class BindingPhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BindingPhonePageState();
  }
}

class _BindingPhonePageState extends State<BindingPhonePage> {
  GlobalKey<ScaffoldState> registKey = GlobalKey();

  String _phoneNum = '';

  String _verifyCode = '';

  int _seconds = 0;

  String _verifyStr = '获取验证码';

  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  _startTimer() {
    _seconds = 10;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }

      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  Widget _buildPhoneEdit() {
    var node = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        onChanged: (str) {
          _phoneNum = str;
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: '请输入手机号',
        ),
        maxLines: 1,
        maxLength: 11,
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (text) {
          //FocusScope.of(context).reparentIfNeeded(node);
        },
      ),
    );
  }

  Widget _buildVerifyCodeEdit() {
    var node = FocusNode();
    Widget verifyCodeEdit = TextField(
      cursorColor: Color.fromRGBO(187, 187, 187, 1),
      onChanged: (str) {
        _verifyCode = str;
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: '请输入短信验证码',
      ),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        //FocusScope.of(context).reparentIfNeeded(node);
      },
    );

    Widget verifyCodeBtn = InkWell(
      onTap: (_seconds == 0)
          ? () {
              _onTapSendVerification();
              setState(() {
                _startTimer();
              });
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 36.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Color(0xFFFFAF4C),
          ),
        ),
        child: Text(
          '$_verifyStr',
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Stack(
        children: <Widget>[
          verifyCodeEdit,
          Align(
            alignment: Alignment.topRight,
            child: verifyCodeBtn,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Container(
      margin: const EdgeInsets.only(top: 33.0, bottom: 40.0, left: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        "绑定手机号",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildRegist() {
    return InkWell(
        child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 40.0, top: 20.0),
      child: MaterialButton(
        height: 44,
        color: Color(0xFFFFAF4C),
        textColor: Colors.white,
        disabledColor: Color(0xFFFFAF4C),
        onPressed: (_phoneNum.isEmpty || _verifyCode.isEmpty)
            ? null
            : () {
                _onTapLogin();
              },
        child: Text(
          "登  录",
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    ));
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        _buildLabel(),
        _buildPhoneEdit(),
        _buildVerifyCodeEdit(),
        _buildRegist()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: registKey,
        backgroundColor: Colors.white,
        body: _buildBody(),
      ),
    );
  }

  void _onTapSendVerification() async {
    await CustomerApi().SendMobileVerificationCode(context, _phoneNum);
  }

  void _onTapLogin() async {
    var response =
        await CustomerApi().MobileLogin(context, _phoneNum, _verifyCode, true);
  }
}
