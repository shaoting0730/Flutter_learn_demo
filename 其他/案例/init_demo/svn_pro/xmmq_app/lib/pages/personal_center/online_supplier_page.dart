/*
* 线上供应商
* */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routers/application.dart';
import '../../utils/customDialog/input_dialog.dart';
import '../../models/api/vendors.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../../serviceapi/baseapi.dart';

class OnlineSupplierPage extends StatefulWidget {
  final String guid;
  OnlineSupplierPage({
    Key key,
    @required this.guid,
  }) : super(key: key);

  @override
  _OnlineSupplierPageState createState() => _OnlineSupplierPageState();
}

class _OnlineSupplierPageState extends State<OnlineSupplierPage> {
  List<Data> _modelLst = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomerApi().LoadAllVendors(context).then((val) {
      setState(() {
        _modelLst = val.data;
      });
//      print(json.encode(val));
    }).catchError((error) {
      print(error);
    });
  }

  /*
  * 商品List<Widget>
   e.vendorLogoUrl
  * */
  Widget _listWidget() {
    if (_modelLst.length != null) {
      List<Widget> _listW = _modelLst.map((e) {
        return InkWell(
          onTap: () async {
            var VendorGuid = e.guid;
            Application.router.navigateTo(
                context,
                "./supplier_product_pageHandle?VendorCategoryGuid=" +
                    widget.guid +
                    '&VendorGuid=' +
                    VendorGuid,
                transition: TransitionType.inFromRight);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      '${e.vendorLogoUrl}',
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                ),
                Text('${e.vendorName}')
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(children: _listW);
    } else {
      Text('无数据');
    }
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
          '线上供应商',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => StoreMainPage()),
                  (route) => route == null);
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              color: Color.fromRGBO(255, 175, 76, 1),
              child: Center(
                child: Text(
                  '返回首页',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Text(
            '线上供应商,发货更省心',
            style: TextStyle(color: Color(0xFF999999)),
          ),
          Expanded(
            child: _listWidget(),
          ),
        ],
      ),
    );
  }
}
