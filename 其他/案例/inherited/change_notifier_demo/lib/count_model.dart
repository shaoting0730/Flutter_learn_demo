import 'package:flutter/cupertino.dart';

///共享数据模型
class CountModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  //提供自增方法
  void increase() {
    _count++;
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}
