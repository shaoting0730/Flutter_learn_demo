import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/app_model.dart';
import '../models/loginmodel.dart';
import '../services/serviceapi.dart';

class Customers extends StatefulWidget {
  Customers({Key key}) : super(key: key);

  @override
  _CustomersState createState() => new _CustomersState();
}

class _CustomersState extends State<Customers> {
  AffiliateSummaryModel myInfo;
  DateTime period = DateTime.now();
  AffiliateSummaryModel periodInfo;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () async {
      myInfo = await UserServerApi().myAffiliateInfo(context, null);
      setState(() {});

      periodInfo = await UserServerApi().myAffiliateInfo(context, period);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('客户管理'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPoints(context),
            _buildMyCustomers(context),
          ],
        ),
      ),
    );
  }

  _buildPoints(context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('您当前的积分是：${myInfo?.AffiliatePoint ?? 0}'),
                Spacer(),
//            MaterialButton(
//              child: Row(children: [
//                Text("明细"),
//                Icon(Icons.chevron_right),
//              ]),
//              onPressed: () {},
//            ),
              ])
        ]));
  }

  _buildMyCustomers(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("我的客户"),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          margin: const EdgeInsets.only(top: 5),
          child: Column(children: [
            Row(children: [Text("所有客户")]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: membershipLevels.reversed
                  .map((level) => Expanded(
                      child: MaterialButton(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          onPressed: () {
                            Navigator.pushNamed(context, "/customer_list",
                                arguments: {'membership': level});
                          },
                          child: Column(children: [
                            Text(
                              "$level会员",
                            ),
                            Text(
                                "${myInfo == null ? 0 : myInfo.MyAffiliates[level] ?? 0}")
                          ]))))
                  .toList(),
            ),
            Divider(),
            Row(children: [Text("活跃客户")]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: membershipLevels.reversed
                  .map((level) => Expanded(
                      child: MaterialButton(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          onPressed: () {
                            Navigator.pushNamed(context, "/customer_list",
                                arguments: {'membership': level});
                          },
                          child: Column(children: [
                            Text(
                              "$level会员",
                            ),
                            Text(
                                "${myInfo == null ? 0 : myInfo.MyAffiliates[level] ?? 0}")
                          ]))))
                  .toList(),
            ),
            Divider(),
            Row(children: [
              Text("${period.year}年${period.month}月以来新增客户"),
              Spacer(),
              RaisedButton(
                  onPressed: () async {
                    period = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.light(),
                          child: child,
                        );
                      },
                    );
                    setState(() {});
                  },
                  child: Text('选择月份')),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: membershipLevels.reversed
                  .map((level) => Expanded(
                      child: MaterialButton(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          onPressed: () {
                            Navigator.pushNamed(context, "/customer_list",
                                arguments: {'membership': level});
                          },
                          child: Column(children: [
                            Text(
                              "$level会员",
                            ),
                            Text(
                                "${periodInfo == null ? 0 : periodInfo.MyAffiliates[level] ?? 0}")
                          ]))))
                  .toList(),
            ),
          ]),
        ),
      ]),
    );
  }
}
