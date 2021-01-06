import 'dart:async';

class CounterBloc {
  StreamController<int> _streamController;
  Stream<int> _stream;
  int _count;

  CounterBloc() {
    _count = 0;
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
  }

  Stream<int> get stream => _stream;
  int get count => _count;

  addCounter() {
    _streamController.sink.add(++_count);
  }

  subCounter() {
    _streamController.sink.add(--_count);
  }

  dispose() {
    _streamController.close();
  }
}
