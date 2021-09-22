import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class InputDialog extends StatefulWidget {
  InputDialog({Key key}) : super(key: key);

  @override
  _InputDialogState createState() => new _InputDialogState();
}

class InputDialogParams {
  final String title;
  final String field;
  final String tip;

  InputDialogParams({this.title, this.field, this.tip});
}

class InputDialogReturn {
  final String value;

  InputDialogReturn({this.value});
}

class _InputDialogState extends State<InputDialog> {
  String _value;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var params = ModalRoute.of(context).settings.arguments as InputDialogParams;

    return Scaffold(
      appBar: AppBar(
        title: Text(params.title),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(params.field),
                        Flexible(
                          child: TextFormField(
                            onSaved: (value) {
                              _value = value;
                            },
                            decoration: InputDecoration(
                              hintText: "(必填项)",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Text(
                      params.tip,
                      style: AimTheme.text12Grey,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('提交', style: AimTheme.text16White),
                    onPressed: () async {
                      _formKey.currentState.save();
                      if (_value == null || _value.isEmpty) {
                        Utils.alert(context, title: '校验', content: '请填写有效内容');
                        return;
                      }
                      Navigator.pop(context, InputDialogReturn(value: _value));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
