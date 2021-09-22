import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/base_page.dart';
import '../pages/my_plans_page.dart';
import '../widgets/phone_field.dart';
import '../widgets/sms_verification_code_field.dart';
import '../widgets/password_field.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';
import '../pages/message_page.dart';
import '../pages/my_lockers_page.dart';
import '../pages/my_houses_page.dart';
import '../widgets/text_field.dart';
import '../widgets/email_field.dart';
import '../widgets/step.dart';
import '../models/houseproduct.dart';

class SignupRealEstateAgentStep2Page extends BasePage {

  final MLSAgentOfficeModel model;
  final String loginId;
  SignupRealEstateAgentStep2Page({this.model, this.loginId});

  @override
  State<StatefulWidget> createState() {
    return SignupRealEstateAgentStep2PageState();
  }
}

class SignupRealEstateAgentStep2PageState extends BasePageState<SignupRealEstateAgentStep2Page> {
  final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();
  final _passwordKey = GlobalKey<PasswordFieldState>();
  final _passwordKey2 = GlobalKey<PasswordFieldState>();
  final _verifyCodeKey =GlobalKey<SMSVerificationCodeFieldState>();
  final _firstNameKey = GlobalKey<TextInputFieldState>();
  final _lastNameKey = GlobalKey<TextInputFieldState>();
  final _emailKey = GlobalKey<EmailFieldState>();

  bool isChecked = false;

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
                _buildStepHead(),
                _buildUsername(),
                _buildEmail(),
                _buildPhoneNumber(),
                _buildMessageCode(context),
                _buildPassword(),
                _buildRepeatPassword(),
                _buildLicense(),
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
          Text('I agree to the Term of User Privacy Policy', style: TextStyle(color: Color(0xFF536282), fontSize: 12),)
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
          Text('Email', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          EmailField(key: _emailKey,)
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
                  Text('First Name', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
                  Text('Last Name', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
        child: Text("Real Estate Sign Up", style: TextStyle(fontSize: 24, color: Colors.white),)
      )
    );
  }

  Widget _buildStepHead() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      alignment: AlignmentDirectional.center,
      child: StepProgress(step:1),
    );
  }

  
  Widget _buildPhoneNumber() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Phone Number', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
          Text('Message Code', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
          Text('Password', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
          Text('Confirm Password', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
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
          child: Text("Sign up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  void _onSendMessageTapped(BuildContext context)  async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: 135,
            width: 270,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text("Please select a way to send the Verification Code"),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        showToastMessage(context, "Email verfication code is sent");
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
                          child: Text("Email"),
                        )
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        showToastMessage(context, "SMS verfication code is sent");
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
                        child: Text("Telphone"),
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
    if(_firstNameKey.currentState.text == null || _firstNameKey.currentState.text == "") {
      showErrorMessage(context, "Please fill in First Name");
      return;
    }

    if(_lastNameKey.currentState.text == null || _lastNameKey.currentState.text == "") {
      showErrorMessage(context, "Please fill in Last Name");
      return;
    }

    if(_emailKey.currentState.email == null || _emailKey.currentState.email == "") {
      showErrorMessage(context, "Please fill in email");
      return;
    }

    if(_phoneNumberKey.currentState.phoneNumber() == null || _phoneNumberKey.currentState.phoneNumber() == "") {
      showErrorMessage(context, "Please fill in Phone Number");
      return;
    }

    if(_passwordKey.currentState.password == null || _passwordKey.currentState.password !=_passwordKey2.currentState.password) {
      showErrorMessage(context, "Your password and confirmation password do not match");
      return;
    }

    if(_verifyCodeKey.currentState.verifyCode == null || _verifyCodeKey.currentState.verifyCode == "") {
      showErrorMessage(context, "Please fill in Verification Code");
      return;
    }

    displayProgressIndicator(true); 
    var response = await UserServerApi().MLSMemberRegister(context, _firstNameKey.currentState.text, _lastNameKey.currentState.text, widget.loginId, _phoneNumberKey.currentState.phoneNumber(), _emailKey.currentState.email, _passwordKey.currentState.password,widget.model.OfficeID , _verifyCodeKey.currentState.verifyCode);
    displayProgressIndicator(false);
    if(response != null) {
      while(Navigator.canPop(context)) {
        Navigator.pop(context);
      }
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