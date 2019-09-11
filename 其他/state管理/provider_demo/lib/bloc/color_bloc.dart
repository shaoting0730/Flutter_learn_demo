import 'dart:async';
import 'package:flutter/material.dart';

class ColorDataBloc {
  StreamController<Color> _streamController;
  Stream<Color> _stream;
  Color _color;

  ColorDataBloc() {
    _color = Colors.red;
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  Stream<Color> get stream => _stream;
  Color get color => _color;

  changeColor() {
    _color = _color == Colors.red ? Colors.blue : Colors.red;
    _streamController.sink.add(_color);
  }

  dispose() {
    _streamController.close();
  }
}
