/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-10-30 19:26:24
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-10-31 11:15:18
 * @FilePath: /sliver_three_three/lib/sliver_tip/sliver_constrained_cross_axis_tip.dart
 * @Description:SliverConstrainedCorssAxis 示例
 */
import 'package:flutter/material.dart';

class SliverConstrainedCorssAxisTip extends StatefulWidget {
  const SliverConstrainedCorssAxisTip({super.key});

  @override
  State<SliverConstrainedCorssAxisTip> createState() =>
      _SliverConstrainedCorssAxisTipState();
}

class _SliverConstrainedCorssAxisTipState
    extends State<SliverConstrainedCorssAxisTip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SliverConstrainedCorssAxis和SliverCrossAxisExpanded和SliverCrossAxisGroup',
          style: TextStyle(fontSize: 10),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverCrossAxisGroup(
            slivers: <Widget>[
              SliverConstrainedCrossAxis(
                maxExtent: 100,
                sliver: SliverColorList(
                  height: 100.0,
                  fontSize: 24,
                  count: 8,
                  color1: Colors.amber[300],
                  color2: Colors.blue[300],
                ),
              ),
              SliverCrossAxisExpanded(
                flex: 1, // tag1
                sliver: SliverColorList(
                  height: 80.0,
                  fontSize: 18,
                  count: 15,
                  color1: Colors.green[300],
                  color2: Colors.red[300],
                ),
              ),
              SliverCrossAxisExpanded(
                  flex: 2, // tag2
                  sliver: SliverColorList(
                    height: 50.0,
                    fontSize: 20,
                    count: 6,
                    color1: Colors.purple[300],
                    color2: Colors.orange[300],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class SliverColorList extends StatelessWidget {
  final double height;
  final double fontSize;
  final Color? color1;
  final Color? color2;
  final int count;
  const SliverColorList(
      {super.key,
      required this.height,
      required this.fontSize,
      required this.count,
      this.color1,
      this.color2});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven ? color1 : color2,
          height: height,
          child: Center(
            child: Text(
              'Item ${index}',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        );
      },
      itemCount: count,
    );
  }
}
