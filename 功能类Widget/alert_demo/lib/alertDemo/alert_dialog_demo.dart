import 'package:flutter/material.dart';
enum Option {
  Cancel,OK
}
class AlertDialogDemo extends StatefulWidget {
  @override
  _AlertDialogDemoState createState() => _AlertDialogDemoState();
}

class _AlertDialogDemoState extends State<AlertDialogDemo> {
   String _result = 'value';
   
  Future _openAlertDialog() async{
    final option = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title:Text('AlertDialog'),
          content: Text('你确定?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: (){
                  Navigator.pop(context,Option.Cancel);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                  Navigator.pop(context,Option.OK);
              },
            )
          ],
        );
      }

    );
    switch(option){
      case Option.Cancel:
      setState(() {
        _result = 'Cancel';
      });
      break;
       case Option.OK:
      setState(() {
        _result = 'OK';
      });
      break;
      default:
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SimpleDialogDemo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_result'),
            FlatButton(
                child: Text('AlertDialogDemo'), onPressed: _openAlertDialog),
          ],
        ),
      ),
    );
  }
}