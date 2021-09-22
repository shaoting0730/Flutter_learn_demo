import 'package:flutter/material.dart';
import 'base_page.dart';
import '../pages/scan_new_lockbox_page.dart';
import '../models/iotdevice.dart';
import './my_lockers_own_page.dart';
import './my_lockers_access_page.dart';
import '../service/baseapi.dart';

class MyLockersPage extends BasePage {

  final bool canPop;
  final int pageIndex;

  @override
  
  MyLockersPage({this.pageIndex = 0, this.canPop = true});

  State<StatefulWidget> createState() {
    return MyLockersPageState();
  }

}

class MyLockersPageState extends BasePageState<MyLockersPage>  {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'my_lockbox':"My Lockbox",
      'my_own_lockbox':"My Own Lockbox",
      'my_access_lockbox':"My Access Lockbox"
    },
    'zh': {
      'my_lockbox':"我的锁盒",
      'my_own_lockbox':"我自己的锁盒",
      'my_access_lockbox':"我被授权的锁盒"
    },
  };

  TabController controller;
  Widget myOwnLockboxPage;
  Widget myAccessLockboxPage;

  var _myOwnLockboxPageKey = GlobalKey<MyOwnLockboxPageState>();
  var _myAccessLockboxPageKey = GlobalKey<MyAccessLockboxPageState>();

  int curPageIndex = 0;
  List<IOTDeviceInfoModel> myAccessLockbox = List<IOTDeviceInfoModel>();
  List<IOTDeviceInfoModel> myOwnLockbox = List<IOTDeviceInfoModel>();
  List<Tab> tabs = <Tab>[
    Tab(
      text: _localizedValues[getLocaleCode()]["my_own_lockbox"],
    ),
    Tab(
        text: _localizedValues[getLocaleCode()]["my_access_lockbox"]
    ),
  ];

  @override
  void initState() {
    super.initState();
    title = _localizedValues[getLocaleCode()]["my_lockbox"];
    controller = TabController(length: 2, initialIndex: widget.pageIndex, vsync: this)..addListener(() {
      setState(() {
        curPageIndex =controller.index;
      });
    });

    curPageIndex = widget.pageIndex;

    myOwnLockboxPage = MyOwnLockboxPage(key: _myOwnLockboxPageKey);
    myAccessLockboxPage = MyAccessLockboxPage(key: _myAccessLockboxPageKey,);

    displayScrollToTop();
  }

  @override
  Widget getLeftAction() {
    if(widget.canPop == false) {
      return Container();
    }
    return super.getLeftAction();
  }

  @override
  Widget pageContent(BuildContext context) {
    switch (curPageIndex) {
      case 0:
        return myOwnLockboxPage;
      case 1:
        return myAccessLockboxPage;
      default:
        return null;
    }
  }

  @override
  Widget getTabBars() {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.black,
      tabs: tabs,
      controller: controller,
    );
  }

  @override
  List<Widget> getRightActions() {
    return <Widget>[
      IconButton(
        icon: ImageIcon(
          AssetImage('assets/ic_add.png'),
          color: Colors.black
        ),
        color: Colors.black,
        onPressed: () {
          Navigator.push(scaffoldKey.currentContext, MaterialPageRoute(builder: (context) => ScanNewLockerPage()));
        },
      ),
      IconButton(
        icon: ImageIcon(AssetImage('assets/ic_mine_s.png')),
        color: Colors.black,
        onPressed: () {
          onTapFastPass(scaffoldKey.currentContext);
        },
      )
    ];
  }

  @override
  void onScrollToTopPressed() {
    if(_myAccessLockboxPageKey.currentState != null) {
      _myAccessLockboxPageKey.currentState.scrollToTop();
    }

    if(_myOwnLockboxPageKey.currentState != null) {
      _myOwnLockboxPageKey.currentState.scrollToTop();
    }
  }
}