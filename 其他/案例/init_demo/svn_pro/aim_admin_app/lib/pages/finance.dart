import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class Finance extends StatefulWidget {
  Finance({Key key}) : super(key: key);

  @override
  _FinanceState createState() => new _FinanceState();
}

class _FinanceState extends State<Finance> {
  CustomerPrepayAccountHistoryList data;

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () async {
      data = await UserServerApi().getPrepayAccount(context, null, 0);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
//    print('data?.WithdrawalBalance ${data?.WithdrawalBalance}');

    return Scaffold(
      appBar: AppBar(
        title: Text('财务管理'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          ListTile(
            title: Text('可提现余额(元)'),
            trailing: Text('￥${data?.WithdrawalBalance ?? '-.--'}'),
          ),
          ListTile(
            title: Text('提现余额明细'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/finance_withdrawal_detail');
            },
          ),
          ListTile(
            title: Text('账户余额明细'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/finance_prepay_detail');
            },
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MaterialButton(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '提交提现申请',
                    style: AimTheme.text16White,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customer_request',
                        arguments: {'title': '提现申请', 'service': 4});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '账号余额(元)',
            style: AimTheme.text16White,
          ),
          Text(
            "￥${data?.AccountBalance ?? '-.--'}",
            style: AimTheme.text28White,
          )
        ],
      ),
    );
  }
}
