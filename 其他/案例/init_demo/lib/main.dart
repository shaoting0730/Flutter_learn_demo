import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'utils/languages.dart';
import 'router/app_pages.dart';
import 'router/app_routes.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: () => GetMaterialApp(
        navigatorKey: navigatorKey,
        translations: Languages(), // 你的翻译
        locale: const Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
        fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        initialRoute: AppRoutes.DASHBOARD,
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
