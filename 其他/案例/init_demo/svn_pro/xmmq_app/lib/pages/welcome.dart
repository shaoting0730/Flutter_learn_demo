import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../serviceapi/customerapi.dart';
import '../serviceapi/baseapi.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _initialized = false;

  Widget build(BuildContext context) {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () async {
        CustomerApi().verifyLoginState(context);
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            //image: backgroundImage,
            ),
        child: Text('...'),
      ),
    );
  }
}
