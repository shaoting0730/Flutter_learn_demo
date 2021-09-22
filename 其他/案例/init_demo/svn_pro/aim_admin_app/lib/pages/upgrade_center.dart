import 'package:aimoversea_admin_app/pages/topic.dart';
import 'package:aimoversea_admin_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpgradeCenter extends StatefulWidget {
  UpgradeCenter({Key key}) : super(key: key);

  @override
  _UpgradeCenterState createState() => new _UpgradeCenterState();
}

class _UpgradeCenterState extends State<UpgradeCenter> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
        centerTitle: true,
        actions: [
          MaterialButton(
            child: Text('会员协议', style: TextStyle(color: Colors.white70)),
            onPressed: () {
              Navigator.pushNamed(context, '/topic',
                  arguments: {'name': 'customerservicepolicy'});
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Topic(
                hasAppBar: false,
                topicName: 'membership',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('星钻申请'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customer_request',
                        arguments: {'title': '星钻申请', 'service': '2'});
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: AimTheme.text16White.color,
                  child: Text('至尊申请'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customer_request',
                        arguments: {'title': '至尊申请', 'service': '3'});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
