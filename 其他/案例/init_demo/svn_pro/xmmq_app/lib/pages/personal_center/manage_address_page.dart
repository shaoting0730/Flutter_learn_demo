/*
* 管理收货地址
* */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../models/api/customer.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/address.dart';

class ManageAddressPage extends StatefulWidget {
  final String modelStr;
  ManageAddressPage({Key key, @required this.modelStr}) : super(key: key);
  @override
  _ManageAddressPageState createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  LoginResponseModel _loginmodel;
  AddressModel _addressModel;
  List<ListObjects> _listObjects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginResponseModel model =
        LoginResponseModel.fromJson(json.decode(widget.modelStr));

    setState(() {
      _loginmodel = model;
    });

    CustomerApi()
        .SearchStoreCustomerAddress(context, 0, 100, model.StoreCustomerGuid)
        .then((val) {
      setState(() {
        _addressModel = val;
        _listObjects = val.data.listObjects;
      });
    }).catchError((error) {
      print(error);
    });
  }

  /*
  * 删除点击方法
  * */
  _deleteAction(int index) async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text('确定删除该条地址?'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  await CustomerApi()
                      .DeleteStoreCustomerAddress(
                          context,
                          _listObjects[index].guid,
                          _listObjects[index].storeCustomerGuid)
                      .then((e) {})
                      .catchError((error) {
                    print(error);
                  });
                  await CustomerApi()
                      .SearchStoreCustomerAddress(
                          context, 0, 100, _loginmodel.StoreCustomerGuid)
                      .then((val) {
                    setState(() {
                      _addressModel = val;
                      _listObjects = val.data.listObjects;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('管理收货地址'),
      ),
      body: Column(
        children: <Widget>[
          _listObjects.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _listObjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _addressWidget(index);
                    },
                  ),
                )
              : Text('暂无数据'),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Color.fromRGBO(255, 175, 76, 1),
            child: Center(
              child: Text(
                '新 增 地 址',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 收货地址UI
  * */
  Widget _addressWidget(int index) {
    print(json.encode(_listObjects[index]));
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Image.asset('assets/bg_order_location_top.png'),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black26),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _nameWidget(index),
                    Text('${_listObjects[index].phoneNumber}'),
                  ],
                ),
                Text(
                    '${_listObjects[index].province} ${_listObjects[index].city} ${_listObjects[index].town} ${_listObjects[index].addressLine}'),
              ],
            ),
          ),
          _addressBtn(index),
        ],
      ),
    );
  }

  /*
  * 名字 + 默认
  * */
  Widget _nameWidget(int index) {
    return Row(
      children: <Widget>[
        Text('${_listObjects[index].fullName}'),
        _listObjects[index].addressType == 2
            ? Container(
                margin: EdgeInsets.only(left: 5.0),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 175, 76, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                width: 40,
                child: Center(
                  child: Text(
                    '默认',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            : Text(''),
      ],
    );
  }

  Widget _addressBtn(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('assets/icon_detail_add_yellow.png'),
              Text(' 默认地址'),
            ],
          ),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('使用地址 '),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_address_edit.png'),
                    Text('编辑    '),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _deleteAction(index);
                },
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_address_delete.png'),
                    Text('删除'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
