import 'dart:async';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  int _count = 30;
  IconData _actionIcon = Icons.delete;

  late Timer _timer;
  _countDownAction() {
    // ... 获取验证码
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_count > 0) {
          _count--;
        } else {
          _count = 30;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 倒计时
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              return ScaleTransition(child: child, scale: animation);
            },
            child: _count != 30
                ? Text(
                    _count.toString(),
                    //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                    key: ValueKey(_count),
                  )
                : InkWell(
                    onTap: _countDownAction,
                    child: Text('获取验证码'),
                  ),
          ),
          //  切换按钮
          AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            duration: Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey(_actionIcon),
              icon: Icon(_actionIcon),
              onPressed: () {
                setState(
                  () {
                    if (_actionIcon == Icons.delete)
                      _actionIcon = Icons.done;
                    else
                      _actionIcon = Icons.delete;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
