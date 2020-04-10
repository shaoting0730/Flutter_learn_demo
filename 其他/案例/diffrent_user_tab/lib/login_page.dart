import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_one_app.dart';
import './user_two_app.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: returnUserTag(),
      builder: (context, snap) {
        if (snap.data == 'user_one') {
          return createOneApp();
        } else if (snap.data == 'user_two') {
          return createTwoApp();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('登录'),
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('loginTag', 'user_one');

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => createOneApp()),
                        (route) => route == null);
                  },
                  child: Text('用户1登录'),
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('loginTag', 'user_two');

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => createTwoApp()),
                        (route) => route == null);
                  },
                  child: Text('用户2登录'),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Future<String> returnUserTag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginTag');
  }
}
