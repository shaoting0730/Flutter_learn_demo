import 'package:flutter/material.dart';
import './userinfo_widget.dart';
import './user_bean.dart';
import './details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserInfoWidget(
      userbean: UserBean(name: "flutter", address: "China"),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheriteWidget学习'),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.gps_fixed),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(),
            ),
          );
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
