import 'package:flutter/material.dart';
import 'package:init_demo/config/constant.dart';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: ListView(
        children: [
          Text(
            'hello'.tr,
            style: const TextStyle(fontSize: 20),
          ),
          RadioListTile(
            value: '中文',
            groupValue: controller.lgroupValue.toString(),
            title: const Text('中文'),
            onChanged: (type) {
              var locale = const Locale('zh', 'CN');
              Get.updateLocale(locale);
              controller.changeValue('中文');
            },
          ),
          RadioListTile(
            value: '英文',
            groupValue: controller.lgroupValue.toString(),
            title: const Text('英文'),
            onChanged: (type) {
              var locale = const Locale('en', 'US');
              Get.updateLocale(locale);
              controller.changeValue('英文');
            },
          ),
          const Text(CONSTANT.name),
          Text(
            convert.jsonEncode(CONSTANT.info),
          ),
        ],
      ),
    );
  }
}
