import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class FinanceWithdrawalDetail extends StatefulWidget {
  FinanceWithdrawalDetail({Key key}) : super(key: key);

  @override
  _FinanceWithdrawalDetailState createState() =>
      new _FinanceWithdrawalDetailState();
}

class HistoryListItem {
  HistoryListItem(this.name, this.statusId);

  String name;
  int statusId;
  List<OrderModel> orders = List<OrderModel>();
  OrderResponse response;
}

// 所有 0 ,提现 22，转货款 4 ，批发收益 13 ，教育奖金 18，市场补贴和订单取消待定
final historyLists = [
  HistoryListItem("全部", 0),
  HistoryListItem("提现", 22),
  HistoryListItem("转货款", 4),
  HistoryListItem("批发收益", 13),
  HistoryListItem("教育奖金", 18),
//  HistoryListItem("市场补贴", 5),
  HistoryListItem("订单取消", 6),
];

class _FinanceWithdrawalDetailState extends State<FinanceWithdrawalDetail>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: historyLists.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: historyLists.map((item) => Tab(text: item.name)).toList(),
          ),
          title: InkWell(
            onTap: () {},
            child: Text('提现余额明细'),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _controller,
          children: historyLists
              .map((item) => Item(
                    index: item.statusId,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final int index;
  Item({Key key, @required this.index}) : super(key: key);

  @override
  _ItemState createState() => new _ItemState();
}

class _ItemState extends State<Item> {
  CustomerPrepayAccountHistoryList response;
  List<CustomerPrepayAccountHistoryModel> items =
      List<CustomerPrepayAccountHistoryModel>();

  Widget build(BuildContext context) {
    return _buildOrderList(context);
  }

  _grabNextList() async {
    if (response == null) {
      response =
          await UserServerApi().getDrawalAccount(context, widget.index, 0);
    } else {
      //response = await UserServerApi().getPrepayAccount(context, "prepay", response.AccountHistory.CurrentPageIndex + 1);
    }

    if (response != null) {
      items.addAll(response.AccountHistory.ListObjects);
      setState(() {});
    }
  }

  Widget _buildOrderList(BuildContext context) {
    if (response == null) {
      _grabNextList();
    }

    if (items.length == 0) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(response == null ? "正在查找..." : "没有记录"),
        ),
      );
    }

    var groups = groupBy(
        items,
        (item) => DateFormat('y年MM月')
            .format(Utils.fromAspDateTimeTicks(item.CreatedOnUtc)));
    var keys = groups.keys.toList();
    keys.sort();
    keys = keys.reversed.toList();

    var displayItems = keys.expand((key) {
      var list = [
        CustomerPrepayAccountHistoryModel(
            Summary: key,
            Amount: groups[key].fold(0, (curr, next) => curr + next.Amount))
      ];
      list.addAll(groups[key]);
      return list;
    }).toList();

    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: displayItems.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if ((index + 1) % response.AccountHistory.PageSize == 0) {
          if ((response.AccountHistory.CurrentPageIndex + 1) *
                  response.AccountHistory.PageSize <
              response.AccountHistory.TotalCount) {
            _grabNextList();
          }
        }
        return _buildListItem(context, displayItems[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildListItem(
      BuildContext context, CustomerPrepayAccountHistoryModel displayItem) {
    if (displayItem.Summary != null) {
      return ListTile(
        leading: Icon(Icons.equalizer, color: Theme.of(context).primaryColor),
        title: Text(displayItem.Summary),
        contentPadding: EdgeInsets.all(2),
        trailing: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "获取：", style: AimTheme.text12Grey),
              TextSpan(
                  text: "${displayItem.Amount.toStringAsFixed(2)}",
                  style: AimTheme.text16Red),
            ],
          ),
        ),
      );
    } else {
      return ListTile(
        title: Text(displayItem.Message + (displayItem.ReferenceOrderId ?? '')),
        subtitle: Text(DateFormat('y-MM-dd')
            .format(Utils.fromAspDateTimeTicks(displayItem.CreatedOnUtc))),
        trailing: Text("${displayItem.Amount.toStringAsFixed(2)}"),
      );
    }
  }
}
