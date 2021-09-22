import 'package:flutter/material.dart';

BoxDecoration shadowDecoration() {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color(0x15000000),
        blurRadius: 2.0, // has the effect of softening the shadow
        spreadRadius: 2.0, // has the effect of extending the shadow
        offset: Offset(
          0.0, // horizontal, move right 10
          0.0, // vertical, move down 10
        ),
      )
    ]
  );
}