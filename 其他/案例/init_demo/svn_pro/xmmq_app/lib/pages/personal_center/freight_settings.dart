/*
* 运费设置
* */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluro/fluro.dart';
import '../../serviceapi/customerapi.dart';
import '../../routers/application.dart';
import '../../utils/utils.dart';

class FreightSettingsPage extends StatefulWidget {
  final String currentMoney;
  FreightSettingsPage({Key key, @required this.currentMoney}) : super(key: key);

  @override
  State<FreightSettingsPage> createState() {
    return FreightSettingsPageState();
  }
}

class FreightSettingsPageState extends State<FreightSettingsPage> {
  final _controller = TextEditingController(); // 输入框控制器

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
          '运费设置',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 28, 15, 0),
          child: Container(
            child: ListView(children: <Widget>[
              _buildCurrentPriceArea(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Text("修改价格",
                      style:
                          TextStyle(fontSize: 14, color: Color(0xFF666666)))),
              _buildEditPriceArea(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("*当前为基础运费，设置后将会自动加入订单",
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF999999)))),
              _buildSaveButton()
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPriceArea() {
    double d = double.parse(widget.currentMoney);

    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFFFF0DD),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      height: 65,
      alignment: Alignment(0, 0),
      child: Text(
        "当前运费：${Utils.stringFormat(d.toString())}元",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFFEF751D),
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildEditPriceArea() {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        height: 65,
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text("¥",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600))),
            Expanded(
                child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true), //设置键盘为可录入小数的数字
                    controller: _controller,
                    decoration: InputDecoration(
                      fillColor: Colors.blue.shade100,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    )))
          ],
        ));
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 74, 0, 0),
      width: double.infinity,
      child: MaterialButton(
        height: 44,
        child: Text(
          "保存设置",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        color: Color(0xFFFFAF4C),
        onPressed: () {
          var money = _controller.text;
          CustomerApi().SetBasicShippingFee(context, money).then((val) {
            if (val['Success'] == true) {
              Navigator.pop(context, money);
            } else {
              Fluttertoast.showToast(
                  backgroundColor: Color(0xFF666666),
                  msg: "修改失败,请稍后再试",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER);
            }
          }).catchError((e) {
            print(e);
          });
        },
      ),
    );
  }
}
