import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class TouchIDFaceID extends StatefulWidget {
  _TouchIDFaceIDState createState() => _TouchIDFaceIDState();
}

class _TouchIDFaceIDState extends State<TouchIDFaceID> {
  /// 本地认证框架
  final LocalAuthentication auth = LocalAuthentication();

  /// 是否有可用的生物识别技术
  bool _canCheckBiometrics;

  /// 生物识别技术列表
  List<BiometricType> _availableBiometrics;

  /// 识别结果
  String _authorized = '验证失败';

  /// 检查是否有可用的生物识别技术
  Future<Null> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  /// 获取生物识别技术列表
  Future<Null> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  /// 生物识别
  Future<Null> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: '扫描指纹进行身份验证',
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? '验证通过' : '验证失败';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('是否有可用的生物识别技术: $_canCheckBiometrics\n'),
        RaisedButton(
          child: const Text('检查生物识别技术'),
          onPressed: _checkBiometrics,
        ),
        Text('可用的生物识别技术: $_availableBiometrics\n'),
        RaisedButton(
          child: const Text('获取可用的生物识别技术'),
          onPressed: _getAvailableBiometrics,
        ),
        Text('状态: $_authorized\n'),
        RaisedButton(
          child: const Text('验证'),
          onPressed: _authenticate,
        )
      ],
    );
  }
}
