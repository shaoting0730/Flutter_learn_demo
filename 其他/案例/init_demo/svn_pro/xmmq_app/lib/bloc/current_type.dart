/*
* 当前类型 0 默认  1视频   2照片
* */
import 'dart:async';

class CurrentTypeBloc {
  StreamController<int> _streamController;
  Stream<int> _stream;
  int _currentType;

  CurrentTypeBloc() {
    _currentType = 0;
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
  }

  Stream<int> get stream => _stream;
  int get currentType => _currentType;

  changeCurrentType(int tag) async {
    _currentType = tag;
    _streamController.sink.add(_currentType);
  }

  dispose() {
    _streamController.close();
  }
}
