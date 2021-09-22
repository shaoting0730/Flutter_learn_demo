/*
* 免费开店
* */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import '../serviceapi/customerapi.dart';

class FreeSetupShopPage extends StatefulWidget {
  @override
  _FreeSetupShopPageState createState() => _FreeSetupShopPageState();
}

class _FreeSetupShopPageState extends State<FreeSetupShopPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _shopController = TextEditingController();

  /*
  * 提交申请
  * */
  _commitAction() {
    String name = _nameController.text;
    String email = _emailController.text;
    String tel = _telController.text;
    String shop = _shopController.text;
    if (name.length == 0 ||
        email.length == 0 ||
        tel.length == 0 ||
        shop.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "以上输入框都必须有值",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }

    Map map = {};
    map['ApplicationAvatar'] = '';
    map['Description'] = '';
    map['WechatName'] = '';
    map['WechatQRCode'] = '';

    map['FullName'] = _nameController.text;
    map['Email'] = _emailController.text;
    map['PhoneNumber'] = _telController.text;
    map['ApplicationName'] = _shopController.text;
    CustomerApi().AddNewStoreApplication(context, map).then((e) {
      print(e);
      if (e['Success'] == true) {
        var dialog = CupertinoAlertDialog(
          content: Text(
            "您的申请已经成功提交,正在审理中,如果审核通过,您将受到邮件通知.",
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );

        showDialog(context: context, builder: (_) => dialog);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "申请失败,请稍后再试~",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '免费开店',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
//                姓名输入框
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: ' 姓名',
                    prefixIcon: Container(
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Text(' 姓名'),
                    ),
                  ),
                ),
                //                姓名输入框
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: ' 联系邮箱',
                    prefixIcon: Container(
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Text(' 联系邮箱'),
                    ),
                  ),
                ),
                //                姓名输入框
                TextField(
                  controller: _telController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: ' 联系电话',
                    prefixIcon: Container(
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Text(' 联系电话'),
                    ),
                  ),
                ),
                //                姓名输入框
                TextField(
                  controller: _shopController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '店铺名称:',
                    prefixIcon: Container(
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Text(' 店铺名称'),
                    ),
                  ),
                ),
              ],
            ),
          ),
//          提交申请
          InkWell(
            onTap: _commitAction,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Color.fromRGBO(255, 175, 76, 1),
              child: Center(
                child: Text(
                  '提交申请',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
