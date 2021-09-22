
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import './base_page.dart';
import './reset_password_page.dart';
import '../widgets/password_field.dart';
import '../widgets/sms_verification_code_field.dart';
import '../widgets/phone_field.dart';
import '../service/serviceapi.dart';
import './my_plans_page.dart';
import '../models/loginmodel.dart';
import '../service/baseapi.dart';
import '../pages/message_page.dart';
import '../pages/my_lockers_page.dart';
import '../pages/my_houses_page.dart';
import '../pages/signup_page.dart';
import '../pages/signup_real_estate_agent_page.dart';
import 'dart:convert' as JSON;

final JPush jpush = new JPush();

class SignInPage extends BasePage {
  @override
  State<SignInPage> createState() {
    return _SignInPageState();
  }

}

class _SignInPageState extends BasePageState<SignInPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'imlockbox':'Imlockbox',
      'sign_in': "Sign in",
      'sms_sign_in': 'SMS Sign in', 
      'password_sign_in': 'Password Sign in',
      'phone_number':'Phone Number',
      'message_code':'Message Code',
      'password':'Password',
      'forget_password':'Forget Password',
      'register_account':'Register Account',
      'sms_verificaiton_code_sent':"SMS verfication code is sent",
      'error_phone_number':'Please fill in Phone Number',
      'error_password':'Please fill in password',
      'error_verification_code':"Please fill in Verification Code"
    },
    'zh': {
      'imlockbox':'盒心锁盒',
      'sign_in': "登录",
      'sms_sign_in': '短信登录',
      'password_sign_in': '密码登录', 
      'phone_number':'手机',
      'message_code':'短信验证码',
      'password':'密码',
      'forget_password':'忘记密码',
      'register_account':'注册账号',
      'sms_verificaiton_code_sent':"短信验证码已发送",
      'error_phone_number':'请输入手机号码',
      'error_password':'请输入密码',
      'error_verification_code':"请输入验证码"
    },
  };
  bool passwordLogin = true;
  bool rememberMe = true;

  final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();
  final _passwordKey = GlobalKey<PasswordFieldState>();
  final _verifyCodeKey =GlobalKey<SMSVerificationCodeFieldState>();

  @override
  void initState() {
    super.initState();

    hiddenAppBar = true;
  }

 @override
  Widget pageContent(BuildContext context) {

    var list = <Widget>[
      _buildHeader(),
      _buildTitle(),
      _buildPhoneNumber(),
    ];

    if(passwordLogin) {
      list.add(_buildPassword());
    } else {
      list.add(_buildMessageCode(context));
    }

    list.addAll(<Widget>[
      _buildRememberMeAndForgetPassword(),
      SizedBox(height: 60,),
      _buildSignInButton(context),
      
    ]);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list
                ),
              )
            ),
            Container(
              alignment: AlignmentDirectional.bottomCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _buildBottomActions(context)
            )
          ]
        )
      )
    );
  }

  Widget _buildRememberMeAndForgetPassword() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 15, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container()
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
            },
            child: Container(
              height: 40,
              alignment: Alignment(0, 0),
              child: Text( _localizedValues[getLocaleCode()]["forget_password"])
            )
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Color(0xFF536282),
      alignment: Alignment(0, 0),
      child: Text(isOnlyForPerson? _localizedValues[getLocaleCode()]["imlockbox"]: "ReliableShowing", style: TextStyle(fontSize: 24, color: Colors.white),),
    );
  }

  Widget _buildTitle() {
    String title =passwordLogin? _localizedValues[getLocaleCode()]["sign_in"] : _localizedValues[getLocaleCode()]["sms_sign_in"] ;
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF536282)),),
    );
  }


  Widget _buildPhoneNumber() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["phone_number"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PhoneNumberField(key: _phoneNumberKey)
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["password"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PasswordFeild(key: _passwordKey)
        ],
      ),
    );
  }

  Widget _buildMessageCode(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["message_code"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          SMSVerificationCodeField(
            key: _verifyCodeKey, 
            onSendMessageTap:() {
              _onSendMessageTapped(context);
            }
          )
        ],
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
        },
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          onPressed: () {
            _onTapSignIn(context);
          },
          color: Color(0xFFFF3C38),
          child: Container(
            height: 44,
            width: 200,
            alignment: Alignment(0, 0),
            child: Text(_localizedValues[getLocaleCode()]["sign_in"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
          )
        )
      )
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    String text = passwordLogin ? _localizedValues[getLocaleCode()]["sms_sign_in"]:_localizedValues[getLocaleCode()]["password_sign_in"];
    return Container (
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                passwordLogin = !passwordLogin;
              });
            },
            child: Container(
              height: 40,
              width: 120,
              alignment: Alignment(0, 0),
              child: Text(text, style: TextStyle(fontSize: 14, color: Color(0xFF536282))),
            )
          ),
          Container(
            height: 16.0,
            width: 1.0,
            color: Color(0xFF536282),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          GestureDetector(
            onTap: () {
              if(isOnlyForPerson)
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              else
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRealEstateAgentPage()));
            },
            child:Container(
              height: 40,
              width: 120,
              alignment: Alignment(0, 0),
              child: Text(_localizedValues[getLocaleCode()]["register_account"], style: TextStyle(fontSize: 14, color: Color(0xFF536282))),
            ),
          )
        ],
      ),
    );
  }

  void _onSendMessageTapped(BuildContext context)  async {
    showToastMessage(context,_localizedValues[getLocaleCode()]["sms_verificaiton_code_sent"]);
    UserServerApi().sendMobileVerificationCode(_phoneNumberKey.currentState.phoneNumber());
  }

  void _onTapSignIn(BuildContext context) async {
    if(_phoneNumberKey.currentState.phoneNumber() == null || _phoneNumberKey.currentState.phoneNumber() == "") {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_phone_number"]);
      return;
    }

    if(passwordLogin) {
      if(_passwordKey.currentState.password == null || _passwordKey.currentState.password == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_password"]);
        return;
      }
    } else {
      if(_verifyCodeKey.currentState.verifyCode == null || _verifyCodeKey.currentState.verifyCode == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_verification_code"]);
        return;
      }
    }

    displayProgressIndicator(true);
    LoginResponseModel response;
    if(passwordLogin) {
      response = await UserServerApi().userLoginByPassword(context, _phoneNumberKey.currentState.phoneNumber(), _passwordKey.currentState.password, rememberMe);
    } else {
      response = await UserServerApi().userLoginByVerificationCode(context, _phoneNumberKey.currentState.phoneNumber(), _verifyCodeKey.currentState.verifyCode, rememberMe);
    }
    
    displayProgressIndicator(false);
    if(response != null)
    {
      initPushNotification();
      if(isAgent)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyPlansPage(pageIndex:0),
            settings: RouteSettings(name: '/')
        )
        );
      else if(isAgentAssistant)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyLockersPage(canPop: false,),
            settings: RouteSettings(name: '/')
        )
        );
      else if(isHouseOwner)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHousesPage(canPop: false,),
            settings: RouteSettings(name: '/')
        )
        );
      else
        Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MyLockersPage(canPop: false,),
        settings: RouteSettings(name: '/')
        )
        );
    } 
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPushNotification() async {
    if(isOnlyForPerson)
    {
      jpush.setup(
        appKey: "4aba2811ce5959424ce7881c",
        channel: "ImLockbox",
        production: true,
        debug: false,
      );
    }
    else
    {
      jpush.setup(
        appKey: "64f017462994ea1b3fc92662",
        channel: "ReliableShowingApp",
        production: true,
        debug: false,
      );
    }

    jpush.applyPushAuthority(new NotificationSettingsIOS(
        sound: true,
        alert: true,
        badge: true));

    jpush.getRegistrationID().then((rid) {
      print("JPush RegistrationID: $rid");
      if(UserServerApi().getToken() != "" && rid != "") {
        UserServerApi().UpdateRegistrationId(rid);
      }
    });


    try {

      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");

        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");

        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");

          if(message["extras"] != null){
            Map notification;
            if(message["extras"]["cn.jpush.android.EXTRA"] != null) {
              var redirectto = message["extras"]["cn.jpush.android.EXTRA"] as String;
              var decoder = JSON.JsonDecoder();
              notification = decoder.convert(redirectto);
            } else if(message["extras"] is Map)  {
              notification = message["extras"];
            }

            if(notification != null) {
              if(notification["redirectto"] == "message_approval") {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MessagePage(curPageIndex: 0,)));
              } else if(notification["redirectto"] == "message_approval_log") {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MessagePage(curPageIndex: 1,)));
              }
            }
          }
        },
      );

    } catch(e) {
      print(e);
    }

  }

}