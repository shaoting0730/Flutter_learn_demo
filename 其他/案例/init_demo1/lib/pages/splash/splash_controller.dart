import 'package:get/get.dart';
import 'package:init_demo1/pages/dashboard/dashboard_page.dart';

class SplashPageController extends GetxController {
  var title = ''.obs;

  @override
  void onReady() {
    super.onReady();

    Get.off(
      () => const DashboardWidget(),
    );
  }
}
