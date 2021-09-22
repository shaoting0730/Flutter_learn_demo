import 'package:flutter/material.dart';
import '../models/loginmodel.dart';
import '../pages/signup_real_estate_agent_page.dart';
import './base_page.dart';
import '../pages/my_plans_page.dart';
import '../widgets/phone_field.dart';
import '../widgets/sms_verification_code_field.dart';
import '../widgets/password_field.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';
import '../pages/my_lockers_page.dart';
import '../pages/my_houses_page.dart';
import '../widgets/text_field.dart';
import '../widgets/email_field.dart';


class SignUpPage extends BasePage {

  final bool signup;

  SignUpPage({this.signup = false});

  @override
  State<SignUpPage> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends BasePageState<SignUpPage> {
  
  final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();
  final _passwordKey = GlobalKey<PasswordFieldState>();
  final _passwordKey2 = GlobalKey<PasswordFieldState>();
  final _verifyCodeKey =GlobalKey<SMSVerificationCodeFieldState>();
  final _firstNameKey = GlobalKey<TextInputFieldState>();
  final _lastNameKey = GlobalKey<TextInputFieldState>();
  final _emailKey = GlobalKey<EmailFieldState>();
  final _nicknameKey = GlobalKey<TextInputFieldState>();

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    hiddenAppBar = true;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': "Individual Sign Up",
      'agree': 'I agree to the Term of User Privacy Policy',
      'email': 'Email',
      'nickname': 'Nickname',
      'first_name':'First Name',
      'last_name':'Last Name',
      'sign_up': "Sign up",
      'phone_number':'Phone Number',
      'message_code':'Message Code',
      'password':'Password',
      'confirm_password':'Confirm Password',
      'please_select_verification_code':"Please select a way to send the Verification Code",
      'email_verification_code_sent':'Email verfication code is sent',
      'sms_verificaiton_code_sent':"SMS verfication code is sent",
      'error_phone_number':'Please fill in Phone Number',
      'error_password':'Your password and confirmation password do not match',
      'error_verification_code':"Please fill in Verification Code",
      'error_first_name':"Please fill in First Name",
      'error_last_name':'Please fill in Last Name',
      'error_email': 'Please fill in email',
      'error_nickname': 'Please fill in nickanem',
      'telphone':"Telphone"
    },
    'zh': {
      'title': "个人注册",
      'agree': '我同意用户协议',
      'email': '邮件',
      'nickname': '昵称',
      'first_name': '姓',
      'last_name': '名',
      'sign_up': "注册",
      'phone_number':'手机',
      'message_code':'短信验证码',
      'password':'密码',
      'confirm_password':'确认密码',
      'please_select_verification_code':"请选择发送验证码的途径",
      'email_verification_code_sent':'邮件验证码已经发送',
      'sms_verificaiton_code_sent':"短信验证码已发送",
      'error_phone_number':'请输入电话号码',
      'error_password':'两次密码输入不对',
      'error_verification_code':"请输入验证码",
      'error_first_name':"请输入姓",
      'error_last_name':'请输入名',
      'error_email': '请输入Email',
      'error_nickname': '请输入昵称',
      'telphone':"手机"
    },
  };


  
  @override
  Widget pageContent(BuildContext context) {

    var list = List<Widget>();
    list.add(_buildHeader());
    list.add(_buildTitle());
    if(isOnlyForPerson == false) {
      list.add(_buildUsername());
      list.add(_buildEmail());      
    }
    
    list.add(_buildPhoneNumber());
    list.add(_buildMessageCode(context));
    if(isOnlyForPerson) {
      list.add(_buildNickname());
    }
    
    list.add(_buildPassword());
    list.add(_buildRepeatPassword());
    list.add(_buildLicense());
    list.add(_buildSignInButton(context));
    return Stack(
      children: <Widget>[    
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
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

  Widget _buildLicense() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: Color(0xFF536282),
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
          ), 
          Text(_localizedValues[getLocaleCode()]["agree"], style: TextStyle(color: Color(0xFF536282), fontSize: 12),)
        ]
      ),
    );
  }

  Widget _buildEmail() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["email"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          EmailField(key: _emailKey,)
        ],
      ),
    );
  }

  Widget _buildNickname() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_localizedValues[getLocaleCode()]["nickname"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _nicknameKey,)
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(  
              margin: const EdgeInsets.fromLTRB(15, 0, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_localizedValues[getLocaleCode()]["first_name"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
                  SizedBox(height: 7,),
                  TextInputField(key: _firstNameKey,)
                ],
              ),
            ),
            flex: 1
          ),
          Expanded(
            child: Container(  
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_localizedValues[getLocaleCode()]["last_name"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
                  SizedBox(height: 7,),
                  TextInputField(key: _lastNameKey,)
                ],
              ),
            ),
            flex: 1,
          ),
        ]
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: Color(0xFF536282),
      alignment: AlignmentDirectional.bottomCenter,
      child: SafeArea(
        bottom: false,
        child: Text(_localizedValues[getLocaleCode()]["title"], style: TextStyle(fontSize: 24, color: Colors.white),)
      )
    );
  }

  Widget _buildTitle() {
    List<Widget> children = List<Widget>();
    children.add(Expanded(
      child: Text(_localizedValues[getLocaleCode()]["sign_up"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF536282))),
    ));
    if(!isOnlyForPerson)
      children.add(InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRealEstateAgentPage()));
        },
        child: Text( "Real Estate Agent Click Here>", style: TextStyle(fontSize: 14, color: Color(0xFF536282))),
      ));
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      child: Row(
        children: children
      )
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
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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

    Function handle = () {
      _onTapSignUp(context);
    };
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        onPressed: isChecked? handle : null,
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text(_localizedValues[getLocaleCode()]["sign_up"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  void _onSendMessageTapped(BuildContext context)  async {

    if(isOnlyForPerson) {
      showToastMessage(context, _localizedValues[getLocaleCode()]["sms_verificaiton_code_sent"]);
      UserServerApi().sendMobileVerificationCode(_phoneNumberKey.currentState.phoneNumber());
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: getLocaleCode() == 'en'?135:115,
            width: 270,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text(_localizedValues[getLocaleCode()]["please_select_verification_code"]),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        showToastMessage(context, _localizedValues[getLocaleCode()]["email_verification_code_sent"]);
                        UserServerApi().sendEmailVerificationCode(_emailKey.currentState.email);
                      },
                      child:  Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide( 
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                          child: Text(_localizedValues[getLocaleCode()]["email"]),
                        )
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        showToastMessage(context, _localizedValues[getLocaleCode()]["sms_verificaiton_code_sent"]);
                        UserServerApi().sendMobileVerificationCode(_phoneNumberKey.currentState.phoneNumber());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                        child: Text(_localizedValues[getLocaleCode()]["telphone"]),
                      )
                    ),
                  ]
                )
              ]
            )
          )
        );
      },
    );
  }

  void _onTapSignUp(BuildContext context) async {
    if(isOnlyForPerson == false ) {
      if(_firstNameKey.currentState.text == null || _firstNameKey.currentState.text == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_first_name"]);
        return;
      }
      if(_lastNameKey.currentState.text == null || _lastNameKey.currentState.text == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_last_name"]);
        return;
      }

      if(_emailKey.currentState.email == null || _emailKey.currentState.email == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_email"]);
        return;
      }
    }
    
    if(isOnlyForPerson) {
      if(_nicknameKey.currentState.text == null || _nicknameKey.currentState.text == "") {
        showErrorMessage(context, _localizedValues[getLocaleCode()]["error_nickname"]);
        return;
      }
    }

    

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
    LoginResponseModel response;
    if(isOnlyForPerson) {
      response = await UserServerApi().userRegisterForPersonalOnly(context, _nicknameKey.currentState.text, _phoneNumberKey.currentState.phoneNumber(), _passwordKey.currentState.password, _verifyCodeKey.currentState.verifyCode);
    } else {
      response = await UserServerApi().userRegister(context, _firstNameKey.currentState.text, _lastNameKey.currentState.text, _phoneNumberKey.currentState.phoneNumber(), _emailKey.currentState.email, _passwordKey.currentState.password, _verifyCodeKey.currentState.verifyCode);
    }
    
    displayProgressIndicator(false);
    if(response != null) {
      if(isAgent)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyPlansPage(pageIndex:0),
        )
        );
      else if(isAgentAssistant)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyLockersPage(canPop: false,),
        )
        );
      else if(isHouseOwner)
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHousesPage(canPop: false,),
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

