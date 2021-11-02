import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CuLottieWidget extends StatefulWidget {
  const CuLottieWidget({Key? key}) : super(key: key);

  @override
  _CuLottieWidgetState createState() => _CuLottieWidgetState();
}

class _CuLottieWidgetState extends State<CuLottieWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.network(
        "https://cdn.jsdelivr.net/gh/johnson8888/blog_pages/images/lottie_test.json",
      ),
    );
  }
}
