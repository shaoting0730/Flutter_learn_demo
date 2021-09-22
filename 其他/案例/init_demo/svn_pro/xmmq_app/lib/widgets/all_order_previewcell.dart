import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Enums.dart';
import '../models/api/order.dart';
import '../utils/utils.dart';

class AllOrderPreviewCell extends StatefulWidget {
  final OrderStatus status;
  final OrderInfo orderInfo;
  final List<OrderItems> orderItems;

  AllOrderPreviewCell({this.status, this.orderInfo, this.orderItems});

  @override
  State<AllOrderPreviewCell> createState() {
    return AllOrderPreviewCellState();
  }
}

class AllOrderPreviewCellState extends State<AllOrderPreviewCell> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFF1F1F1),
        child: Column(children: <Widget>[
          _buildHeadArea(context),
          _buildProductThumbnailListArea(),
          _buildSummaryArea(),
          _buildSeparator(),
          Text('222')
        ]));
  }

  Widget _buildSeparator() {
    return Container(
      color: Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Divider(
        color: Color(0xFFDDDDDD),
        height: 0.5,
      ),
    );
  }

  Widget _buildSummaryArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 12.5, 15, 13),
      color: Color(0xFFFFFFFF),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("订单总价（共${widget.orderItems.length}件商品）",
                  style: TextStyle(fontSize: 14, color: Color(0xFF999999)))),
          Text("¥${widget.orderInfo.orderTotal}",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF999999),
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  Widget _buildHeadArea(BuildContext context) {
    Widget goodStatus;
    switch (widget.status) {
      case OrderStatus.ReadyForShip:
        goodStatus = Text("已支付",
            style: TextStyle(fontSize: 13, color: Color(0xFF666666)));
        break;
      case OrderStatus.Packing:
        goodStatus = Text("打包中",
            style: TextStyle(
                fontSize: 13,
                color: Color(0xFFFAA132),
                fontWeight: FontWeight.w600));
        break;
      case OrderStatus.WaitAction:
        goodStatus = Text("等待卖家确认",
            style: TextStyle(
                fontSize: 13,
                color: Color(0xFFEE5050),
                fontWeight: FontWeight.w600));
        break;
      case OrderStatus.Shipped:
        goodStatus = Text("已发货",
            style: TextStyle(fontSize: 13, color: Color(0xFF666666)));
        break;
      default:
        goodStatus = Text("全部");
    }
    var date = widget.orderInfo.createdOn;
    var text =
        DateFormat('yyyy-MM-dd HH:mm').format(Utils.fromAspDateTimeTicks(date));

    return Container(
      color: Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(15, 18.5, 15, 15.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Text(
            "$text",
            style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
          )),
          goodStatus
        ],
      ),
    );
  }

  Widget _buildProductThumbnailListArea() {
    return Container(
      color: Color(0xFFF1F1F1),
      width: double.infinity,
      height: 97,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.orderItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(8, 11, 8, 11),
              child: _buildProductOverviewItem(index));
        },
      ),
    );
  }

  Widget _buildProductOverviewItem(int index) {
    return Container(
      height: 75,
      width: 75,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.orderItems[index].productImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment(0.0, 0.0),
        child: Text('¥${widget.orderItems[index].discountAmount}',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0)),
        height: 18,
        width: 75,
        color: Color(0x99000000),
      ),
    );
  }
}
