import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class CuSVGAPlayerWidget extends StatefulWidget {
  @override
  _CuSVGAPlayerWidgetState createState() => _CuSVGAPlayerWidgetState();
}

class _CuSVGAPlayerWidgetState extends State<CuSVGAPlayerWidget>
    with SingleTickerProviderStateMixin {
  late SVGAAnimationController animationController;

  @override
  void initState() {
    this.animationController = SVGAAnimationController(vsync: this);
    this.loadAnimation();
    super.initState();
  }

  @override
  void dispose() {
    this.animationController.dispose();
    super.dispose();
  }

  void loadAnimation() async {
    final videoItem = await SVGAParser.shared.decodeFromURL(
        "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/EmptyState.svga");
    this.animationController.videoItem = videoItem;
    this
        .animationController
        .repeat() // Try to use .forward() .reverse()
        .whenComplete(() => this.animationController.videoItem = null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SVGAImage(this.animationController),
    );
  }
}
