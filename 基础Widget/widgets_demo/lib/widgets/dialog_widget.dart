import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('showDialog'),
            onPressed: () {
              showDialog<Null>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: new Text('标题'),
                    content: new SingleChildScrollView(
                      child: new ListBody(
                        children: <Widget>[
                          new Text('内容 1'),
                          new Text('内容 2'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('确定'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ).then((val) {
                print(val);
              });
            },
          ),
          MaterialButton(
            child: Text('MaterialButton'),
            onPressed: () {
              showDialog<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: new Text('选择'),
                    children: <Widget>[
                      new SimpleDialogOption(
                        child: new Text('选项 1'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new SimpleDialogOption(
                        child: new Text('选项 2'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ).then((val) {
                print(val);
              });
            },
          )
        ],
      ),
    );
  }
}
