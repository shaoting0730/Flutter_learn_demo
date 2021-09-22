import 'package:flutter/cupertino.dart';
import 'package:aimoversea_admin_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import '../dashboard.dart';
import '../personal_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  PackageInfo packageInfo;

  final List<Widget> _children = [
    Dashboard(),
    PersonalInfo(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () async {
      packageInfo = await PackageInfo.fromPlatform();
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateVersion());
    });
  }

  /*
* 检测版本
* */
  _updateVersion() async {
    var url = 'http://www.connect2aim.com/download/upgrade.json';
    var response = await http.get(url);
    var jsonResponse = response.body;
    var json = jsonDecode(jsonResponse);

    print(json);
    var android_version = json['android']['version'];
    var android_url = json['android']['url'];
    var ios_version = json['ios']['version'];
    var ios_url = json['ios']['url'];

    var local_version = '${packageInfo?.version}.${packageInfo?.buildNumber}';

    if (Platform.isAndroid) {
      if (local_version != android_version) {
        // 可以更新
        showDialog(
            context: context,
            builder: (builderContext) {
              return AlertDialog(
                    title: Text('是否安装新版本？'),
                    actions: [
                      FlatButton(
                        onPressed: () =>
                            Navigator.of(builderContext).pop(false),
                        child: Text('返回'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (await canLaunch(android_url)) {
                            await launch(android_url);
                          } else {
                            throw 'Could not launch $android_url';
                          }
                          Navigator.of(builderContext).pop(true);
                        },
                        child: Text('下载新版本'),
                      ),
                    ],
                  ) ??
                  false;
            });
      }
    } else {
      if (local_version != ios_version) {
        // 可以更新
        showDialog(
            context: context,
            builder: (builderContext) {
              return AlertDialog(
                    title: Text('是否安装新版本？'),
                    actions: [
                      FlatButton(
                        onPressed: () =>
                            Navigator.of(builderContext).pop(false),
                        child: Text('返回'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (await canLaunch(ios_url)) {
                            await launch(ios_url);
                          } else {
                            throw 'Could not launch $ios_url';
                          }
                          Navigator.of(builderContext).pop(true);
                        },
                        child: Text('下载新版本'),
                      ),
                    ],
                  ) ??
                  false;
            });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return (WillPopScope(
        onWillPop: Utils.genOnWillPop(context),
        child: Scaffold(
          body: IndexedStack(index: _currentIndex, children: _children),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('工作台'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('个人中心'),
              ),
            ],
          ),
        )));
  }
}
