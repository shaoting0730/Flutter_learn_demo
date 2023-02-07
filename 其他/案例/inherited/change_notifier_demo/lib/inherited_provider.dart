import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  final T data;
  const InheritedProvider({super.key, required this.data, required Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的 didChangeDependencies
    return true;
  }
}
