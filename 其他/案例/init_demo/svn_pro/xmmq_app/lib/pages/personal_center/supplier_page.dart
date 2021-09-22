/*
* 供货商家
* */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../routers/application.dart';
import '../../serviceapi/customerapi.dart';
import '../../serviceapi/baseapi.dart';
import '../../models/api/vendors.dart';
import 'supplier_product_page.dart';
import '../../utils/customDialog/input_dialog.dart';
import '../../widgets/loading_widget.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage>
    with AutomaticKeepAliveClientMixin {
  Map _model;
  String _guid;
  bool _showLoadingTag = true; //  加载中状态

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('供货商家');

    CustomerApi().LoadAllVendors(context).then((val) {
      setState(() {
        _model = val;
      });
      setState(() {
        _showLoadingTag = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _showLoadingTag = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  /*
  * 绑定线上供应商
  * */
  _bindSupplierAction(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(CURRENT_STORE_TOKEN_KEY);
    var json = jsonDecode(token);
    var MainGuid = json['StoreGuid'];
//    print('MainGuid--- $MainGuid');
//    print('text--- $text');
    CustomerApi().BindInternalVendor(context, text, MainGuid).then((data) {
//      print(data);
      if (data['Success'] == false) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "绑定失败: ${data['ErrorDesc']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
      if (data['Success'] == true) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "绑定成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      }
    }).catchError((error) {
      print(error);
    });
  }

  /*
  * 商品List<Widget>
  e.CategoryLogoUrl
  * */
  Widget _listWidget() {
    if (_model != null && _model['Data'].length > 0) {
      return InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return SupplierProductPage(
                  VendorCategoryGuid: '',
                  VendorGuid: _model['Data'].last['Guid'],
                  map: _model,
                );
              },
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(255, 175, 76, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    '${_model['Data'].last['VendorLogoUrl']}',
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
              ),
              Text('${_model['Data'].last['VendorName']}')
            ],
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 22,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
              _model != null && _model['Data'].length > 0
                  ? Container(
                      margin: EdgeInsets.only(left: 10, top: 20, bottom: 15),
                      child: Text(
                        '您已绑定线上供应商，发货更省心',
                        style: TextStyle(color: Color(0xFF999999)),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/noData.png',
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            ' 无供货商数据',
                            style: TextStyle(
                                color: Color(0xFF999999), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
              _listWidget(),
              Spacer(),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return InputDialog(
                        okCallback: (e) async {
                          _bindSupplierAction(e);
                        },
                        dismissCallback: () {
                          print("取消了");
                        },
                      );
                    },
                  );
                },
                child: Container(
                  color: Color.fromRGBO(255, 175, 76, 1),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      '绑定新的供货商',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _showLoadingTag == true
            ? Positioned(
                child: LoadingWidget(title: ' 加载中...'),
              )
            : Text('')
      ],
    );
  }
}
