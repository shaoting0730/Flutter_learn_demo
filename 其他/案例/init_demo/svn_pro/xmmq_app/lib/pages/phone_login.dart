import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../serviceapi/customerapi.dart';

import '../utils/utils.dart';
import '../widgets/InputFields.dart';
import '../widgets/base_page.dart';

class PhoneLoginPage extends BasePage {
  PhoneLoginPage({Key key}) : super(key: key);

  @override
  PhoneLoginPageState createState() => PhoneLoginPageState();
}

// 首页
class PhoneLoginPageState extends BasePageState<PhoneLoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _phoneCodeRegion = "+86";
  var _phoneCodeNumber = "";
  var _phoneCodeVerify = "";
  var _phoneCodeSeconds = 0;
  var _phoneCodeTimer;

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  void _startTimer() {
    _phoneCodeSeconds = 60;
    setState(() {});

    _cancelTimer();
    _phoneCodeTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_phoneCodeSeconds <= 0) {
        _cancelTimer();
        return;
      }

      --_phoneCodeSeconds;
      setState(() {});
    });
  }

  void _cancelTimer() {
    _phoneCodeTimer?.cancel();
    _phoneCodeTimer = null;
  }

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            child: Text(
              '',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 60),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: Utils.noNull(
                [
                  _buildPhoneNumberField(context),
                  _buildPhoneCodeField(context),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 44,
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    color: Color(0xFFFFAF4C),
                    onPressed: () {
                      displayProgressIndicator(true);
                      CustomerApi().MobileLogin(
                          context,
                          _phoneCodeRegion + _phoneCodeNumber,
                          _phoneCodeVerify,
                          true);
                      displayProgressIndicator(false);
                    },
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            child: Text('小买卖圈账号登录'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return Row(
//      mainAxisSize: MainAxisSize.max,
      children: [
        CountryCodePicker(
          onChanged: (CountryCode e) {
            _phoneCodeRegion = e.dialCode;
          },
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'CN',
          favorite: ['CN', 'GB'],
        ),
        Expanded(
          child: InputFieldArea(
            hint: "请输入手机号",
            obscure: false,
            initialValue: _phoneCodeNumber,
            onSaved: (value) => _phoneCodeNumber = value,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneCodeField(BuildContext context) {
    return Row(children: [
      Expanded(
          child: InputFieldArea(
        hint: "短信动态密码",
        initialValue: _phoneCodeVerify,
        obscure: true,
        icon: Icons.lock_outline,
        onSaved: (value) => _phoneCodeVerify = value,
      )),
      Container(
          height: 40,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(5.0)),
          ),
          child: FlatButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).disabledColor,
              onPressed: _phoneCodeSeconds > 0
                  ? null
                  : () {
                      _formKey.currentState.save();
                      CustomerApi().SendMobileVerificationCode(
                          context, _phoneCodeRegion + _phoneCodeNumber);
                      _startTimer();
                    },
              child: Text(
                  "发送动态密码${_phoneCodeSeconds > 0 ? '($_phoneCodeSeconds秒)' : ''}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary))))
    ]);
  }
}
