import 'package:flutter/material.dart';
import 'styles.dart';
import 'login_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils.dart';
import '../base_page.dart';
import '../../widgets/WhiteTick.dart';
import '../../models/loginmodel.dart';
import '../../services/serviceapi.dart';
import '../../widgets/InputFields.dart';

class LoginScreen extends BasePage {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BasePageState<LoginScreen> {
  AnimationController _loginButtonController;
  var _animationStatus = 0;

  var _phoneCodeSeconds = 0;
  var _phoneCodeTimer;

  var _phoneCodeRegion = "+86";
  var _phoneCodeNumber = "";
  var _phoneCodeVerify = "";

  var _userName = "";
  var _userPassword = "";
  var _referCode = "";

  bool passwordLogin = false;
  bool rememberMe = true;
  bool _isRegister = false;

  final _formKey = GlobalKey<FormState>();

  var _agreementAccepted = false;

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
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

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (WillPopScope(
      onWillPop: Utils.genOnWillPop(context),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: backgroundImage,
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                const Color.fromRGBO(162, 146, 199, 0.2),
                const Color.fromRGBO(51, 51, 63, 0.8),
              ],
              stops: [0.2, 1.0],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            )),
            child: ListView(
              children: [
                new Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigLogo(image: tick),
                        SizedBox(height: 330),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: Utils.noNull(passwordLogin
                                  ? [
                                      _buildUsernameField(context),
                                      _buildPasswordField(context),
                                      _buildAcceptAgreementField(context),
                                    ]
                                  : [
                                      _buildPhoneNumberField(context),
                                      _buildPhoneCodeField(context),
                                      _isRegister
                                          ? _buildReferCode(context)
                                          : null,
                                      _buildAcceptAgreementField(context),
                                    ]),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/topic",
                                      arguments: {'name': 'LoginHelp'});
                                },
                                child: Text(
                                  "无法收到验证码？",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _formKey.currentState.save();
                                  setState(() {
                                    passwordLogin = !passwordLogin;
                                  });
                                },
                                child: Text(
                                  passwordLogin
                                      ? "手机验证码登录"
                                      : (_isRegister ? "" : "账号密码登录"),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.amberAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                _formKey.currentState.save();
                                setState(() {
                                  _isRegister = !_isRegister;
                                });
                              },
                              child: Text(
                                passwordLogin
                                    ? ""
                                    : (_isRegister ? "已有账号登录" : "注册新账号"),
                                style: AimTheme.text12Grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 115),
                      child: _animationStatus == 0
                          ? InkWell(
                              onTap: () async {
                                if (!_agreementAccepted) {
                                  Utils.alert(context,
                                      title: "用户协议",
                                      content: '请先勾选 “已阅读并同意协议”');
                                  return;
                                }

                                LoginResponseModel response;
                                _formKey.currentState.save();
                                displayProgressIndicator(true);
                                if (passwordLogin) {
                                  response = await UserServerApi()
                                      .userLoginByPassword(context, _userName,
                                          _userPassword, rememberMe);
                                } else {
                                  response = await UserServerApi()
                                      .userLoginByVerificationCode(
                                          context,
                                          _phoneCodeRegion + _phoneCodeNumber,
                                          _phoneCodeVerify,
                                          _referCode,
                                          _isRegister,
                                          rememberMe);
                                }
                                displayProgressIndicator(false);

                                if (response != null) {
                                  if (response.ErrorMessage == null ||
                                      response.ErrorMessage.isEmpty) {
                                    setState(() {
                                      _animationStatus = 1;
                                    });
                                    _playAnimation();
                                  } else if (response.ErrorMessage ==
                                      "NotRegistered") {
                                    Utils.confirm(context,
                                        content: "您还没有账号，请先注册账号。",
                                        cancelText: '重新登录',
                                        confirmText: '去注册',
                                        onConfirmPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _isRegister = true;
                                      });
                                    });
                                  }
                                }
                              },
                              child: _buildLoginButton(context))
                          : StaggerAnimation(
                              buttonController: _loginButtonController.view),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    var list = List<Widget>();
    list.add(DropdownButton(
      value: _phoneCodeRegion,
      onChanged: (String newValue) {
        setState(() {
          _phoneCodeRegion = newValue;
        });
      },
      style: const TextStyle(
        color: Colors.amber,
      ),
      underline: Text(''),
      items: ['+86', '+44', '+1'].map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));

    list.add(Expanded(
      child: InputFieldArea(
        hint: "请输入手机号",
        obscure: false,
        initialValue: _phoneCodeNumber,
        onSaved: (value) => _phoneCodeNumber = value,
      ),
    ));
    return Container(
      child: Row(children: list),
    );
  }

  Widget _buildPhoneCodeField(BuildContext context) {
    return Row(children: [
      Expanded(
          child: InputFieldArea(
        hint: "请输入验证码",
        initialValue: _phoneCodeVerify,
        obscure: false,
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
                      UserServerApi().sendMobileVerificationCode(
                          _phoneCodeRegion + _phoneCodeNumber);
                      _startTimer();
                    },
              child: Text(
                  "发送验证码${_phoneCodeSeconds > 0 ? '($_phoneCodeSeconds秒)' : ''}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary))))
    ]);
  }

  Widget _buildUsernameField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputFieldArea(
            hint: "请输入用户名",
            obscure: false,
            initialValue: _userName,
            icon: Icons.person,
            onSaved: (value) => _userName = value,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputFieldArea(
            hint: "请输入密码",
            initialValue: _userPassword,
            obscure: true,
            icon: Icons.lock_outline,
            onSaved: (value) => _userPassword = value,
          ),
        ),
      ],
    );
  }

  _buildReferCode(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputFieldArea(
            hint: "请输入推荐码（必填）",
            initialValue: _referCode,
            obscure: false,
            icon: Icons.contact_mail,
            onSaved: (value) => _referCode = value,
          ),
        ),
      ],
    );
  }

  Container _buildLoginButton(BuildContext context) {
    return Container(
      width: 320.0,
      height: 48.0,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: _agreementAccepted
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Text(
        _isRegister ? "注册" : "登录",
        style: TextStyle(
          color: _agreementAccepted ? Colors.white : Colors.white70,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildAcceptAgreementField(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _agreementAccepted = !_agreementAccepted;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _agreementAccepted
                    ? Icon(
                        Icons.check_box,
                        color: Colors.white70,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.white70,
                      ),
              ],
            ),
          ),
          Text(
            '我已阅读并同意',
            style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                decoration: TextDecoration.underline),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/user_agreement');
            },
            child: Text(
              '《海创小目标用户协议》',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  decoration: TextDecoration.underline),
            ),
          ),
          Text(
            '和',
            style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                decoration: TextDecoration.underline),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/topic",
                  arguments: {'name': 'privacypolicy'});
            },
            child: Text(
              '《隐私权政策》',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
