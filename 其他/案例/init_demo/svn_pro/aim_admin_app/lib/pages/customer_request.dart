import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class CustomerRequest extends StatefulWidget {
  CustomerRequest({Key key}) : super(key: key);

  @override
  _CustomerRequestState createState() => new _CustomerRequestState();
}

class _CustomerRequestState extends State<CustomerRequest> {
  String _phoneCodeRegion = "+86";
  String _phoneCodeNumber = "";
  String _wechat;
  String _email;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    var title = args['title'];
    var service = args['service'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '请留下您的有效联系方式',
              textAlign: TextAlign.left,
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  _buildPhoneNumberField(context),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("微信号："),
                      Flexible(
                        child: TextFormField(
                          initialValue: _wechat,
                          onSaved: (value) => _wechat = value,
                          decoration: InputDecoration(
                            hintText: "(必填项)",
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("　邮箱："),
                      Flexible(
                        child: TextFormField(
                          initialValue: _email,
                          onSaved: (value) => _email = value,
                          decoration: InputDecoration(
                            hintText: "(非必填项)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '稍后会有专属客服与您联系',
              style: AimTheme.text12Grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: MaterialButton(
              height: 40,
              color: Theme.of(context).primaryColor,
              child: Text(
                '提交${title}',
                style: AimTheme.text16White,
              ),
              onPressed: () {
                _sendWithdrawRequest(context, title, service);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    var list = List<Widget>();

    list.add(DropdownButton(
      value: _phoneCodeRegion,
      onChanged: (String newValue) {
        setState(() {
          _phoneCodeRegion = newValue;
        });
      },
      underline: Text(''),
      items: ['+86', '+44', '+1'].map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));

    list.add(
      Flexible(
        child: TextFormField(
          initialValue: _phoneCodeNumber,
          onSaved: (value) => _phoneCodeNumber = value,
          decoration: InputDecoration(
            hintText: "请输入手机号(必填项)",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
        ),
      ),
    );
    return Container(
      child: Row(children: list),
    );
  }

  void _sendWithdrawRequest(BuildContext context, String title, int service) {
    _formKey.currentState.save();
    if ((_phoneCodeNumber?.isEmpty ?? true) || (_wechat?.isEmpty ?? true)) {
      Utils.alert(context, title: title, content: "请填写电话号码和微信号");
      return;
    }

    Future.delayed(const Duration(milliseconds: 100), () async {
      var result = await UserServerApi().addServiceRequest(context, service, {
        "phoneNumber": _phoneCodeRegion + _phoneCodeNumber,
        "wechat": _wechat,
        "email": _email,
      });

      if (result == true) {
        Utils.alert(context, title: "成功", content: "稍后会有专属客服与您联系",
            onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    });
  }
}
