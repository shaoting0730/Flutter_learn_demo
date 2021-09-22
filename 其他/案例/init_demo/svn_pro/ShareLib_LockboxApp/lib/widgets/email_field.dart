import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_field.dart';

class EmailField extends InputField {
  
  EmailField({Key key}):super(key: key);

  @override
  State<EmailField> createState() {
    return EmailFieldState();
  }

}

class EmailFieldState extends InputFieldState<EmailField> {

  String _email = "";
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    _editingController.text = email;
  }

  TextEditingController _editingController  = TextEditingController();

  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();
    return Container(
      alignment: Alignment(0, 0),
      child: TextField(
        controller: _editingController,
        onChanged: (str) {
          _email = str;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          border: InputBorder.none
        ),
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        }
      ),
    );
  }

}