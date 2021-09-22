import 'package:flutter/material.dart';
import './base_page.dart';
import '../pages/my_plans_page.dart';
import '../widgets/phone_field.dart';
import '../widgets/sms_verification_code_field.dart';
import '../widgets/password_field.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';
import '../pages/message_page.dart';
import '../pages/my_lockers_page.dart';
import '../pages/my_houses_page.dart';

class ResetPasswordPage extends BasePage {

  
  ResetPasswordPage();

  @override
  State<ResetPasswordPage> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends BasePageState<ResetPasswordPage> {
  
  final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();
  final _passwordKey = GlobalKey<PasswordFieldState>();
  final _passwordKey2 = GlobalKey<PasswordFieldState>();
  final _verifyCodeKey =GlobalKey<SMSVerificationCodeFieldState>();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'imlockbox':'Imlockbox',
      'phone_number':'Phone Number',
      'message_code':'Message Code',
      'password':'Password',
      'reset_password': "Reset password",
      'confirm_password':'Confirm Password',
      'register_account':'Register Account',
      'reset':'Reset',
      'sms_verificaiton_code_sent':"SMS verfication code is sent",
      'error_phone_number':'Please fill in Phone Number',
      'error_password':'Your password and confirmation password do not match',
      'error_verification_code':"Please fill in Verification Code"
    },
    'zh': {
      'imlockbox':'盒心锁盒',
      'phone_number':'手机',
      'message_code':'短信验证码',
      'password':'密码',
      'reset_password': "重置密码",
      'confirm_password':'确定密码',
      'register_account':'注册账号',
      'reset':'重置',
      'sms_verificaiton_code_sent':"短信验证码已发送",
      'error_phone_number':'请输入电话号码',
      'error_password':'两次密码输入不对',
      'error_verification_code':"请输入验证码"
    },
  };
  @override
  void initState() {
    super.initState();
    hiddenAppBar = true;
  }
  
  @override
  Widget pageContent(BuildContext context) {
    return Stack(
      children: <Widget>[    
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(),
                _buildTitle(),
                _buildPhoneNumber(),
                _buildMessageCode(context),
                _buildPassword(),
                _buildRepeatPassword(),
                SizedBox(height: 60,),
                _buildSignInButton(context)
              ],
            ),
          )
        ),
        Positioned(
          left: 10,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 30,
                child: Image.asset('assets/ic_back.png'),
              ),
            )
          )
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 90,
      width: double.infinity,
      color: Color(0xFF536282),
      alignment: Alignment(0, 0.5),
      child: Text(isOnlyForPerson ? _localizedValues[getLocaleCode()]["imlockbox"]:  "ReliableShowing", style: TextStyle(fontSize: 24, color: Colors.white),),
    );
  }

  Widget _buildTitle() {
    var title = _localizedValues[getLocaleCode()]["reset_password"];
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
            onSendMessageTap: (){
              _onSendMessageTapped(context);
            },
          )
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
          PasswordFeild(key: _passwordKey,)
        ],
      ),
    );
  }
  Widget _buildRepeatPassword() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["confirm_password"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PasswordFeild(key: _passwordKey2,)
        ],
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    var title = _localizedValues[getLocaleCode()]["reset"];

    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        onPressed: () {
          _onTapSignUp(context);
        },
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  void _onSendMessageTapped(BuildContext context)  async {
    showToastMessage(context, _localizedValues[getLocaleCode()]["sms_verificaiton_code_sent"]);
    UserServerApi().sendMobileVerificationCode(_phoneNumberKey.currentState.phoneNumber());
  }

  void _onTapSignUp(BuildContext context) async {
    if(_phoneNumberKey.currentState.phoneNumber() == null || _phoneNumberKey.currentState.phoneNumber() == "") {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_phone_number"]);
      return;
    }

    if(_passwordKey.currentState.password == null || _passwordKey.currentState.password !=_passwordKey2.currentState.password) {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_password"]);
      return;
    }

    if(_verifyCodeKey.currentState.verifyCode == null || _verifyCodeKey.currentState.verifyCode == "") {
      showErrorMessage(context, _localizedValues[getLocaleCode()]["error_verification_code"]);
      return;
    }

    displayProgressIndicator(true); 
    var response = await UserServerApi().PasswordRecoveryByMobileVerification(context, _phoneNumberKey.currentState.phoneNumber(), _verifyCodeKey.currentState.verifyCode, _passwordKey.currentState.password);
    displayProgressIndicator(false);
    if(response != null) {
      if(isAgent)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyPlansPage(pageIndex:0),
        )
        );
      else if(isAgentAssistant)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MessagePage(),
        )
        );
      else if(isHouseOwner)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHousesPage(),
        )
        );
      else
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyLockersPage(canPop: false,),
        )
        );
    } 
  }
}

