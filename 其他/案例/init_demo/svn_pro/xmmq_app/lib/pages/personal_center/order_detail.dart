/*
*   订单详情
* */

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../serviceapi/customerapi.dart';
import '../../models/Enums.dart';
import '../../models/api/order.dart';
//import '../order_detail.dart'l.dart';
import '../../utils/utils.dart';
import '../../utils/event_bus.dart';
import '../../widgets/loading_widget.dart';

class OrderDetails extends StatefulWidget {
  final OrderInfo orderInfo;
  final List<OrderItems> orderItems;
  OrderDetails({this.orderInfo, this.orderItems});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String _sharePic = '';
  bool _isWeChatInstalledTag = false; // 是否安装了微信
  bool _showLoadingTag = false; //  加载中状态
  StreamSubscription<fluwx.WeChatAuthResponse> _wxListener = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(jsonEncode(widget.orderItems));
//    print(jsonEncode(widget.orderInfo));
    if (_wxListener != null) {
      _wxListener.cancel();
      _wxListener = null;
    }
    _registerAction();

    print(jsonEncode(widget.orderInfo));
    print(jsonEncode(widget.orderItems));
  }

  _registerAction() async {
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });

    fluwx.responseFromShare.listen((data) {
      print('分享回调$data');
    });
  }

  /*
  *   计算商品个数
  * */
  int _productNum() {
    var i = 0;
    widget.orderItems.forEach((e) {
      i += e.quantity;
    });
    return i;
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          '订单详情',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[
//          _buildHeadArea(context),
//          _buildProductThumbnailListArea(),
//          _orderInfoWidget(),
//          _btnWidget(),
                widget.orderInfo.shipToCity.length > 0
                    ? Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/bg_order_location_top.png',
                            width: MediaQuery.of(context).size.width,
                          ),
                          _personalInfoWidget(), // 头部信息
                          Image.asset(
                            'assets/bg_order_location_top.png',
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      )
                    : Container(
                        height: 0,
                      ),
                _middleWidget(),
                _shopWidget(), // 商店显示
                _middleWidget(),
                _timetypeWidget(), // 时间栏
                _middleLineWidget(),
                _productWidget(), // 产品
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      '共${_productNum().toString()}件商品',
                      style: TextStyle(
                        color: Color.fromRGBO(136, 136, 136, 1),
                      ),
                    ),
                  ),
                ),
                _priceWidget(), // 价格widget
                _middleWidget(),
                _remarkWidget(),
                Container(
                  height: 100,
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: _btnWidget(),
            ),
          ),
          _showLoadingTag == true
              ? Positioned(
                  child: Center(
                    child: LoadingWidget(
                      title: '分享中...',
                    ),
                  ),
                )
              : Text(''),
        ],
      ),
    );
  }

  /*
  * 订单号 + 备注
  * */
  Widget _remarkWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          // 订单号
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text('订单号'),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    children: <Widget>[
                      Text('${widget.orderInfo.referenceOrderGuid}'),
                      Text('   |'),
                      SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: widget.orderInfo.referenceOrderGuid));
                          Fluttertoast.showToast(
                              backgroundColor: Color(0xFF666666),
                              msg:
                                  "订单号${widget.orderInfo.referenceOrderGuid} 已经复制~",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER);
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset('assets/icon_my_code_copy.png'),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                '复制',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 175, 76, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _middleLineWidget(),
          // 备注
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 80),
                  child: Text('备注'),
                ),
                Expanded(
                  child: Text(
                    '${widget.orderInfo.notes}',
                    softWrap: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /*
  *  价格模块
  * */
  Widget _priceWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              '商品总价',
              style: TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
            ),
            trailing: Text(
              '¥${(widget.orderInfo.orderTotal - widget.orderInfo.orderShipping).toStringAsFixed(1)}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Text(
              '运费',
              style: TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
            ),
            trailing: Text(
              '¥${Utils.stringFormat(widget.orderInfo.orderShipping.toString())}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          _middleLineWidget(),
          ListTile(
            leading: Text(
              '订单总价',
              style: TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '¥ ${widget.orderInfo.orderTotal.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 产品
  * */
  Widget _productWidget() {
    if (widget.orderItems.length > 0) {
      List<Widget> _listWidget = widget.orderItems.map((e) {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                e.productImageUrl,
                width: 120,
                height: 110,
                fit: BoxFit.fill,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    width: 200,
                    child: Text(
                      '${e.productVariantName} ',
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'x${e.quantity}',
                    style: TextStyle(
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                  ),
                  Text(
                    '¥ ${(widget.orderInfo.orderTotal - widget.orderInfo.orderShipping).toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList();
      return Column(children: _listWidget);
    } else {
      return Text('');
    }
  }

  /*
  *   时间栏
  * */
  Widget _timetypeWidget() {
    var date = widget.orderInfo.createdOn;
    var text = DateFormat('yyyy-MM-dd HH:mm').format(
      Utils.fromAspDateTimeTicks(date),
    );
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              '$text',
              style: TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text(
              '${widget.orderInfo.orderStatus}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  /*
  * 中部分割视图
  * */
  Widget _middleWidget() {
    return Container(
      height: 12,
      color: Color.fromRGBO(245, 245, 245, 1),
    );
  }

  /*
  * 中部分割线
  * */
  Widget _middleLineWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: 400,
      height: 1,
      color: Color.fromRGBO(245, 245, 245, 1),
    );
  }

  /*
  *  供货店铺
  * */
  Widget _shopWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    '供货店铺',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    '${widget.orderInfo.vendorName}',
                    style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _middleLineWidget(),
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('下单人'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.network(
                          '${widget.orderInfo.wechatThumberUrl}',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ),
                      Text(
                        ' ${widget.orderInfo.wechatNickName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ],
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
  * 订单头部用户信息
  * */
  Widget _personalInfoWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 头像+用户名
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_order_adress1.png'),
                    Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text(
                        '${widget.orderInfo.shipToName}',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              // 头像+用户名
              Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_order_adress2.png'),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('${widget.orderInfo.shipToPhone}'),
                    )
                  ],
                ),
              ),
              // 复制
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: widget.orderInfo.shipToPhone,
                    ),
                  );
                  Fluttertoast.showToast(
                      backgroundColor: Color(0xFF666666),
                      msg: "手机号 已经复制~",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_my_code_copy.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          '复制',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 175, 76, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Image.asset('assets/icon_order_adress3.png'),
                ),
                Expanded(
                  child: Text(
                    '${widget.orderInfo.shipToProvince}${widget.orderInfo.shipToCity}${widget.orderInfo.shipToAddress}',
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnWidget() {
    var status = widget.orderInfo.orderStatus;

    if (status == '等待卖家确认' || status == '未支付') {
      return InkWell(
        onTap: () {
          Map map = {
            'CopyToStoreGuid': '',
            'Guid': widget.orderInfo.guid,
            'OrderStatusId': 10,
            'ReferenceOrderGuid': '',
          };
          CustomerApi().BatchUpdateOrderStatus(context, [map]).then((e) {
            if (e['Success'] == true) {
              eventBus.fire(new ReturnPreviousPage(['ReadyForShip']));
              Navigator.pop(context);
            }
          }).catchError((error) {
            print(error);
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 45,
          color: Color.fromRGBO(255, 175, 76, 1),
          child: Center(
            child: Text(
              '标记为已付款',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      );
    } else if (status == '发货中' || status == '已支付') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _isWeChatInstalledTag == true
                ? InkWell(
                    onTap: () {
                      if (widget.orderItems.length > 0) {
                        setState(() {
                          _showLoadingTag = true;
                        });

//                        print(widget.orderItems[0].orderGuid);
                        Map map = {
                          "GuidList": [widget.orderItems[0].orderGuid],
                          "IsDisplayPrice": true,
                        };

                        CustomerApi()
                            .GetDQOrderSharePictureEx(context, map)
                            .then((e) {
                          setState(() {
                            _showLoadingTag = false;
                          });
                          if (e['Success'] == true) {
                            var imgStr = e['Data']['ImageUrl'];

                            fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;
                            String _imagePath = imgStr;

                            fluwx.share(
                              fluwx.WeChatShareImageModel(
                                  image: _imagePath,
                                  thumbnail: _imagePath,
                                  transaction: _imagePath,
                                  scene: scene,
                                  description: "image"),
                            );
                          }
                        }).catchError((error) {
                          print(error);
                          setState(() {
                            _showLoadingTag = false;
                          });
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 45,
                      color: Colors.amber,
                      child: Center(
                        child: Text(
                          '分享给供货商发货',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  )
                : Text(''),
            InkWell(
              onTap: () {
                Map map = {
                  'CopyToStoreGuid': '',
                  'Guid': widget.orderInfo.guid,
                  'OrderStatusId': 29,
                  'ReferenceOrderGuid': '',
                };
                CustomerApi().BatchUpdateOrderStatus(context, [map]).then((e) {
                  if (e['Success'] == true) {
                    eventBus.fire(new ReturnPreviousPage(['Shipped']));
                    Navigator.pop(context);
                  }
                }).catchError((error) {
                  print(error);
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 45,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    '标记为已发货',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }
}
