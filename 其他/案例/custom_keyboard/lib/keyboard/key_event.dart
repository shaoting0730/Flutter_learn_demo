class KeyDownEvent {
  ///  当前点击的按钮所代表的值
  String key;

  KeyDownEvent(this.key);

  bool isClose() => key == "close";
}
