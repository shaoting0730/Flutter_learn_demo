/*
* 店主动态
* */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:xmmq_app/widgets/loading_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../models/api/customer.dart';
import '../../widgets/activity_cell.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/search_filter_pane.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/goodsGroup.dart';
import '../../utils/event_bus.dart';
import '../../utils/utils.dart';
import 'dynamic_publish.dart';

class ActivitiesPage extends StatefulWidget {
  ActivitiesPageState _state;
  Function refreshAction;

  ActivitiesPage({Key key, this.refreshAction}) : super(key: key);

  @override
  State<ActivitiesPage> createState() {
    _state = ActivitiesPageState();
    return _state;
  }

  void viewWillDisappear() {
    if (_state._overlayEntry != null) {
      _state._overlayEntry.remove();
      _state._overlayEntry = null;
    }
  }
}

class ActivitiesPageState extends State<ActivitiesPage>
    with
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin,
        WidgetsBindingObserver {
  Animation<double> _animation;
  AnimationController _controller;

  OverlayEntry _overlayEntry;
  StoreInfoModel _storeInfoModel;
  bool _isWeChatInstalledTag = false; // 是否安装了微信
  bool _isShareing = false; // 是否点击了分享按钮
  bool _showLoadingTag = true; //  加载中状态
  AppLifecycleState _notification;
  int _pageIndex = 0; //  默认加载第0页面的数据
  var _listControl = ScrollController();

  String _keywords = ''; // 关键字
  List _ProductName = []; // 名字
  List _TagList = []; // 名字
  String _imgUrl = '';

  List<ListObjectsModel> _dataSource = [];

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  void dispose() {
    super.dispose();
    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }
    WidgetsBinding.instance.removeObserver(this); // 移除监听器
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = new AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      _animation =
          new Tween(begin: 0.0, end: MediaQuery.of(context).size.height)
              .animate(_controller)
                ..addListener(() {
                  setState(() {});
                });
    });

    WidgetsBinding.instance.addObserver(this); // 注册监听器

    _getStoreGoods();
    _getWechatTag();

//    print(Utils.stringFormat('3.1'));
//    print(Utils.stringFormat('3.00'));
//    print(Utils.stringFormat('3.01'));
//    print(Utils.stringFormat('3.1'));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("$state");
    //  只能在改状态下修改state。不然分享偶尔会失败。why???
    Future.delayed(Duration(milliseconds: 100)).then((e) {
      if (state == AppLifecycleState.resumed) {
        //  通知所有地方停止loading
        eventBus.fire(new StopLoading(0)); // 先发

        setState(() {
          _isShareing = false;
        });
      }
    });
  }

  _getWechatTag() async {
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });
  }

  _getStoreGoods() async {
    // 获取店的信息
    await CustomerApi().RetrieveStoreInfo(context, false).then((data) {
      var StoreGuid = data.StoreGuid;
      CustomerApi().LoadUserBind(context, StoreGuid).then((data) {
        setState(() {
          _imgUrl = data.WechatThumber;
        });
      });
      setState(() {
        _storeInfoModel = data;
      });
    }).catchError((error) {
      print(error);
    });

    // 获取店主动态
    await CustomerApi().SearchDQProductGroup(context, {
      "PageIndex": _pageIndex,
      "PageSize": 20,
      "ProductName": _ProductName,
      "TagList": _TagList,
      "keywords": _keywords
    }).then((data) {
//      print('返回数据');
//      print(jsonEncode(data));
      setState(() {
        _showLoadingTag = false;
        _dataSource += data.ListObjects;
      });
    }).catchError((error) {
      setState(() {
        _showLoadingTag = false;
      });
      print(error);
    });
  }
