import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_field.dart';
import '../service/baseapi.dart';


typedef SendMessageTapCallback = void Function();


class SMSVerificationCodeField extends InputField {

  final SendMessageTapCallback onSendMessageTap;

  SMSVerificationCodeField({Key key, this.onSendMessageTap}): super(key:key);

  @override
  State<SMSVerificationCodeField> createState() {
    return SMSVerificationCodeFieldState();
  }
}

class SMSVerificationCodeFieldState extends InputFieldState<SMSVerificationCodeField> {

  String get verifyCode => _verifyCode;

  int _seconds = 0;
  String _verifyCode = '';
  String _verifyStr = _localizedValues[getLocaleCode()]["send_message"];
  Timer _timer;

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'send_message': "Send Message",
      'resent_message':'Resent Message'
    },
    'zh': {
      'send_message': "发送短信",
      'resent_message':'重新发送短信'
    },
  };

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }


  void _startTimer() {
    _seconds = 30;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }

      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      
      if (_seconds == 0) {
        _verifyStr = _localizedValues[getLocaleCode()]["resent_message"];
      }
    });
  }

   void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget buildFieldContent(BuildContext context) {

    Widget verifyCodeBtn = new InkWell(
      onTap: (_seconds == 0)
          ? () {
            if(widget.onSendMessageTap != null) {
             widget.onSendMessageTap();
            }
              setState(() {
                _startTimer();
              });
            }
          : null,
      child: new Container(
        alignment: Alignment.center,
        width: 130.0,
        height: 40.0,
        child: new Text(
          '$_verifyStr',
          style: new TextStyle(fontSize: 14.0, color:Color(0xFF727E98)),
        ),
      ),
    );

    var node = new FocusNode();
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child:TextField(
              onChanged: (str) {
                _verifyCode = str;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                border: InputBorder.none
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              onSubmitted: (text) {
                FocusScope.of(context).reparentIfNeeded(node);
              }
            )
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: Color(0xFF727E98),
          ),
          verifyCodeBtn
        ],
      ),
    );
  }

}