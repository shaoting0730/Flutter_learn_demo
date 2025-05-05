```

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({super.key, required this.mobile, this.tablet, this.desktop});

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1024 && MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1024) {
      return desktop!;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

```
![image](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/response_ui/result.gif) <br/>
