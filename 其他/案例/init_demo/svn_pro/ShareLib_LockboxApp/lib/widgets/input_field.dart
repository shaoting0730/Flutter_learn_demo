import 'package:flutter/material.dart';


abstract class InputField extends StatefulWidget {
  
  final double height;
  InputField({Key key, this.height}):super(key:key);

  double getHeight() {
    return height;
  }
}

abstract class InputFieldState<T extends InputField> extends State<T> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Color(0xFF727E98)),
      ),
      height: widget.getHeight(),
      child: buildFieldContent(context),
    );
  }

  Widget buildFieldContent(BuildContext context) ;

}