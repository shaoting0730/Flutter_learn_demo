import 'package:get/get.dart';
import 'package:init_demo1/pages/splash/splash_controller.dart';
import '../../service/ServiceProvider.dart';
import '../dashboard/dashboard_controller.dart';
import '../one_page/one_page_controller.dart';
import '../two_page/two_details_page/two_details_controller.dart';
import '../two_page/two_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashPageController>(() => SplashPageController());

    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<OnePageController>(() => OnePageController());
    Get.lazyPut<TwoPageController>(() => TwoPageController());

    Get.lazyPut<TwoDetailsPageController>(() => TwoDetailsPageController());

    // Get.lazyPut<OneProvider>(() => OneProvider());
  }
}
