import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'order_list.dart';
import '../../models/Enums.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/order.dart';
import '../../widgets/order_preview_cell.dart';
import '../../utils/event_bus.dart';
import '../../widgets/loading_widget.dart';

class OrderListPage extends StatefulWidget {
  @override
  State<OrderListPage> createState() {
    return OrderListPageState();
  }
}

class OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  bool _allSelect = false; // 全选按钮
  bool _allType = false; // 是否点击了全部按钮
  double _totalMoney = 0.0; //  总金额
  List<ListObjects> _orderList = []; //  订单数据源
  int _pageNum = 0; //  默认加载第0页
  bool _showLoadingTag = true; //  加载中状态
  bool _shareIngTag = false; //  分享中

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  List _sourceData = [
    {
      'tag': '1',
      'txt': '未付款',
      'value': 'Unpaid',
    },
    {
      'tag': '2',
      'txt': '等待卖家确认',
      'value': 'WaitAction',
    },
    {
      'tag': '3',
      'txt': '已支付',
      'value': 'ReadyForShip',
    },
    {
      'tag': '4',
      'txt': '打包中',
      'value': 'Packing',
    },
    {
      'tag': '5',
      'txt': '已发货',
      'value': 'Shipped',
    }
  ]; //  数据
  List _selectList = []; //  选中的标签
  List _selettTxtList = []; // 选中的标签的文字
  List _selectOrder = []; // 选中的订单

  /*
  * 获取订单信息
  * */
  _getOrderData(List list) async {
    var StoreGuid = CustomerApi().getStoreGuid();
//    print('请求list $list');
    if (list.length == 0) {
      list = ['All'];
    }
    setState(() {
      _showLoadingTag = true;
    });

    await CustomerApi()
        .SearchOrder(context, "", list, _pageNum, 20, StoreGuid)
        .then((val) {
//      print(jsonEncode(val));
      setState(() {
        _orderList += val.data.listObjects;
      });
      if (val.data.listObjects.length == 0) {
        setState(() {
          _showLoadingTag = false;
        });
      }
    }).catchError((error) {
      setState(() {
        _showLoadingTag = false;
      });
    });
  }

  @override
  void initState() {
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

    // 默认请求全部
    _getOrderData(['All']);
  }

  /*
  * 推导出价格
  * */
  String _deduceNext() {
    if (_selettTxtList[0] == '未付款' || _selettTxtList[0] == '等待卖家确认') {
      return '标记为已支付';
    } else if (_selettTxtList[0] == '已支付') {
      return '已发货';
    } else {
      return '';
    }
  }

  //监听Bus events
  void _listen() {
    eventBus.on<ReturnPreviousPage>().listen((event) {
//      print(event.list);
      print(_selectList);
      if (mounted) {
        _getOrderData(_selectList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '我的销售订单',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (_animation.status == AnimationStatus.completed) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  print(_selettTxtList);
                },
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  height: 41,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: _typeTxtWidget(),
                        ),
                        Row(
                          children: <Widget>[
                            _animation == null ||
                                    _animation.status == null ||
                                    _animation.status ==
                                        AnimationStatus.completed
                                ? Image.asset(
                                    'assets/icon_home_screen_yellow.png',
                                    width: 12)
                                : Image.asset(
                                    'assets/icon_home_screen_gray.png',
                                    width: 12),
                            Text(
                              '  筛选',
                              style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//               全选按钮
              _selectList.length == 1 &&
                      (_selettTxtList[0] == '未付款' ||
                          _selettTxtList[0] == '已支付' ||
                          _selettTxtList[0] == '等待卖家确认')
                  ? Container(
                      height: 40,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Color(0xFFF1F1F1),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: _allSelect,
                                onChanged: (bool value) {
                                  eventBus
                                      .fire(new OrderAllSelect(value)); // 先发
                                  setState(() {
                                    _allSelect = value;
                                    _selectOrder = [];
                                    _totalMoney = 0.0;
                                  });

                                  if (value == false) {
                                    setState(() {
                                      _selectOrder = [];
                                      _totalMoney = 0.0;
                                    });
                                  } else {
                                    _orderList.forEach((e) {
                                      String json = jsonEncode(e.orderInfo);
                                      setState(() {
                                        _selectOrder.add(json);
                                        _totalMoney += e.orderInfo.orderTotal;
                                      });
                                    });
                                  }
                                },
                              ),
                              Text(
                                '全选',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '总金额： ¥${_totalMoney.toString()}   ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              Expanded(
                child: _orderList.length != 0
                    ? Stack(
                        children: <Widget>[
                          Container(
                            color: Color.fromRGBO(246, 246, 246, 1),
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
                                setState(() {
                                  _pageNum++;
                                });
                                _getOrderData(_selectList);
                              },
                              onRefresh: () async {
                                setState(() {
                                  _pageNum = 0;
                                  _totalMoney = 0.0;
                                  _orderList = [];
                                });
//                                eventBus.fire(new CancelOrderSelect(1)); // 先发

                                _getOrderData(_selectList);
                              },
                              child: ListView.builder(
                                itemCount: _orderList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OrderPreviewCell(
                                    checkTag: _selectList.length == 1 &&
                                            (_selettTxtList[0] == '未付款' ||
                                                _selettTxtList[0] == '等待卖家确认' ||
                                                _selettTxtList[0] == '已支付')
                                        ? true
                                        : false,
                                    orderInfo: _orderList[index].orderInfo,
                                    orderItems: _orderList[index].orderItems,
                                    orderAttributes:
                                        _orderList[index].orderAttributes,
                                    backOrder: (orderInfo, orderItems, tag) {
//                                print(jsonEncode(orderItems));
//                                print(jsonEncode(orderInfo));
//                                setState(() {
//                                  _selectOrder = [];
//                                  _totalMoney = 0;
//                                });
                                      String json = jsonEncode(orderInfo);
                                      _selectOrder.add(json);
                                      Set set = _selectOrder.toSet();
                                      List list_last = set.toList();
//                                  print('dianjile');
                                      if (tag == false) {
                                        // 等于false，删除该订单
                                        list_last.remove(json);
                                        setState(() {
                                          _selectOrder = list_last;
                                          _totalMoney -= orderInfo.orderTotal;
                                        });
                                      } else {
                                        setState(() {
                                          _selectOrder = list_last;
                                          _totalMoney += orderInfo.orderTotal;
                                        });
                                      }
//                                  print(_selectOrder);
                                    },
                                    deleteAction: (orderInfo, orderItems) {
                                      print(jsonEncode(orderInfo));
                                      print(jsonEncode(orderItems));

                                      Map map = {
                                        'Guid': orderInfo.guid,
                                        'StoreCustomerGuid': orderInfo.storeGuid
                                      };
                                      setState(() {
                                        _pageNum = 0;
                                        _orderList = [];
                                      });
                                      CustomerApi()
                                          .DeleteOrder(context, map)
                                          .then((e) {
                                        if (e['Success'] == true) {
                                          _getOrderData(_selectList);
                                        }
                                      }).catchError((error) {
                                        print(error);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          _shareIngTag == true
                              ? Center(
                                  child: LoadingWidget(
                                    title: '分享中～',
                                  ),
                                )
                              : Text('')
                        ],
                      )
                    : Center(
                        child: Column(
                          children: <Widget>[
                            _showLoadingTag == true
                                ? LoadingWidget(
                                    title: '订单加载中...',
                                  )
                                : Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/noData.png',
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Text(
                                        '没有订单数据～',
                                        style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          _selettTxtList.length == 1 &&
                  (_selettTxtList[0] == '未付款' ||
                      _selettTxtList[0] == '等待卖家确认' ||
                      _selettTxtList[0] == '已支付')
              ? Positioned(
                  bottom: 100,
                  right: 0,
                  child: Column(
                    children: <Widget>[
                      _selettTxtList[0] == '已支付'
                          ? InkWell(
                              onTap: () {
                                if (_selectOrder.length == 0) {
                                  Fluttertoast.showToast(
                                      backgroundColor: Color(0xFF666666),
                                      msg: "请至少选择一单",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER);
                                } else {
                                  setState(() {
                                    _shareIngTag = true;
                                  });

                                  List list = [];
                                  _selectOrder.forEach((e) {
                                    var newMap = jsonDecode(e);
                                    list.add(newMap['Guid']);
                                  });

                                  Map map = {
                                    "GuidList": list,
                                    "IsDisplayPrice": true,
                                  };

                                  CustomerApi()
                                      .GetDQOrderSharePictureEx(context, map)
                                      .then((e) {
                                    if (e['Success'] == true) {
                                      String imgStr = e['Data']['ImageUrl'];

                                      fluwx.WeChatScene scene =
                                          fluwx.WeChatScene.SESSION;
                                      String _imagePath = imgStr;

                                      fluwx.share(
                                        fluwx.WeChatShareImageModel(
                                            image: _imagePath,
                                            thumbnail: _imagePath,
                                            transaction: _imagePath,
                                            scene: scene,
                                            description: "image"),
                                      );

                                      setState(() {
                                        _shareIngTag = false;
                                      });
                                      // 分享图片
                                    }
                                  }).catchError((error) {
                                    print(error);
                                    setState(() {
                                      _shareIngTag = false;
                                    });
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 102, 102, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                width: 120,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '分享给供货商',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Text(''),
                      InkWell(
                        onTap: () {
//                          print('222');
//                          print(_selectOrder);
//                          print(_selettTxtList[0]);
                          if (_selectOrder.length == 0) {
                            Fluttertoast.showToast(
                                backgroundColor: Color(0xFF666666),
                                msg: "请至少选择一单",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER);
                          } else {
                            List list = [];
                            _selectOrder.forEach((e) {
                              var newMap = jsonDecode(e);
                              var id = '';
                              if (_selettTxtList[0] == '未付款') {
                                id = '10';
                              } else if (_selettTxtList[0] == '等待卖家确认') {
                                id = '10';
                              } else if (_selettTxtList[0] == '已支付') {
                                id = '29';
                              }

                              Map map = {
                                'CopyToStoreGuid': '',
                                'Guid': newMap['Guid'],
                                'OrderStatusId': id,
                                'ReferenceOrderGuid': '',
                              };
                              list.add(map);
                            });
//                            print(' 参数');
//                            print(list);
                            CustomerApi()
                                .BatchUpdateOrderStatus(context, list)
                                .then((e) {
                              if (e['Success'] == true) {
                                print(e);
                                // 标记成功
                                setState(() {
                                  _pageNum = 0;
                                  _orderList = [];
                                  _totalMoney = 0.0;
                                });
                                _getOrderData(_selectList);
                              }
                            }).catchError((error) {
                              print(error);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 175, 76, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                          width: 120,
                          height: 50,
                          child: Center(
                            child: Text(
                              _deduceNext(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
              : Text(''),
          Container(
            margin: new EdgeInsets.only(top: 40.0),
            height: _animation == null ? 0 : _animation.value,
            width: MediaQuery.of(context).size.width,
            child: _filtrateWidget(),
          ),
        ],
      ),
    );
  }

  Widget _typeTxtWidget() {
    var txt = '';
    _selettTxtList.forEach((e) {
      var result = e + ' ';
      txt += result;
    });
    if (_selettTxtList.length >= 5 || _selettTxtList.length == 0) {
      return Text(
        '全部',
        style: TextStyle(
          color: Color.fromRGBO(253, 159, 60, 1),
        ),
      );
    }
    return Text(
      txt,
      style: TextStyle(
        color: Color.fromRGBO(253, 159, 60, 1),
      ),
    );
  }

  /*
   * 筛选
   * */
  Widget _filtrateWidget() {
    return Container(
      width: double.infinity,
      child: Material(
        type: MaterialType.transparency,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('订单状态'),
                        ),
                        _allBtnWidget(),
                        // 全部按钮
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: <Widget>[
                              _timerWidget(),
                            ],
                          ),
                        ),
                        _bottomWidget(), //    底部按钮视图
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 800,
                    color: Color.fromRGBO(123, 123, 123, 0.5),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _selectList = [];
              _selettTxtList = [];
              _orderList = [];
              _allType = false;
            });
            eventBus.fire(new CancelOrderSelect(1)); // 先发
            _controller.reverse();
            _getOrderData(['All']);
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 246, 246, 1),
            ),
            child: Center(
              child: Text(
                '清空',
                style: TextStyle(
                  color: Color.fromRGBO(153, 153, 153, 1),
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _controller.reverse();
//                            print(_selectList);
            setState(() {
              _orderList = [];
              _pageNum = 0;
            });
            if (_selectList.length > 0) {
              print(_selectList);
              _getOrderData(_selectList);
            } else {
              _getOrderData(['All']);
            }
          },
          child: Container(
            height: 44,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 198, 63, 1),
            ),
            child: Center(
              child: Text(
                '确认',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*
  * 全部按钮
  * */
  Widget _allBtnWidget() {
    return InkWell(
      onTap: () {
        setState(() {
          _allType = !_allType;
        });
        if (_allType == false) {
          // 取消全选
          setState(() {
            _selectList.clear();
            _selettTxtList.clear();
          });
          _getOrderData(['All']);
          eventBus.fire(new CancelOrderSelect(1)); // 先发
        } else {
          _getOrderData(['All']);
          setState(() {
            _selectList = [
              'Unpaid',
              'WaitAction',
              'Packing',
              'ReadyForShip',
              'Shipped'
            ];
            _selettTxtList = ['未付款', '等待卖家确认', '已支付', '打包中', '已发货'];
          });
          // 全选
          eventBus.fire(new CancelOrderSelect(0)); // 先发
        }
//                              print(_selectList);
//                              print(_selettTxtList);
      },
      child: Container(
        color: _allType == false
            ? Color.fromRGBO(243, 243, 243, 1)
            : Color.fromRGBO(255, 240, 221, 1),
        height: 34,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Center(
          child: Text('全部'),
        ),
      ),
    );
  }

  /*
  * 时间轴
  * */
  Widget _timerWidget() {
    List<Widget> widget_list = _sourceData.map((e) {
      return TimerContainerWidget(
        map: e,
        onclickAction: (e) {
//          print(e);

          var value = e['value'];
          if (_selectList.contains(value)) {
            if (mounted) {
              setState(() {
                _selectList.remove(value);
                _selettTxtList.remove(e['txt']);
              });
            }
          } else {
            if (mounted) {
              setState(() {
                _selectList.add(value);
                _selettTxtList.add(e['txt']);
              });
            }
          }
          if (_selectList.length == 5) {
            setState(() {
              _allType = true;
            });
          } else {
            _allType = false;
          }
//          print('最终数据 $_selectList');
        },
      );
    }).toList();
    return Column(children: widget_list);
  }
}

/*
*  单个时间轴
* */
class TimerContainerWidget extends StatefulWidget {
  final Map map;
  Function onclickAction;
  TimerContainerWidget({Key key, this.map, this.onclickAction(Map map)})
      : super(key: key);

  @override
  _TimerContainerWidgetState createState() => _TimerContainerWidgetState();
}

class _TimerContainerWidgetState extends State<TimerContainerWidget> {
  bool _selectTag = false;
  @override

  //监听Bus events
  void _listen() {
    eventBus.on<CancelOrderSelect>().listen((event) {
      if (event.num == 0) {
        if (mounted) {
          setState(() {
            _selectTag = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _selectTag = false;
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    _listen();
    return InkWell(
      onTap: () {
//        print(widget.map['txt']);
        widget.onclickAction(widget.map);
        setState(() {
          _selectTag = !_selectTag;
        });
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.map['txt'] != '未付款'
                      ? Expanded(
                          child: Container(
                            width: 1,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          ),
                        )
                      : Text(''),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.symmetric(vertical: 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Color.fromRGBO(255, 175, 76, 1),
                      ),
                    ),
                    child: Center(
                      child: _selectTag == true
                          ? Image.asset('assets/icon_detail_add_yellow.png')
                          : Text(
                              widget.map['tag'],
                              style: TextStyle(
                                color: Color.fromRGBO(255, 175, 76, 1),
                              ),
                            ),
                    ),
                  ),
                  widget.map['txt'] != '已发货'
                      ? Expanded(
                          child: Container(
                            width: 1,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          ),
                        )
                      : Text('')
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                height: 52,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  height: 40,
                  color: _selectTag == true
                      ? Color.fromRGBO(255, 240, 221, 1)
                      : Color.fromRGBO(243, 243, 243, 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.map['txt'],
                        style: TextStyle(
                            color: _selectTag == true
                                ? Color.fromRGBO(239, 117, 29, 1)
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
