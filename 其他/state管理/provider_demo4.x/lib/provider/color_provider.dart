import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _color = Colors.red;

  Color get color => _color;

  changeColor() {
    _color = _color == Colors.red ? Colors.blue : Colors.red;
    notifyListeners();
  }
}
