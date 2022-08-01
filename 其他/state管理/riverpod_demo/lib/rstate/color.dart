import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorProvider = StateNotifierProvider.autoDispose<ColorNotifier, Color>(
  (ref) => ColorNotifier(),
);

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier() : super(Colors.red);

  static const _colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  void changeColor() => state = _colors[Random().nextInt(_colors.length)];
}
