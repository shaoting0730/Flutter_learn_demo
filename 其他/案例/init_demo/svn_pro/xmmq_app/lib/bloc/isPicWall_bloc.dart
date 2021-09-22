import 'dart:async';

class IsPicWallBloc {
  StreamController<bool> _streamController;
  Stream<bool> _stream;
  bool _isPicWall;

  IsPicWallBloc() {
    _isPicWall = false;
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
  }

  Stream<bool> get stream => _stream;
  bool get isPicWall => _isPicWall;

  changePicWallTag(bool tag) async {
    _isPicWall = tag;
    _streamController.sink.add(_isPicWall);
  }

  dispose() {
    _streamController.close();
  }
}
