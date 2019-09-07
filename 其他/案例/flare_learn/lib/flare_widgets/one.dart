import 'package:flutter/material.dart';
import 'package:nima/nima_actor.dart';

class One extends StatefulWidget {
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  String _animationName = "idle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: NimaActor(
              "assets/Hop.nima",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: _animationName,
              mixSeconds: 0.5,
              completed: (String animationName) {
                setState(
                  () {
                    // Return to idle.
                    _animationName = "idle";
                  },
                );
              },
            ),
          ),
          Positioned.fill(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: FlatButton(
                    child: Text("Jump"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      setState(
                        () {
                          _animationName = "jump";
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: FlatButton(
                    child: Text("Attack"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      setState(
                        () {
                          _animationName = "attack";
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
