import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils.dart';
import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../widgets/SimpleButton.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => new _OrdersState();
}

class OrderStatusItem {
  OrderStatusItem(this.name, this.status, this.statusId);

  String name;
  String status;
  int statusId;
  List<OrderModel> orders = List<OrderModel>();
  OrderResponse response;
}

final orderStatus = [
  OrderStatusItem("全部", "all", -1),
  OrderStatusItem("待发货", "paidaim", -1),
  OrderStatusItem("已发货", "shippedaim", -1),
  OrderStatusItem("已寄到", "", 200),
];

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    orderStatus.forEach((item) {
      item.response = null;
      item.orders.clear();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: orderStatus.map((item) => Tab(text: item.name)).toList(),
        ),
        title: Text('订单管理'),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _controller,
        children: orderStatus.map((item) => OrderItem(item: item)).toList(),
      ),
    );
  }
}

class OrderItem extends StatefulWidget {
  OrderStatusItem item;
  OrderItem({Key key, @required this.item}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  Widget _buildOrderItem(BuildContext context, OrderModel order, index) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("订单号:" + order.ReferenceOrderId, style: AimTheme.text12),
              SimpleButton(
                text: Text("复制", style: AimTheme.text12),
                onPressed: () {
                  Fluttertoast.showToast(
                      backgroundColor: Color(0xFF666666),
                      msg: "订单号复制成功",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);

                  Clipboard.setData(
                      ClipboardData(text: order.ReferenceOrderId));
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(order.WarehouseLocation, style: AimTheme.text12BgGrey),
              Text(
                  " " +
                      order.ShipToName.replaceRange(1, order.ShipToName.length,
                          "*" * (order.ShipToName.length - 1)) +
                      " " +
                      order.ShipToCellPhone.replaceRange(3, 7, "*" * 4) +
                      " " +
                      DateFormat('yyyy.MM.dd HH:mm').format(
                          Utils.fromAspDateTimeTicks(order.PaidDateUtc)),
                  style: AimTheme.text12),
            ],
          ),
          Column(
            children: order.OrderProduct.map(
                (product) => _buildProduct(context, product)).toList(),
          ),
          Row(
            children: [
              Text(
                  "共计商品${order.OrderProduct.fold(0, (c, o) => c + o.Quantity)}件",
                  style: AimTheme.text12),
              Spacer(),
              Text("合计￥${order.OrderReceivable}", style: AimTheme.text12Red),
              Text("(运费￥${order.OrderShipping} 税费￥${order.OrderTotalTax}",
                  style: AimTheme.text12Grey)
            ],
          ),
          Row(children: [
            Text("经销商：${order.MembershipLevel}会员 ${order.CustomerUserName}",
                style: AimTheme.text12),
            Spacer(),
            Text("已结算", style: AimTheme.text12),
          ]),
          Text(
              "预计可提现：￥${order.AimOrderWithdraw} 预计收益：￥${order.AimOrderCommission}",
              style: AimTheme.text12),
        ]));
  }

  _grabNextList(OrderStatusItem item) async {
    if (item.response == null) {
      item.response = await UserServerApi()
          .searchOrders(context, item.status, item.statusId, 0);
    } else {
      item.response = await UserServerApi().searchOrders(context, item.status,
          item.statusId, item.response.CurrentPageIndex + 1);
    }

    if (item.response != null) {
      item.orders.addAll(item.response.Orders);
      setState(() {});
    }
  }

  Widget _buildProduct(BuildContext context, OrderItemModel product) {
    return ListTile(
      leading: Image.network(
        product.ProductImageUrl,
        width: 60,
        height: 60,
      ),
      title: Text(product.ProductName, style: AimTheme.text12),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "优惠价：￥${product.UnitPrice}",
                style: AimTheme.text12Red,
              ),
              Text(
                "售价：￥${product.OldPrice}",
                style: AimTheme.text12LineThrough,
              ),
            ],
          ),
          Text("x${product.Quantity}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.response == null) {
      _grabNextList(widget.item);
    }

    if (widget.item.orders.length == 0) {
      return Center(
        child: Text(widget.item.response == null ? "正在查找..." : "没有订单"),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.item.orders?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if ((index + 1) % widget.item.response.PageSize == 0) {
          if ((widget.item.response.CurrentPageIndex + 1) *
                  widget.item.response.PageSize <
              widget.item.response.TotalCount) {
            _grabNextList(widget.item);
          }
        }
        return _buildOrderItem(context, widget.item.orders[index], index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
