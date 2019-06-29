///  支符密码  用于 密码输入框和键盘之间进行通信
class KeyEvent {
  String key;

  KeyEvent(this.key);

  bool isDelete() => this.key == "del";
  bool isCommit() => this.key == "commit";
}
