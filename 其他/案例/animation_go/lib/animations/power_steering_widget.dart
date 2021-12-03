import 'package:animation_go/power_steering/power_steering_widget.dart';
import 'package:flutter/material.dart';

class PowerSteeringDemo extends StatefulWidget {
  @override
  _PowerSteeringDemoState createState() => _PowerSteeringDemoState();
}

class _PowerSteeringDemoState extends State<PowerSteeringDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PowerSteeringWidget(
            onChange: (e) {
              print(e);
            },
          ),
        ],
      ),
    );
  }
}
