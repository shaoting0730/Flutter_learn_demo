import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_model.dart';
import '../models/loginmodel.dart';
import '../services/baseapi.dart';
import '../services/serviceapi.dart';
import '../utils.dart';
import '../pages/settings.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => new _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo>
    with AutomaticKeepAliveClientMixin {
  CustomerModel data;
  bool dataLoaded = false;
  bool _usability = false;
  PackageInfo packageInfo;
  String _portraitStr = '';

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () async {
      packageInfo = await PackageInfo.fromPlatform();

      //  获取头像  api/customer/QueryStoreCustomerHead
      UserServerApi().queryStoreCustomerHead(context).then((e) {
        if (e['Data'] != null) {
          setState(() {
            _portraitStr = e['Data'];
          });
        }
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var jsonString = prefs.getString(TOKEN_KEY);
      print(jsonString);

      setState(() {});
    });

    _refresh();
  }

  _refresh() async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      data = await UserServerApi().getCustomerInfo(context);
      dataLoaded = true;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0), // here the desired height
        child: AppBar(
          title: Text(''),
          centerTitle: true,
          flexibleSpace: _buildMyHeader(context),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, size: 28),
              onPressed: _onSettings,
            ),
          ],
        ),
      ),
      body: data == null
          ? (dataLoaded
              ? OutlineButton(
                  child: Text('无法加载数据，退出重新登录'),
                  onPressed: () async {
                    await BaseApi.clearLoginResponse();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      ModalRoute.withName('/'),
                    );
                  },
                )
              : Center(
                  child: Text('加载中...'),
                ))
          : _buildListView(context),
    );
  }

  ListView _buildListView(BuildContext context) {
    return _usability == true
        ? ListView(
            children: Utils.noNull(
              [
                data.ReferredByStoreCustomerId > 0
                    ? null
                    : ListTile(
                        title: Text(
                          '填写邀请码',
                          style: AimTheme.text16,
                        ),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          Text('获取升级资格', style: AimTheme.text16Grey),
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                        ]),
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                              context, '/input',
                              arguments: InputDialogParams(
                                  title: '填写邀请码',
                                  field: '邀请码：',
                                  tip: '填写邀请码后可以升级资格')) as InputDialogReturn;
                          if (result == null) return;
                          if (await UserServerApi()
                              .setAffiliateCode(context, result.value)) {
                            _refresh();
                          }
                        },
                      ),
                ListTile(
                  leading: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.star, color: Colors.yellow[800]),
                    Text(
                      '  我的积分',
                      style: AimTheme.text16,
                    )
                  ]),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('积分明细', style: AimTheme.text16Grey),
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ]),
                  onTap: () {
                    Navigator.pushNamed(context, "/rewards");
                  },
                ),
                data.ReferredByStoreCustomerId == 0
                    ? null
                    : ListTile(
                        leading: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.people_outline, color: Colors.yellow[800]),
                          Text(
                            '  好友邀请码',
                            style: AimTheme.text16,
                          )
                        ]),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          data.ReferredByStoreCustomerId > 0
                              ? Text(data.CustomerUniqueCode)
                              : Text(
                                  '暂无',
                                  style: AimTheme.text16Grey,
                                ),
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                        ]),
                        onTap: () {
                          if (data.ReferredByStoreCustomerId > 0) {
                            Clipboard.setData(
                                ClipboardData(text: data.CustomerUniqueCode));
                            displayErrorMessage(context,
                                "邀请码 ${data.CustomerUniqueCode} 已复制到剪贴板");
                          }
                        },
                      ),
                ListTile(
                  leading: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.share, color: Colors.red),
                    Text(
                      '  分享APP',
                      style: AimTheme.text16,
                    )
                  ]),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/share_app', arguments: data);
                  },
                ),
                ListTile(
                  leading: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.search, color: Colors.red),
                    Text(
                      '检测版本',
                      style: AimTheme.text16,
                    )
                  ]),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  onTap: _updateVersion,
                )
              ],
            ),
          )
        : ListView(
            children: <Widget>[],
          );
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
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "已经是最新版",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
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
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "已经是最新版",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    }
  }

  _buildMyHeader(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, top: 60),
      leading: _portraitStr.length > 0
          ? ClipOval(
              child: Image.network(
                _portraitStr,
                fit: BoxFit.fill,
                width: 50.0,
                height: 50.0,
              ),
            )
          : CircleAvatar(backgroundImage: AssetImage("assets/person.jpg")),
      title: Text(data?.FirstName ?? '', style: AimTheme.text20White),
      onTap: _onSettings,
    );
  }

  void _onSettings() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Settings(
          portraitStr: _portraitStr,
        ),
      ),
    );
//    print(11111);
    if (result.length > 0) {
      setState(() {
        _portraitStr = result;
      });
    }
//    Navigator.pushNamed(context, "/settings", arguments: data);
  }
}
