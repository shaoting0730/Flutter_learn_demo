/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-12-04 15:19:56
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-12-04 15:22:22
 * @FilePath: /nested_scroll_view_demo/lib/sliver_header/sliver_pinned_header.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class SliverPinnedHeader extends StatelessWidget {
  final PreferredSizeWidget child;
  final Color color;

  const SliverPinnedHeader({super.key, required this.child, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverPinnedHeaderDelegate(
          child: child,
          color: color
      ),
    );
  }
}

class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;


  _SliverPinnedHeaderDelegate({required this.child, required this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return ColoredBox(
        color: color,
        child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child
    ||oldDelegate.color != color;
  }
}