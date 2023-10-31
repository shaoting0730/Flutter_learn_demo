/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-10-30 19:26:03
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-10-31 10:42:08
 * @FilePath: /sliver_three_three/lib/sliver_tip/sliver_main_axis_group_tip.dart
 * @Description: SliverMainAxisGroup 示例
 */
import 'package:flutter/material.dart';

class SliverMainAxisGroupTip extends StatefulWidget {
  const SliverMainAxisGroupTip({super.key});

  @override
  State<SliverMainAxisGroupTip> createState() => _SliverMainAxisGroupTipState();
}

class _SliverMainAxisGroupTipState extends State<SliverMainAxisGroupTip> {
  var data = [
    {
      'title': 'One',
      'content': ['1个人', '1只猫', '1条鱼', '一只哈士奇']
    },
    {
      'title': 'Two',
      'content': ['2根烤肠', '2枚核弹', '2+2=4', '2只羚羊', '2只哈士奇']
    },
    {
      'title': 'Three',
      'content': ['3只松鼠', '30而立、立你大爷']
    },
    {
      'title': 'Four',
      'content': [
        '46几78',
        '46278',
        '46718',
        '46478',
        '467g8',
        '467l8',
        '46a78',
        '41678',
        '4566767676678',
        '46ppp78',
        '46dghf78',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678',
        '4678'
      ]
    },
    {
      'title': 'Five',
      'content': ['5松打虎', '54321']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverMainAxisGroupTip'),
      ),
      body: CustomScrollView(
        slivers: data.map(_buildGroup).toList(),
      ),
    );
  }

  Widget _buildGroup(data) {
    return SliverMainAxisGroup(slivers: [
      SliverPersistentHeader(
        pinned: true,
        delegate: HeaderDelegate(data['title']),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => _buildItemByUser(data['content'][index]),
          childCount: data['content'].length,
        ),
      ),
    ]);
  }

  Widget _buildItemByUser(String content) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 10.0),
            child: FlutterLogo(size: 30),
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  const HeaderDelegate(this.title);

  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.centerLeft,
      color: const Color(0xffF6F6F6),
      padding: const EdgeInsets.only(left: 20),
      height: 40,
      child: Text(title),
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant HeaderDelegate oldDelegate) =>
      title != oldDelegate.title;
}
