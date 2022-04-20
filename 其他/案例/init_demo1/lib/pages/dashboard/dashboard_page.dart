import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/one_page/one_page.dart';
import 'package:init_demo1/pages/two_page/two_page.dart';
import 'dashboard_controller.dart';

class DashboardWidget extends GetView<DashboardController> {
  const DashboardWidget({Key? key}) : super(key: key);

  DashboardController get sc => Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              OnePage(),
              TwoPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '第一'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: '第二'),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: sc.tabIndex,
            onTap: (index) => sc.changeTabIndex(index),
            selectedItemColor: Colors.redAccent,
          ),
        );
      },
    );
  }
}
