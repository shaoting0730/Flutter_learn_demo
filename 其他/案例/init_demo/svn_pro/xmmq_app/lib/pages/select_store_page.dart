/*
* 选择一个店面
* */
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import '../routers/application.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import '../models/api/customer.dart';
import '../serviceapi/customerapi.dart';
import '../pages/login.dart';
import '../widgets/base_page.dart';

class SelectStorePage extends StatefulWidget {
  List<StoreInfoModel> modelList;
  SelectStorePage({Key key, @required this.modelList}) : super(key: key);

  @override
  _SelectStorePageState createState() => _SelectStorePageState();
}

class _SelectStorePageState extends State<SelectStorePage> {
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  List<StoreInfoModel> _modelList = [];
  bool _isWeChatInstalledTag = false; // 是否安装了微信

  @override
  void initState() {
    super.initState();
    _setupWechat();
    setState(() {
      _modelList = widget.modelList;
    });
  }

  _setupWechat() async {
    await fluwx.registerWxApi(
        appId: "wx8a57d592b64e5de4",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://www.xiaomaimaiquan.com/");
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });
  }

  /*
  *  我自己的小买卖
  * */
  Widget _myStoreWidget(List<StoreInfoModel> list) {
    List<Widget> listWidget = list.map((e) {
      return InkWell(
        onTap: () async {
          await CustomerApi().LoadUserBind(context, e.StoreGuid);
          CustomerApi().verifyLoginState(context);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => route == null);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '请选择一个店面',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: EasyRefresh(
              refreshHeader: ClassicsHeader(
                key: _headerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                refreshReadyText: '下拉刷新',
                refreshedText: '下拉刷新完毕',
                refreshText: '下拉刷新',
                refreshingText: '下拉刷新',
              ),
              onRefresh: () async {
                List<StoreInfoModel> storesList =
                    await CustomerApi().GetMyAccessStores(context, {});
                if (storesList.length > 0) {
                  setState(() {
                    _modelList = storesList;
                  });
                }
              },
              child: ListView(
                children: <Widget>[
                  _myStoreWidget(_modelList),
                ],
              ),
            ),
          ),
          _isWeChatInstalledTag == true
              ? _modelList.length == 0
                  ? InkWell(
                      onTap: () {
                        fluwx.launchWeChatMiniProgram(
                            username: 'gh_fa3f54a90163',
                            path: 'pages/gzh/index');
                      },
                      child: Container(
                        color: Colors.amber,
                        height: 50,
                        child: Center(
                          child: Text(
                            '关注公众号免费开店',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  : Text('')
              : Text(''),
        ],
      ),
    );
  }
}
