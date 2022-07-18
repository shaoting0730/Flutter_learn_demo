import 'package:flutter/material.dart';
import 'package:inherite_widget_demo/userinfo_widget.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二'),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.beach_access),
        onPressed: () {
          UserInfoWidget.of(context).updateUserBean('flutter666', 'China加油');
        },
      ),
      body: ListView(
        children: <Widget>[
          Text(UserInfoWidget.of(context).userBean.name),
          Text(UserInfoWidget.of(context).userBean.address),
        ],
      ),
    );
  }
}
