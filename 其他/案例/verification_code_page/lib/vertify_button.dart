// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
typedef CustomFutureBuilder = Future<bool> Function();

class VerificationCodeButton extends StatefulWidget {
  final CustomFutureBuilder onTap;
  final String tag;
  final TextStyle style;
  final TextStyle disableStyle;
  const VerificationCodeButton(
    this.tag,
    this.onTap, {
    Key? key,
    this.disableStyle = const TextStyle(color: Color(0xff999999), fontSize: 12),
    this.style = const TextStyle(color: Color(0xFF4F65EE), fontSize: 12),
  }) : super(key: key);

  @override
  _VerificationCodeState createState() {
    return _VerificationCodeState();
  }
}

class _VerificationCodeState extends State<VerificationCodeButton> {
  late int num;
  String text = '获取验证码';
  bool disabled = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      String? temp = value.getString(widget.tag);
      if (temp == null || temp.isEmpty) {
        return;
      }
      var duration = DateTime.now().difference(DateTime.parse(temp));
      final seconds = duration.inSeconds;

      if (seconds < 60) {
        num = 60 - seconds;
        _startCountDown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(text, style: disabled ? widget.disableStyle : widget.style),
      onTap: disabled
          ? null
          : () async {
              if (widget.onTap == null) {
                return;
              }
              bool isIntercept = await widget.onTap();
              if (isIntercept) {
                //onTap返回true则return
                return;
              }
              SharedPreferences.getInstance().then((value) {
                value.setString(widget.tag, DateTime.now().toIso8601String());
                num = 59;
                _startCountDown();
              });
            },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  _startCountDown() {
    setState(() {
      disabled = true;
      text = '重新发送$num秒';
    });
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      num--;
      setState(() {
        text = '重新发送$num秒';
      });
      if (num == 0) {
        timer.cancel();
        setState(() {
          disabled = false;
          text = '获取验证码';
        });
      }
    });
  }
}

class RoundVerificationCodeButton extends StatefulWidget {
  final onTap;
  final String tag;
  final TextStyle style;
  final TextStyle disableStyle;
  const RoundVerificationCodeButton(this.tag, this.onTap,
      {Key? key,
      this.disableStyle =
          const TextStyle(color: Color(0xff999999), fontSize: 12),
      this.style = const TextStyle(color: Color(0xFF4F65EE), fontSize: 12)})
      : super(key: key);

  @override
  _RoundVerificationCodeState createState() {
    return _RoundVerificationCodeState();
  }
}

class _RoundVerificationCodeState extends State<RoundVerificationCodeButton> {
  late int num;
  String text = '获取验证码';
  bool disabled = false;

  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: InkWell(
        child: Text(text, style: disabled ? widget.disableStyle : widget.style),
        onTap: disabled
            ? null
            : () async {
                if (widget.onTap == null) {
                  return;
                }
                bool isIntercept = await widget.onTap();
                if (isIntercept) {
                  //onTap返回true则return
                  return;
                }
                SharedPreferences.getInstance().then((value) {
                  value.setString(widget.tag, DateTime.now().toIso8601String());

                  num = 59;
                  _startCountDown();
                });
              },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  _startCountDown() {
    setState(() {
      disabled = true;
      text = '${num}S后重新获取';
    });
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      num--;
      setState(() {
        text = '${num}S后重新获取';
      });
      if (num == 0) {
        timer.cancel();
        setState(() {
          disabled = false;
          text = '获取验证码';
        });
      }
    });
  }
}
