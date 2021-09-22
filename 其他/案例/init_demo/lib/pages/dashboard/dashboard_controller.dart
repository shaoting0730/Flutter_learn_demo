import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  var tag = '2';

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  void updateTag(String str) {
    tag = str;
    update();
  }
}
