/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-03 20:42:22
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-05 11:31:02
 * @FilePath: /response_ui/lib/response_ui/mobile_layout.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:response_ui/component/aspect_ratio_widget.dart';
import 'package:response_ui/component/drawer_widget.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Layout'), backgroundColor: Colors.red),
      drawer: const DrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: AspectRatioWidget()),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(margin: const EdgeInsets.all(10), color: Colors.blue, child: Text('item $index'));
            },
          ),
        ],
      ),
    );
  }
}
