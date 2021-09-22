/*
* 首页
* */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'seller_activities.dart';
import '../goods_manage/pictures_wall.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/customer.dart';
import '../../bloc/isPicWall_bloc.dart';
import '../../utils/event_bus.dart';

class HomePage extends StatefulWidget {
  Function changeTab;
  HomePage({
    Key key,
    @required this.changeTab(int tab),
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  LoginResponseModel _model;
  StoreInfoModel _storeInfoModel;
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this)
      ..addListener(() async {
        FocusScope.of(context).requestFocus(FocusNode());

        switch (controller.index) {
          case 0:
            eventBus.fire(new IsPicWall(true)); // 先发
            eventBus.fire(new GoPicWall(true)); // 先发

            widget.changeTab(0);
            break;
          case 1:
            eventBus.fire(new IsPicWall(true)); // 先发

            widget.changeTab(1);
        }
      });

    _getUserInfo();
  }

  @override
  bool get wantKeepAlive => true;

  _getUserInfo() async {
    // 获取头像信息
    await CustomerApi().RetrieveStoreInfo(context, false).then((data) {
      var StoreGuid = data.StoreGuid;
      setState(() {
        _storeInfoModel = data;
      });
      CustomerApi().LoadUserBind(context, StoreGuid).then((data) {
//        print(jsonEncode(data));
        setState(() {
          _model = data;
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            _model != null
                ? Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          _model.WechatThumber + '?imageView2/0/w/250/h/250',
                        ),
                      ),
                    ),
                  )
                : Text(''),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                _storeInfoModel?.StoreName ?? "--",
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
            ),
          ],
        ),
        bottom: getTabBar(),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ActivitiesPage(refreshAction: () {
            _getUserInfo();
          }),
          PictureWallPage(),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Color.fromRGBO(255, 175, 76, 1),
      labelStyle: TextStyle(fontSize: 18),
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: TextStyle(fontSize: 16),
      indicatorColor: Color.fromRGBO(255, 175, 76, 1),
      tabs: <Tab>[
        Tab(
          text: '店主动态',
        ),
        Tab(
          text: '购物墙',
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }
}
