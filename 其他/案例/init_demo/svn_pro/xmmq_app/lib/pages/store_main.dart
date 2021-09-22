import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:xmmq_app/serviceapi/baseapi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo/photo.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';

import '../models/api/goods.dart';
import '../routers/application.dart';
import 'goods_manage/pictures_wall.dart';
import 'store_dynamic/seller_activities.dart';
import '../serviceapi/customerapi.dart';
import '../widgets/bottom_bar.dart';
import '../bloc/isPicWall_bloc.dart';
import '../models/editable_activity_item.dart';
import 'store_dynamic/publish_activity.dart';
import '../utils/event_bus.dart';

import 'message_center/message_center.dart';
import 'goods_manage/goods_manage.dart';
import 'personal_center/me.dart';
import 'store_dynamic/seller_activities.dart';

class StoreMainPage extends StatefulWidget {
  @override
  StoreMainPageState createState() {
    return StoreMainPageState();
  }
}

class StoreMainPageState extends State<StoreMainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final JPush jpush = JPush();
  var items = List<EditableActivityItem>();

  TabController controller;
  int _tabIndex = 0; // 当前页面

  var _tabImages;
  var _appBarTitles = ['店主动态', '商品管理', '消息中心', '个人中心'];
  var _pageList;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void _initData() {
    /*
     * 初始化选中和未选中的icon
     */
    _tabImages = [
      [
        _getTabImage('assets/icon_home_main_gray.png'),
        _getTabImage('assets/icon_home_main_yellow.png')
      ],
      [
        _getTabImage('assets/icon_goods_main_gray.png'),
        _getTabImage('assets/icon_goods_main_yellow.png')
      ],
      [
        _getTabImage('assets/icon_news_main_gray.png'),
        _getTabImage('assets/icon_news_main_yellow.png')
      ],
      [
        _getTabImage('assets/icon_my_main_gray.png'),
        _getTabImage('assets/icon_my_main_yellow.png')
      ]
    ];
    /*
    * Tab
    * */
    _pageList = [
      ActivitiesPage(),
      GoodsManage(),
      MessageCenter(),
      MePage(),
    ];
  }

  /*
   * 根据image路径获取图片
   */
  Image _getTabImage(path) {
    return new Image.asset(path, width: 36.0, height: 36.0);
  }

  @override
  void initState() {
    initPushNotification();
    super.initState();

    _setupWechat();
  }

  Future _setupWechat() async {
    await fluwx.registerWxApi(
        appId: "wx8a57d592b64e5de4",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://www.xiaomaimaiquan.com/");
    var result = await fluwx.isWeChatInstalled();

    print('isWeChatInstalled: $result');
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPushNotification() async {
    jpush.setup(
      appKey: "ceceb8b4901258c487d48224",
      channel: "XMMQ",
      production: true,
      debug: false,
    );

    jpush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true));

    jpush.getRegistrationID().then((rid) {
      print("JPush RegistrationID: $rid");
      if (CustomerApi().getToken() != "" && rid != "") {
        CustomerApi().UpdateRegistrationId(context, rid);
      }
    });

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");

          if (message["extras"] != null) {
            Map notification;
            if (message["extras"]["cn.jpush.android.EXTRA"] != null) {
              notification =
                  jsonDecode(message["extras"]["cn.jpush.android.EXTRA"]);
            } else if (message["extras"] is Map) {
              notification = message["extras"];
            }
          }
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image _getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text _getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(
        _appBarTitles[curIndex],
        style: new TextStyle(
          fontSize: 14.0,
          color: const Color.fromRGBO(253, 172, 89, 1),
        ),
      );
    } else {
      return new Text(
        _appBarTitles[curIndex],
        style: new TextStyle(
          fontSize: 16.0,
          color: const Color.fromRGBO(102, 102, 102, 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _initData();
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _getTabIcon(0),
            title: _getTabTitle(0),
          ),
          BottomNavigationBarItem(
            icon: _getTabIcon(1),
            title: _getTabTitle(1),
          ),
          BottomNavigationBarItem(
            icon: _getTabIcon(2),
            title: _getTabTitle(2),
          ),
          BottomNavigationBarItem(
            icon: _getTabIcon(3),
            title: _getTabTitle(3),
          ),
        ],
      ),
    );
  }
}
