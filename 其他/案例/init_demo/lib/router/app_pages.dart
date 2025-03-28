import 'package:get/get.dart';
import 'package:init_demo/pages/account/account_page.dart';
import 'package:init_demo/pages/account/second/second_page.dart';
import 'package:init_demo/pages/dashboard/dashboard_binding.dart';
import 'package:init_demo/pages/dashboard/dashboard_page.dart';
import 'package:init_demo/pages/home/home_page.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
        name: AppRoutes.ACCOUNT,
        page: () => const AccountPage(),
        children: [
          GetPage(
            name: AppRoutes.SECOND,
            page: () => const SecondPage(),
          ),
        ]),
  ];
}
