/*
* 公众号
* */

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class OfficialAccountsPage extends StatefulWidget {
  @override
  _OfficialAccountsPageState createState() => _OfficialAccountsPageState();
}

class _OfficialAccountsPageState extends State<OfficialAccountsPage> {
  PackageInfo packageInfo;

  List _txtList = [
    {
      'F': '小买卖圈',
      'B': '支持:',
    },
    {
      'F': '•',
      'B': '一键转发分享给顾客自助下单',
    },
    {
      'F': '•',
      'B': '支持便捷发布、更新多个商品信息',
    },
    {
      'F': '•',
      'B': '自动统计订购记录',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () async {
      packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        packageInfo = packageInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        title: Text(
          '关注公众号',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _topWidget(),
          _middleWidget(),
          _txtWidgeet(),
          _middleWidget(),
          _bottomWidget()
        ],
      ),
    );
  }

  /*
  * 分割视图
  * */
  Widget _middleWidget() {
    return Container(
      height: 10,
      color: Color.fromRGBO(239, 239, 239, 1),
    );
  }

  /*
  * 文字信息
  * */
  Widget _txtWidgeet() {
    List<Widget> _listWidget = _txtList.map((e) {
      return Container(
        margin: EdgeInsets.only(top: 5.0),
        child: RichText(
          text: TextSpan(
            text: '${e['F']}',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(255, 173, 78, 1),
            ),
            children: [
              TextSpan(
                text: ' ${e['B']}',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listWidget,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  '         商家申请开通“小买卖圈”后，可以发布多款商品信息，包括商品名、价格、描述、图片等。发布成功后，这张订购单可以直接以小程序卡片或生成海报的形式发送给顾客。顾客通过点击商家分享的小程序卡片或者扫描海报二维码，就可以进入商品页面选购商品、填写收货地址并将包含订单信息的小程序转发给商家，与商家完成一对一转账付款。'),
            ),
          ],
        ));
  }

  /*
  * 顶部视图
  * */
  Widget _topWidget() {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/bg_wechat_top.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 33,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/icon_wechat_logo.png',
                  width: 56,
                  height: 56,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    '小买卖圈',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 微信视图
  * */
  Widget _bottomWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_wechat_contact.png'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('微信公众号'),
                    ),
                    Text(
                      'xiaomaimaiquan',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 175, 76, 1),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: 'xiaomaimaiquan'));
                  Fluttertoast.showToast(
                      backgroundColor: Color(0xFF666666),
                      msg: " xiaomaimaiquan 已经复制~",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_my_code_copy.png'),
                      Text(
                        '  复制',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 175, 76, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/icon_wechat_qrcode.png',
              width: 145,
            ),
          ),
          Center(
            child: Text('微信扫一扫'),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: '当前版本：',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(255, 173, 78, 1),
                ),
                children: [
                  TextSpan(
                    text:
                        '${packageInfo?.version}（${packageInfo?.buildNumber}）',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
