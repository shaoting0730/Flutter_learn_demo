import 'package:get/get.dart';
import 'package:init_demo1/pages/two_page/two_page.dart';
import '../pages/one_page/one_page.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/two_page/two_details_page/two_details_page.dart';
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
      binding: SplashPageBinding(),
      children: [
        GetPage(
          name: AppRoutes.ONE,
          page: () => const OnePage(),
          binding: SplashPageBinding(),
        ),
        GetPage(
          name: AppRoutes.TWO,
          page: () => const TwoPage(),
          binding: SplashPageBinding(),
          children: [
            GetPage(
              name: AppRoutes.TWODETAILS,
              page: () => const TwoDetailsPage(),
              binding: SplashPageBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
