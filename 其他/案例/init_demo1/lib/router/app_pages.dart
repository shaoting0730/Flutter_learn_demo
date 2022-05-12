import 'package:get/get.dart';
import '../pages/splash/splash_binging.dart';
import 'app_routes.dart';

import '../pages/dashboard/dashboard_page.dart';
import '../pages/splash/splash_page.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardWidget(),
    ),
  ];
}
