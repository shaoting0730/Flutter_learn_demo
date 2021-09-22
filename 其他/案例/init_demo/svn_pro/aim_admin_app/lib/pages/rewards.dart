import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loginmodel.dart';
import '../services/serviceapi.dart';
import '../utils.dart';

class Rewards extends StatefulWidget {
  Rewards({Key key}) : super(key: key);

  @override
  _RewardsState createState() => new _RewardsState();
}

class _RewardsState extends State<Rewards> {
  CustomerRewardPointsResponse response;
  List<RewardPointsHistoryModel> items = List<RewardPointsHistoryModel>();

  _grabNextList() async {
    if (response == null) {
      response = await UserServerApi().getRewardPointsHistory(context, 0);
    } else {
      //response = await UserServerApi().getPrepayAccount(context, "prepay", response.AccountHistory.CurrentPageIndex + 1);
    }

    if (response != null) {
      items.addAll(response.CustomerRewardPoints);
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0), // here the desired height
        child: AppBar(
          title: Text('我的积分'),
          centerTitle: true,
          flexibleSpace: _buildMyHeader(context),
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline, size: 28),
              onPressed: () {
                Navigator.pushNamed(context, "/topic",
                    arguments: {'name': 'AboutRewards'});
              },
            ),
          ],
        ),
      ),
      body: _buildList(context),
    );
  }

  _buildMyHeader(BuildContext context) {
//    var cur = items != null && items.length > 0 ? items.first.PointsBalance : 0;
    var cur = response == null ? '' : response.TotalRedeemablePoints;
    return ListTile(
        contentPadding: EdgeInsets.only(left: 10, top: 70),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(),
            Text('$cur', style: AimTheme.text20White),
            Text(' 积分', style: AimTheme.text12White),
            Spacer(),
          ],
        ));
  }

  Widget _buildList(BuildContext context) {
    if (response == null) {
      _grabNextList();
    }

    if (items.length == 0) {
      return Padding(
          padding: EdgeInsets.all(10),
          child: Text(response == null ? "正在查找..." : "还没有积分，快去赚取吧（＾"));
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
        RewardPointsHistoryModel(
            IsSummary: true,
            Message: key,
            Points: groups[key].fold(0, (curr, next) => curr + next.Points))
      ];
      list.addAll(groups[key]);
      return list;
    }).toList();

    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: displayItems.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if ((index + 1) % response.PageSize == 0) {
          if ((response.CurrentPageIndex + 1) * response.PageSize <
              response.TotalCount) {
            _grabNextList();
          }
        }
        return _buildListItem(context, displayItems[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildListItem(
      BuildContext context, RewardPointsHistoryModel displayItem) {
    if (displayItem.IsSummary == true) {
      return ListTile(
        leading: Icon(Icons.equalizer, color: Theme.of(context).primaryColor),
        title: Text(displayItem.Message),
        contentPadding: EdgeInsets.all(2),
        trailing: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "获取：", style: AimTheme.text12Grey),
              TextSpan(
                  text: "${displayItem.Points}", style: AimTheme.text16Red),
            ],
          ),
        ),
      );
    } else {
      return ListTile(
        title: Text(displayItem.Message),
        subtitle: Text(DateFormat('y-MM-dd')
            .format(Utils.fromAspDateTimeTicks(displayItem.CreatedOnUtc))),
        trailing: Text("${displayItem.Points}"),
      );
    }
  }
}
