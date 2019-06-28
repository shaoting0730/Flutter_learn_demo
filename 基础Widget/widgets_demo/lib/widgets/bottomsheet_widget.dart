import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key key}) : super(key: key);

  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('showModalBottomSheet'),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return new Container(
                    height: 300.0,
                    child: Icon(
                      Icons.accessibility,
                      size: 200,
                    ),
                  );
                },
              ).then((val) {
                print(val);
              });
            },
          ),
          RaisedButton(
            child: Text('BottomSheet'),
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.shop_two), onPressed: () {}),
                        IconButton(icon: Icon(Icons.shop_two), onPressed: () {})
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
