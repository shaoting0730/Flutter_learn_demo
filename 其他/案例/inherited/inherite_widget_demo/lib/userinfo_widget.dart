import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import './user_bean.dart';

class UserInfoInheritedWidget extends InheritedWidget {
  UserBean userBean;
  Function updateInfo;

  UserInfoInheritedWidget(
      {this.userBean, Key key, Widget child, this.updateInfo})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(UserInfoInheritedWidget oldWidget) {
    return oldWidget.userBean != userBean;
  }

  void updateUserBean(String name, String address) {
    updateInfo(name, address);
  }
}

class UserInfoWidget extends StatefulWidget {
  UserBean userbean;
  Widget child;

  UserInfoWidget({this.userbean, Key key, this.child}) : super(key: key);

  static UserInfoInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserInfoInheritedWidget>();
  }

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  void _update(String name, String address) {
    setState(() {
      widget.userbean.name = name;
      widget.userbean.address = address;
      widget.userbean = UserBean(name: name, address: address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoInheritedWidget(
      userBean: widget.userbean,
      child: widget.child,
      updateInfo: _update,
    );
  }
}
