import 'dart:async';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Timer _timer;
  int _countdownTime = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (_countdownTime == 0) {
            //Http请求发送验证码
            setState(() {
              _countdownTime = 60;
            });
            //开始倒计时
            startCountdownTimer();
          }
        },
        child: Text(
          _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
          style: TextStyle(
            fontSize: 14,
            color: _countdownTime > 0 ? Colors.black : Colors.red,
          ),
        ),
      ),
    );
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
