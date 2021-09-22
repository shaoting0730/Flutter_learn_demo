import 'package:flutter/cupertino.dart';

class NavigationHeader extends SliverPersistentHeaderDelegate {
  var _title;

  NavigationHeader(this._title);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CupertinoNavigationBar(
      middle: Text(_title,),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
