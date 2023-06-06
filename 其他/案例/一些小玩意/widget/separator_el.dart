import 'package:flutter/material.dart';


class Separator extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;

  const Separator({
    this.height = 1,
    this.dashWidth = 2,
    this.color = const Color(0xffbbbbbb),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: ColoredBox(color: color),
            );
          }),
        );
      },
    );
  }
}
