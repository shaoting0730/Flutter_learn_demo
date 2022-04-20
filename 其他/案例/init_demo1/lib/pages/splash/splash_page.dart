import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:init_demo1/pages/splash/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);
  SplashPageController get sc => Get.put(SplashPageController());

  @override
  Widget build(BuildContext context) {
    print(sc.title.value);

    return Scaffold(
      body: WillPopScope(
        child: Stack(
          children: [
            Image.asset(
              'images/splash/splash.png',
              fit: BoxFit.cover,
              width: Get.width,
              height: Get.height,
            ),
          ],
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
