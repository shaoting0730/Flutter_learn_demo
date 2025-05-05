/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-05-03 20:43:02
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-05-05 11:36:35
 * @FilePath: /response_ui/lib/response_ui/desktop_layout.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:response_ui/component/aspect_ratio_widget.dart';
import 'package:response_ui/component/drawer_widget.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Desktop Layout'), backgroundColor: Colors.green),
      body: Row(
        children: [
         DrawerWidget(),
          Expanded(child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: AspectRatioWidget()),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Container(margin: const EdgeInsets.all(10), color: Colors.blue, child: Text('item $index'));
                },
              ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
