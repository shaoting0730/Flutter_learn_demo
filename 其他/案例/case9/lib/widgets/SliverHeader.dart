import 'dart:math';
import 'package:flutter/material.dart';

class SliverPersistentHeaderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("标题")),
        body: CustomScrollView(
          slivers: <Widget>[
            _buildBanner(),
            _buildStickyBar(),
            _buildList(),
          ],
        ));
  }

  Widget _buildBanner() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 200,
        child: Image.network(
          "http://image2.sina.com.cn/ent/s/j/p/2007-01-12/U1345P28T3D1407314F329DT20070112145144.jpg",
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 50, //收起的高度
          maxHeight: 50, //展开的最大高度
          child: Container(
            padding: EdgeInsets.only(left: 16),
            color: Colors.pink,
            alignment: Alignment.centerLeft,
            child: Text("浮动", style: TextStyle(fontSize: 18)),
          )),
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Container(
          height: 50,
          color: index % 2 == 0 ? Colors.white : Colors.black12,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("我是第${index}个item"),
        );
      },
      childCount: 30,
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
