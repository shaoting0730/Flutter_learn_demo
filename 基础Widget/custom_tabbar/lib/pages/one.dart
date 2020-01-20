import 'package:flutter/material.dart';

class One extends StatefulWidget {
  Function changeTabOne;
  Function changeTabTwo;
  Function changeTabThree;

  One({
    Key key,
    @required this.changeTabOne(double num),
    @required this.changeTabTwo(),
    @required this.changeTabThree(),
  }) : super(key: key);
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  double _one = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One'),
      ),
      body: ListView(
        children: <Widget>[
//         整体高度 60 - 500
          Slider(
            value: _one,
            min: 60,
            max: 500,
            onChanged: (e) {
              setState(() {
                _one = e;
              });
              widget.changeTabOne(e);
            },
          ),
//       高度0
          FlatButton(
            onPressed: () {
              widget.changeTabTwo();
            },
            child: Text('高度为0'),
          ),
//          高度70
          FlatButton(
            onPressed: () {
              widget.changeTabThree();
            },
            child: Text('高度为70'),
          )
        ],
      ),
    );
  }
}
