import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model{
  int _count = 0;
  get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }

  MainModel of(context) =>
      ScopedModel.of<MainModel>(context);
}
