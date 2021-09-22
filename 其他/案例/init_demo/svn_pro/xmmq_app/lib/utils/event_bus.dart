import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

/*
* 输入传递
* */
class InputValue {
  String str;
  InputValue(String str) {
    this.str = str;
  }
}

class InputValue2 {
  String str;
  InputValue2(String str) {
    this.str = str;
  }
}

class InputValue3 {
  String str;
  InputValue3(String str) {
    this.str = str;
  }
}

/*
* 通知所有界面停止loading
* */
class StopLoading {
  int num;
  StopLoading(int num) {
    this.num = num;
  }
}

/*
* 通知取消点赞
* */
class RemoveLike {
  String id;
  RemoveLike(String id) {
    this.id = id;
  }
}

// 通知点赞
class AddNewLike {
  String id;
  AddNewLike(String id) {
    this.id = id;
  }
}

/*
* 标签tag
* */
class TagEvent {
  List<String> list;
  int num;
  TagEvent(List<String> list, int num) {
    this.list = list; // 标签数据
    this.num = num; // 标签下标
  }
}

/*
* 首页的筛选 取消选中
* */
class CancelSelect {
  bool tag;
  CancelSelect(bool tag) {
    this.tag = tag;
  }
}

/*
* 订单的筛选 清空选中
* */
class CancelOrderSelect {
  int num;
//  String str;
  CancelOrderSelect(int num) {
    this.num = num;
  }
}

/*
* 订单的全选 选中
* */
class OrderAllSelect {
  bool tag;
  OrderAllSelect(bool tag) {
    this.tag = tag;
  }
}

/*
* 返回上一页 请求新数据
* */
class ReturnPreviousPage {
  List list;
  ReturnPreviousPage(List list) {
    this.list = list;
  }
}

/*
* 购物墙开始loading
* */
class StartLoading {
  bool tag;
  StartLoading(bool tag) {
    this.tag = tag;
  }
}

/*
* 是否点击了选择按钮（显示发布 合并 下架）
* */
class IsPicWall {
  bool tag;
  IsPicWall(bool tag) {
    this.tag = tag;
  }
}

/*
* 评论开关
* */
class DisableComment {
  int tag;
  DisableComment(int tag) {
    this.tag = tag;
  }
}

/*
*  进入购物墙
* */
class GoPicWall {
  bool tag;
  GoPicWall(bool tag) {
    this.tag = tag;
  }
}

/*
*  修改type  1： 视频  2：图片  0：全部
* */
class ChangeType {
  int tag;
  ChangeType(int tag) {
    this.tag = tag;
  }
}

/*
 * 购物车取消选择
 * */
class WallCancelSelect {
  bool tag;
  WallCancelSelect(bool tag) {
    this.tag = tag;
  }
}

/*
* 价格
* */

class InputPrice {
  String str;
  InputPrice(String str) {
    this.str = str;
  }
}

/*
* 低价格
* */

class MinInputPrice {
  String str;
  MinInputPrice(String str) {
    this.str = str;
  }
}

/*
* 高价格
* */

class MaxInputPrice {
  String str;
  MaxInputPrice(String str) {
    this.str = str;
  }
}

/*
*   商品名称
* */

class ProductName {
  String str;
  ProductName(String str) {
    this.str = str;
  }
}

/*
*   价格类型
* */

class RadioValue {
  String str;
  RadioValue(String str) {
    this.str = str;
  }
}
