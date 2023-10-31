/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-10-30 19:26:21
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-10-31 11:24:15
 * @FilePath: /sliver_three_three/lib/sliver_tip/decorated_sliver_tip.dart
 * @Description: DecoratedSliver示例
 */
import 'package:flutter/material.dart';

class DecoratedSliverTip extends StatefulWidget {
  const DecoratedSliverTip({super.key});

  @override
  State<DecoratedSliverTip> createState() => _DecoratedSliverTipState();
}

class _DecoratedSliverTipState extends State<DecoratedSliverTip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DecoratedSliverTip'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF111133),
                    blurRadius: 2,
                    offset: Offset(-2, -1),
                  )
                ],
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFFEEEEEE),
                    Color(0xFF111133),
                  ],
                  stops: <double>[0.1, 1.0],
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'DecoratedSliver-$index',
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                    childCount: 128),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
