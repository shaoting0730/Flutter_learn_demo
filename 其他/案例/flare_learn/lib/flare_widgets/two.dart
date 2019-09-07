import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Two extends StatefulWidget {
  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        "assets/Teddy.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "idle",
      ),
    );
  }
}
