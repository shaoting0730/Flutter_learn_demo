import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/splash/splash_binging.dart';
import 'package:init_demo1/pages/splash/splash_page.dart';
import 'package:init_demo1/pages/two_page/two_page.dart';
import 'package:init_demo1/pages/one_page/one_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          binding: SplashPageBinding(),
          page: () => const SplashPage(),
          children: [
            GetPage(
              name: '/one',
              page: () => const OnePage(),
            ),
            GetPage(
              name: '/two',
              page: () => const TwoPage(),
            ),
          ],
        ),
      ],
    );
  }
}
