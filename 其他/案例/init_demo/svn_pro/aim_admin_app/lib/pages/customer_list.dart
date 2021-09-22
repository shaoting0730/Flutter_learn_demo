import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/app_model.dart';
import '../models/loginmodel.dart';
import '../services/serviceapi.dart';

class CustomerList extends StatefulWidget {
  CustomerList({Key key}) : super(key: key);

  @override
  _CustomerListState createState() => new _CustomerListState();
}

const String membershipNameSuffix = '会员';
const smallTextStyle = TextStyle(fontSize: 12);

class _CustomerListState extends State<CustomerList> {
  static var membershipList =
      membershipLevels.map((o) => o + membershipNameSuffix).toList();

  static var orderTypeList = ['加入时间倒序', '活跃时间倒序'];
  static var orderByList = ['CreatedOnUtc', 'AffiliateDate'];
  String orderType = orderTypeList[0];

  List<AffiliateSummaryModel> customers = List<AffiliateSummaryModel>();

  String membership;
  _CustomerListState();

  @override
  void initState() {
    super.initState();

    //_retrieveList();
  }

  _retrieveList() async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      customers = await UserServerApi().getAffiliates(context, membership,
          "desc", orderByList[orderTypeList.indexOf(orderType)]);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (membership == null) {
      membership = args['membership'];
      _retrieveList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('客户管理'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeaders(context),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  _buildHeaders(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                DropdownButton<String>(
                  value: membership + membershipNameSuffix,
                  underline: Padding(padding: EdgeInsets.all(0)),
                  onChanged: (String newValue) {
                    setState(() {
                      membership =
                          newValue.replaceAll(membershipNameSuffix, '');
                      _retrieveList();
                    });
                  },
                  items: membershipList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: orderType,
                  underline: Padding(padding: EdgeInsets.all(0)),
                  onChanged: (String newValue) {
                    setState(() {
                      orderType = newValue;
                    });
                  },
                  items: orderTypeList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ]),
        ],
      ),
    );
  }

  _buildList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          return index < customers.length ? _buildItem(customers[index]) : null;
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  _buildItem(AffiliateSummaryModel model) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage("assets/person.jpg")),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.AffiliateUsername),
                        Text('个人本月消费：￥${model.AffiliateAmount}')
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(children: [Text('近365天积分：${model.AffiliatePoint}')]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              [
                Text(
                  '他的客户  ',
                  style: smallTextStyle,
                )
              ],
              membershipLevels.reversed
                  .map(
                    (level) => [
                      Text(
                        '$level：${(model.MyAffiliates[level] ?? 0).toInt()}',
                        style: smallTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                    ],
                  )
                  .expand((o) => o),
            ].expand((o) => o).toList(),
          ),
        ],
      ),
    );
  }
}
