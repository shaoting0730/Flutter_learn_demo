import 'package:flutter/material.dart';

import 'input_field.dart';

class PasswordFeild extends InputField {
  
  PasswordFeild({Key key}):super(key: key);

  @override
  State<PasswordFeild> createState() {
    return PasswordFieldState();
  }

}

class PasswordFieldState extends InputFieldState<PasswordFeild> {

  String _password = "";

  String get password => _password;

  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();
    return Container(
      alignment: Alignment(0, 0),
      child: TextField(
        onChanged: (str) {
          _password = str;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          border: InputBorder.none
        ),
        obscureText: true,
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        }
      ),
    );
  }

}