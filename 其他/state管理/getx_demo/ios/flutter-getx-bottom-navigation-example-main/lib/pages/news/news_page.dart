import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/news/news_controller.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "News Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
