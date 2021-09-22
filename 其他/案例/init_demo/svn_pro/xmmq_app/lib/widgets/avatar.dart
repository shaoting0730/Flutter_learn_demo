import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  @override
  State<Avatar> createState() {
    return AvatarState();
  }
}

class AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), border: Border.all(color: Color(0xFFFFAD4C), width: 2.0)),
    );
  }
}
