import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  addCounter() {
    _count++;
    notifyListeners();
  }

  subCounter() {
    _count--;
    notifyListeners();
  }
}