//
//  //监听Bus events
//  void _listen() {
//    eventBus.on<RemoveLike>().listen((event) {
//      if (mounted) {
//        var id = event.id;
//        _dataSource.forEach((e) {
//          if (e.Guid == id) {
//            setState(() {
//              e.Likes--;
//              e.HasLiked = 0;
//            });
//          }
//        });
//      }
//    });
//
//    eventBus.on<AddNewLike>().listen((event) {
//      if (mounted) {
//        var id = event.id;
//        _dataSource.forEach((e) {
//          if (e.Guid == id) {
//            setState(() {
//              e.Likes++;
//              e.HasLiked = 1;
//            });
//          }
//        });
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    _listen();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        title: _imgUrl.length > 0
            ? Row(
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          _imgUrl + '?imageView2/0/w/250/h/250',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      _storeInfoModel.StoreName,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ],
              )
            : Text(''),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Center(
                child: Column(
                  // center the children
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SearchBar(
                      onFilterPressed: _onPressSearchFilter,
                      inputBack: (e) async {
                        setState(() {
                          _ProductName = [];
                          _TagList = [];
                          _keywords = e;
                          _pageIndex = 0;
                          _dataSource = [];
                          _showLoadingTag = true;
                        });
                        _getStoreGoods();
                      },
                    ),
                    _buildActivitiesArea()
                  ],
                ),
              ),
            ),
          ),
          // 下拉框
          Container(
            height: _animation == null ? 0 : _animation.value,
            width: MediaQuery.of(context).size.width,
            child: SearchFilterPane(
              isPicWall: false,
              onClearPressed: () async {
                eventBus.fire(new CancelSelect(true)); // 先发
                setState(() {
                  _ProductName = [];
                  _TagList = [];
                  _keywords = '';
                  _pageIndex = 0;
                  _dataSource = [];
                  _showLoadingTag = true;
                });
                // 获取店主动态
                _getStoreGoods();
                _controller.reverse();
              },
              onSearchPressed: (topic, tag, txt, isOther) async {
//              if (isOther == true) {
//                print('搜索其他');
//              }
                // 获取店主动态
                setState(() {
                  _ProductName = topic;
                  _TagList = tag;
                  _keywords = txt;
                  _pageIndex = 0;
                  _dataSource = [];
                  _showLoadingTag = true;
                });
                _getStoreGoods();
                _controller.reverse();
              },
            ),
          ),
          Positioned(
            child: _isShareing == true
                ? LoadingWidget(
                    title: '分享中...',
                  )
                : Text(''),
          ),
          // 回到顶部&发布按钮
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _listControl.jumpTo(0);
                  },
                  child: Image.asset(
                    'assets/icon_home_top.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return DynamicPublish();
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icon_home_upload_yellow.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
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
  * 店主动态-搜索栏往下
  * */
  Widget _buildActivitiesArea() {
    if (_showLoadingTag == true) {
      return LoadingWidget(
        title: '加载中...',
      );
    } else {
      if (_dataSource != null && _dataSource.length == 0) {
        return Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/noData.png',
                width: 100,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                ' 等候店主发新动态',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        );
      } else {
        return Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.asset('assets/bg_home_seller.png'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
//              color: Colors.red,
                child: EasyRefresh(
                  key: _easyRefreshKey,
                  refreshHeader: ClassicsHeader(
                    key: _headerKey,
                    bgColor: Colors.white,
                    textColor: Color.fromRGBO(102, 102, 102, 1),
                    moreInfoColor: Color.fromRGBO(102, 102, 102, 1),
                    showMore: true,
                    moreInfo: '下拉刷新...',
                  ),
                  refreshFooter: ClassicsFooter(
                    key: _footerKey,
                    bgColor: Colors.white,
                    textColor: Color.fromRGBO(102, 102, 102, 1),
                    moreInfoColor: Color.fromRGBO(102, 102, 102, 1),
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中...',
                    loadReadyText: '上拉加载',
                  ),
                  loadMore: () async {
//                    widget.refreshAction();
                    setState(() {
                      _pageIndex++;
                    });
                    _getStoreGoods();
                  },
                  onRefresh: () async {
//                    widget.refreshAction();
                    setState(() {
                      _showLoadingTag = true;
                      _dataSource = [];
                      _pageIndex = 0;
                    });
                    _getStoreGoods();
                  },
                  child: ListView.builder(
                    controller: _listControl,
                    itemCount: _dataSource != null ? _dataSource.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPostDetailArea(_dataSource[index], index);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  /*
  * 店主动态-主体
  * */
  Widget _buildPostDetailArea(ListObjectsModel model, int index) {
    return ActivityCell(
      storeInfoModel: _storeInfoModel,
      list: _dataSource,
      index: index,
      model: model,
      topCallback: () async {
        // 获取店的信息
        await CustomerApi().RetrieveStoreInfo(context, false).then((data) {
          setState(() {
            _storeInfoModel = data;
          });
        }).catchError((error) {
          print(error);
        });

        // 获取店主动态
        await CustomerApi().SearchDQProductGroup(context, {
          "PageIndex": _pageIndex,
          "PageSize": 20,
          "ProductName": _ProductName,
          "TagList": _TagList,
          "keywords": _keywords
        }).then((data) {
          setState(() {
            _dataSource = [];
          });
          Future.delayed(Duration(milliseconds: 200)).then((e) {
            setState(() {
              _showLoadingTag = false;
              _dataSource += data.ListObjects;
            });
          });
        }).catchError((error) {
          setState(() {
            _showLoadingTag = false;
          });
          print(error);
        });
      },
      deleteCallback: () async {
        setState(() {
          _pageIndex = 0;
          _keywords = '';
          _ProductName = [];
          _TagList = [];
          _dataSource = [];
        });
        // 获取店主动态
        _getStoreGoods();
      },
      startCallback: () {
        if (mounted) {
          setState(() {
            _isShareing = true;
          });
        }
      },
      shareCallback: () {
        print('微信分享回调');
        // 加载ing
        if (mounted) {
          setState(() {
            _isShareing = false;
          });
        }
      },
    );
  }

  /*
  * 筛选点击
  * */
  void _onPressSearchFilter() {
    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }
}
