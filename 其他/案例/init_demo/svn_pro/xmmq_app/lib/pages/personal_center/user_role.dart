/*
* 用户角色
* */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/api/customer.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../../bloc/isPicWall_bloc.dart';
import '../../routers/application.dart';

class UserRolePage extends StatefulWidget {
  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  List<StoreInfoModel> _listModel = []; // 所有商店数据源
  List<StoreInfoModel> _myModelList = []; // 我的商店数据源
  List<StoreInfoModel> _otherModelList = []; // 其他商店数据源

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStoreInfo();
  }

  /*
  * 获取角色信息
  * */
  _getStoreInfo() async {
    await CustomerApi().GetAllMyAccessStores(context, {}).then((data) {
      setState(() {
        _listModel = data;
      });
      if (data.length != 0) {
        _listModel.forEach((e) {
          if (e.IsOwner == true) {
            setState(() {
              _myModelList.add(e);
            });
          } else {
            setState(() {
              _otherModelList.add(e);
            });
          }
        });
      }
    });
//    print('返回数据${json.encode(_listModel)}');
  }

  _loadUserBind(StoreInfoModel model) async {
    String guid = model.StoreGuid;
    await CustomerApi().LoadUserBind(context, guid);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => StoreMainPage()),
        (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
//    print(_listModel.length);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          '我的小买卖',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        '我自己的小买卖',
                        style: TextStyle(color: Color(0xFF999999)),
                      ),
                    ),
                    _myStoreWidget(_myModelList),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /*
  *  我自己的小买卖
  * */
  Widget _myStoreWidget(List<StoreInfoModel> list) {
//    print('我自己的');
//    print(json.encode(list));
    if (list.length != 0) {
      List<Widget> listWidget = list.map((e) {
        return InkWell(
          onTap: () async {
//            await Provider.of<IsOneBloc>(context).changeIsMe(true);
            _loadUserBind(e);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    e.StoreLogoUrl,
                    width: 66.0,
                    height: 66.0,
                  ),
                ),
                Text(e.StoreName),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(children: listWidget);
    } else {
      return Center(
        child: Text('无数据'),
      );
    }
  }

  /*
  * 我看过的小买卖
  * */
  Widget _otherStoreWidget(List<StoreInfoModel> list) {
    print('我看过的');
    print(json.encode(list));
    if (list.length != 0) {
      List<Widget> listWidget = list.map((e) {
        return InkWell(
          onTap: () async {
//            await Provider.of<IsOneBloc>(context).changeIsMe(false);
            _loadUserBind(e);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    e.StoreLogoUrl,
                    width: 66.0,
                    height: 66.0,
                  ),
                ),
                Text(e.StoreName),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(children: listWidget);
    } else {
      return Text('无数据');
    }
  }
}
