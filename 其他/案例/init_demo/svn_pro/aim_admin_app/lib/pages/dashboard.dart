import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../models/app_model.dart';
import '../utils.dart';
import '../widgets/badge.dart';
import '../services/baseapi.dart';
import '../services/serviceapi.dart';
import '../models/loginmodel.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  var initialized = false;
  bool _usability = false;

  CustomerModel data;

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    _refresh();
  }

  _refresh() async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      data = await UserServerApi().getCustomerInfo(context);
      setState(() {});
    });

    // 获取版本号
    var url = 'http://www.connect2aim.com/download/upgrade.json';
    var response = await http.get(url);
    var jsonResponse = response.body;
    var json = jsonDecode(jsonResponse);

    if (json['usability'] == true) {
      setState(() {
        _usability = true;
      });
    } else {
      setState(() {
        _usability = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Consumer<AppModel>(
            builder: (context, appModel, child) {
              return Text('海创小目标管理平台');
            },
          ),
          centerTitle: true,
          actions: [
            Consumer<AppModel>(builder: (context, appModel, child) {
              return Badge(
                icon: Icon(Icons.message, size: 28),
                text: (appModel.notifyCount?.unread ?? 0) > 0
                    ? appModel.notifyCount.unread.toString()
                    : null,
                onPressed: () {
                  Navigator.pushNamed(context, "/notify");
                },
              );
            })
          ]),
      body: Container(
        child: Consumer<AppModel>(
          builder: (context, appModel, child) => EasyRefresh(
            header: ClassicalHeader(
              refreshText: "下拉刷新",
              refreshingText: "刷新中",
              refreshReadyText: "开始刷新",
              refreshedText: "结束刷新",
              infoText: "",
            ),
            child: ListView(
              children: Utils.noNull([
                appModel.isUser ? null : _buildRevenue(context),
                appModel.isUser
                    ? _buildServiceToolsUser(context)
                    : _buildServiceToolsVip(context, appModel),
                appModel.isBlackCard
                    ? null
                    : _buildUpgradeCenter(context, appModel),
                _usability == true
                    ? _buildUpgradeProgress(context, appModel.nextLevel)
                    : Text(''),
                _usability == false ? _buildMaterialWidget() : Text('')
              ]),
            ),
            onRefresh: () async {
              Future.delayed(const Duration(milliseconds: 100), () async {
                await BaseApi().loadLoginResponse(context);
              });
            },
          ),
        ),
      ),
    );
  }

  /*
  * 素材
  * */
  _buildMaterialWidget() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('销售素材'),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/goods_details");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('众明星的助眠好物'),
                Image.asset(
                  'assets/goods1.png',
                  width: 100,
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildRevenue(context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<AppModel>(
        builder: (context, appModel, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: _onViewRevenue,
              child: Column(
                children: [
                  Text("今日收益",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text(
                    "¥${appModel.revenueSummary?.Today ?? '-.--'}",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _onViewRevenue,
              child: Column(
                children: [
                  Text("本月收益",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text(
                    "¥${appModel.revenueSummary?.Month ?? '-.--'}",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _onViewRevenue,
              child: Column(
                children: [
                  Text("总收益",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text(
                    "¥${appModel.revenueSummary?.All ?? '-.--'}",
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildServiceToolsUser(context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("服务工具"),
        Container(
          color: const Color(0xFFd6d6d6),
          padding: const EdgeInsets.only(left: 5, right: 5),
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FlatButton.icon(
                  onPressed: _onFinanceManagement,
                  icon: const Icon(Icons.attach_money),
                  label: Text(
                    "财务管理",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton.icon(
                  onPressed: _onFinanceManagement,
                  icon: const Icon(Icons.help_outline),
                  label: Text(
                    "使用帮助",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  _onFinanceManagement() {
    Navigator.pushNamed(context, "/finance");
  }

  void _onViewRevenue() {}

  _buildServiceToolsVip(BuildContext context, AppModel appModel) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("服务工具"),
        Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            margin: const EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child: Wrap(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/orders");
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.view_headline),
                      Text(
                        "订单管理",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: _onFinanceManagement,
                  child: Column(
                    children: [
                      const Icon(Icons.attach_money),
                      Text(
                        "财务管理",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
                _usability == true
                    ? FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/share_app',
                              arguments: data);
                        },
                        child: Column(
                          children: [
                            const Icon(Icons.person_add),
                            Text(
                              "邀请经销商",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(''),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/topic",
                        arguments: {'name': 'rules'});
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.layers),
                      Text(
                        "规则中心",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
                (appModel.isBlackCard)
                    ? _usability == true
                        ? FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/customers");
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.people),
                                Text(
                                  "客户管理",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text('')
                    : Text(''),
                Text(''),
              ],
            )),
      ]),
    );
  }

  _buildUpgradeCenter(context, AppModel appModel) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _usability == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("升级中心"),
                  Spacer(),
                  FlatButton(
                    child: Row(children: [
                      Text("详情"),
                      Icon(Icons.chevron_right),
                    ]),
                    onPressed: () {
                      Navigator.pushNamed(context, "/upgrade_center");
                    },
                  ),
                ],
              )
            : Text(''),
        _usability == true
            ? Container(
                alignment: Alignment.center,
                child: Column(
                    children: Utils.noNull([
//            appModel.isUser
//                ? Padding(
//                    padding: EdgeInsets.only(top: 5),
//                    child: FlatButton(
//                      child: Image.network(
//                          "https://cdn.51taouk.com/aimoversea/banner/vip.png"),
//                      onPressed: () {
//                        Navigator.pushNamed(context, '/topic', arguments: {
//                          'name': 'upgradeVIP',
//                          'background': '0'
//                        });
//                      },
//                    ),
//                  )
//                : null,
                  (appModel.isUser || appModel.isVIP)
                      ? Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: FlatButton(
                            child: Image.network(
                                "https://cdn.51taouk.com/aimoversea/banner/svip.png"),
                            onPressed: () {
                              Navigator.pushNamed(context, '/topic',
                                  arguments: {
                                    'name': 'upgradeMore',
                                    'background': '0'
                                  });
                            },
                          ),
                        )
                      : null,
                  (appModel.isUser || appModel.isVIP || appModel.isSVIP)
                      ? Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: FlatButton(
                            child: Image.network(
                                "https://cdn.51taouk.com/aimoversea/banner/black_card.png"),
                            onPressed: () {
                              Navigator.pushNamed(context, '/topic',
                                  arguments: {
                                    'name': 'upgradeMore',
                                    'background': '0'
                                  });
                            },
                          ),
                        )
                      : null,
                ])),
              )
            : Text(''),
      ]),
    );
  }

  _buildUpgradeProgress(context, String nextLevel) {
    if (nextLevel == null) return null;
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(children: [
        LinearProgressIndicator(value: 0.3),
        Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text("您还需要努力才能升级到$nextLevel")),
      ]),
    );
  }
}
