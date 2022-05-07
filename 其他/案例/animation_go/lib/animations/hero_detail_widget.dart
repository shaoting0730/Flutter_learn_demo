import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HeroDetailWidget extends StatefulWidget {
  final String path;
  const HeroDetailWidget({Key? key, required this.path}) : super(key: key);

  @override
  State<HeroDetailWidget> createState() => _HeroDetailWidgetState();
}

class _HeroDetailWidgetState extends State<HeroDetailWidget> {
  @override
  void initState() {
    super.initState();
    // timeDilation = 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: widget.path,
            child: Image.asset(
              widget.path,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Text('详情详情详情详情详情详情详情详情详情详情详情详情详情\n详情详情详情详情详情详情详情详情详情详情详情详情')
        ],
      ),
    );
  }
}
