import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo/pages/account/account_page.dart';
import 'package:init_demo/pages/home/home_page.dart';
import 'package:init_demo/utils/event_bus.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  _listen() {
    // 联系人返回
    eventBus.on<NotificationTag>().listen((event) {
      Get.put(DashboardController()).updateTag(event.text);
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomePage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: PreferredSize(
            preferredSize: const Size.fromHeight(69),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top:
                      BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.changeTabIndex(0),
                      child: SizedBox(
                        height: 69.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: controller.tabIndex == 0
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            Text(
                              'one'.tr,
                              style: TextStyle(
                                color: controller.tabIndex == 0
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.changeTabIndex(1),
                      child: Container(
                        height: 69.0,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: const FractionalOffset(2, 0.1),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: controller.tabIndex == 1
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                                Text(
                                  'two'.tr,
                                  style: TextStyle(
                                    color: controller.tabIndex == 1
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              width: 20,
                              height: 15,
                              child: Center(
                                child: Text(controller.tag),
                              ),
                            ),
                          ],
                        ),
                        // color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
