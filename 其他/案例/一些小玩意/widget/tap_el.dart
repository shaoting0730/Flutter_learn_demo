import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RLTap extends StatelessWidget {
  RLTap({
    required this.child,
    this.onTap,
    this.onAsyncTap,
    super.key,
  });

  /// 子组件
  final Widget child;

  /// 点击事件
  final VoidCallback? onTap;

  /// 异步点击事件 自动限制重复点击
  final AsyncCallback? onAsyncTap;

  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        if (onAsyncTap != null) {
          if (_isEnabled) {
            _isEnabled = false;
            onAsyncTap!().then((_) {
              _isEnabled = true;
            });
          }
        } else {
          onTap?.call();
        }
      },
    );
  }
}
