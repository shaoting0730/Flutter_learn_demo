import 'package:aimoversea_admin_app/services/serviceapi.dart';
import 'package:flutter/material.dart';

import 'loginmodel.dart';

const membershipLevels = ["注册", "铂金", "星钻", "至尊"];

class AppModel extends ChangeNotifier {
  /// Internal, private state of the cart. 内部的，购物车的私有状态
  //final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart. 购物车里的商品视图无法改变
  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42). 现在全部商品的总价格（假设他们加起来 $42）
  // int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This is the only way to modify the cart from outside. 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
//  void add(Item item) {
//    _items.add(item);
//    // This call tells the widgets that are listening to this model to rebuild.
//    notifyListeners();
//  }

  BuildContext context;

  LoginResponseModel loginInfo;
  AimRevenueModel revenueSummary;
  NotifySummaryModel notifyCount;

  AppModel();

  void setContext(ctx) {
    context = ctx;
  }

  bool get isLoggedIn => loginInfo != null;

  bool get isUser =>
      isLoggedIn &&
      (loginInfo.MembershipLevel == "" ||
          loginInfo.MembershipLevel == null ||
          loginInfo.MembershipLevel == membershipLevels[0]);

  bool get isVIP =>
      isLoggedIn && loginInfo.MembershipLevel == membershipLevels[1];

  bool get isSVIP =>
      isLoggedIn && loginInfo.MembershipLevel == membershipLevels[2];

  bool get isBlackCard =>
      isLoggedIn && loginInfo.MembershipLevel == membershipLevels[3];

  String get nextLevel {
    //print("current level ${loginInfo.MembershipLevel} index: ${membershipLevels.indexOf(loginInfo.MembershipLevel)}");
    if (!isLoggedIn) return null;
    var cur = membershipLevels.indexOf(loginInfo.MembershipLevel);
    return cur >= 0 && cur < membershipLevels.length - 1
        ? membershipLevels[cur + 1]
        : null;
  }

  void updateLoginInfo(LoginResponseModel info) {
    loginInfo = info;
    notifyListeners();
  }

  void refresh(bool force) {
    if (!force && notifyCount != null) return;
    updateRevenueSummary();
    updateNotifyCount();
  }

  void updateRevenueSummary() async {
    revenueSummary = await UserServerApi().getRevenueSummary(context);
    notifyListeners();
  }

  void updateNotifyCount() async {
    notifyCount = await UserServerApi().getNotifyCount(context);
    notifyListeners();
  }
}
