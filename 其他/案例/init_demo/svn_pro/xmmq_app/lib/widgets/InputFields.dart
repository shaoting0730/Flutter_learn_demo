import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final String initialValue;
  final FormFieldSetter<String> onSaved;

  InputFieldArea(
      {Key key,
      this.hint,
      this.obscure,
      this.icon,
      this.onSaved,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black26,
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        initialValue: initialValue,
        onSaved: onSaved,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          icon: icon == null ? null : Icon(icon),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 15.0, right: 30.0, bottom: 15.0, left: 5.0),
        ),
      ),
    ));
  }
}
