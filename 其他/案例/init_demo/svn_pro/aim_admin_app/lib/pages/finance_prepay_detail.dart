import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class FinancePrepayDetail extends StatefulWidget {
  FinancePrepayDetail({Key key}) : super(key: key);

  @override
  _FinancePrepayDetailState createState() => new _FinancePrepayDetailState();
}

class _FinancePrepayDetailState extends State<FinancePrepayDetail> {
  CustomerPrepayAccountHistoryList response;
  List<CustomerPrepayAccountHistoryModel> items =
      List<CustomerPrepayAccountHistoryModel>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('账户余额明细'),
          centerTitle: true,
        ),
        body: _buildOrderList(context));
  }

  _grabNextList() async {
    if (response == null) {
      response = await UserServerApi().getPrepayAccount(context, "prepay", 0);
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
