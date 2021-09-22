import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';

class Notify extends StatefulWidget {
  Notify({Key key}) : super(key: key);

  @override
  _NotifyState createState() => new _NotifyState();
}

class _NotifyState extends State<Notify> {
  List<NotifyListItemModel> list;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知列表'),
        centerTitle: true,
      ),
      body: _buildNotifyList(context),
    );
  }

  @override
  initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () async {
      list = await UserServerApi().getNotifyList(context);
      setState(() {});
    });
  }

  _buildNotifyList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: list?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (list == null || index < 0 || index >= list.length) return null;
          return _buildItem(context, list[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  _buildItem(BuildContext context, NotifyListItemModel item) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.Subject),
              Text(
                  new DateFormat('yyyy-MM-dd hh:mm').format(item.CreatedOnUtc)),
            ],
          ),
          Text(
            '通知内容：',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.left,
          ),
          Text(item.Body),
        ],
      ),
    );
  }
}
