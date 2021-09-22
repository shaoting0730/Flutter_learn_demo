import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/login/styles.dart';
import '../../services/baseapi.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _initialized = false;

  Widget build(BuildContext context) {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () async {
        var login = await BaseApi().loadLoginResponse(context);
        if (login != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: backgroundImage,
        ),
        child: Text('...'),
      ),
    );
  }
}
