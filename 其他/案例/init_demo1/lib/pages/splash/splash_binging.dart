import 'package:get/get.dart';
import '../../service/ServiceProvider.dart';
import '../dashboard/dashboard_controller.dart';
import '../one_page/one_page_controller.dart';
import '../two_page/two_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<OnePageController>(() => OnePageController());
    Get.lazyPut<TwoPageController>(() => TwoPageController());
    // Get.lazyPut<OneProvider>(() => OneProvider());
  }
}
