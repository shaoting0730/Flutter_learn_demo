import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../models/Enums.dart';
import '../../widgets/order_preview_cell.dart';
import '../../widgets/all_order_previewcell.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/order.dart';

class OrderList extends StatefulWidget {
  final OrderStatus status;

  OrderList({this.status}) : super(key: Key(status.toString()));

  @override
  State<OrderList> createState() {
    return OrderListState();
  }
}

class OrderListState extends State<OrderList> {
  List<ListObjects> _ordrList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrderData();
  }

  /*
  * 获取订单信息
  * */
  _getOrderData() async {
    var status = widget.status;
    print(status);

    var StoreGuid = CustomerApi().getStoreGuid();
    if (status == OrderStatus.All) {
      print('请求-全部');
      await CustomerApi()
          .SearchOrder(context, "", [], 0, 100, StoreGuid)
          .then((val) {
        setState(() {
          _ordrList = val.data.listObjects;
        });
      }).catchError((error) {});
    }
    if (status == OrderStatus.WaitAction) {
      print('请求-卖家确认');
      await CustomerApi()
          .SearchOrder(context, "", [], 0, 100, StoreGuid)
          .then((val) {
        setState(() {
          _ordrList = val.data.listObjects;
        });
      }).catchError((error) {});
    }
    if (status == OrderStatus.ReadyForShip) {
      print('请求-已支付');
      await CustomerApi()
          .SearchOrder(context, "", [], 0, 100, StoreGuid)
          .then((val) {
        setState(() {
          _ordrList = val.data.listObjects;
        });
      }).catchError((error) {});
    }
    if (status == OrderStatus.Packing) {
      print('请求-打包中');
      await CustomerApi()
          .SearchOrder(context, "", [], 0, 100, StoreGuid)
          .then((val) {
        setState(() {
          _ordrList = val.data.listObjects;
        });
      }).catchError((error) {});
    }
    if (status == OrderStatus.Shipped) {
      print('请求-已发货');
      await CustomerApi()
          .SearchOrder(context, "", [], 0, 100, StoreGuid)
          .then((val) {
        setState(() {
          _ordrList = val.data.listObjects;
        });
      }).catchError((error) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('widget.status ${widget.status}');
    return _ordrList.length != 0
        ? Container(
            child: ListView.builder(
              itemCount: _ordrList.length,
              itemBuilder: (BuildContext context, int index) {
                OrderStatus status = widget.status;
                if (index % 4 == 0) {
                  status = OrderStatus.WaitAction;
                } else if (index % 4 == 1) {
                  status = OrderStatus.ReadyForShip;
                } else if (index % 4 == 2) {
                  status = OrderStatus.Packing;
                } else if (index % 4 == 3) {
                  status = OrderStatus.Shipped;
                }
                if (widget.status == OrderStatus.All) {
                  return Column(
                    children: <Widget>[
                      AllOrderPreviewCell(
                        status: status,
                        orderInfo: _ordrList[index].orderInfo,
                        orderItems: _ordrList[index].orderItems,
                      )
                    ],
                  );
                } else {
                  return OrderPreviewCell(
                    orderInfo: _ordrList[index].orderInfo,
                    orderItems: _ordrList[index].orderItems,
                  );
                }
              },
            ),
          )
        : Center(
            child: Column(
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
                  style: TextStyle(color: Color(0xFF999999), fontSize: 11),
                ),
              ],
            ),
          );
  }
}
