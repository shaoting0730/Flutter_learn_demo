import 'package:flutter/material.dart';
import './alertDemo/simple_dialog_demo.dart';
import './alertDemo/alert_dialog_demo.dart';
import './alertDemo/bottom_sheet_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
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
      appBar: AppBar(title: Text('弹出框')),
      body: ListView(
        children: <Widget>[
          FlatButton(
            child: Text('SimpleDialog'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new SimpleDialogDemo(),
                  ));
            },
          ),
          FlatButton(
            child: Text('AlertDialog'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new AlertDialogDemo(),
                  ));
            },
          ),
          FlatButton(
            child: Text('BottomSheet'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new BottomSheetDemo(),
                  ));
            },
          ),
          SnackBarDemo(),
        ],
      ),
    );
  }
}

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('SnackBar'),
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(
            content: Text('SnackBarDemo'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ));
        },
      ),
    );
  }
}
