import 'package:flutter/material.dart';
import 'package:state_example/change_notifier_example.dart';

class ChangeNotifierProvider<T extends Listenable> extends StatefulWidget {
  final Widget child;
  final T Function() create;

  const ChangeNotifierProvider({Key? key, required this.child, required this
      .create})
      : super(key: key);

  static T of<T>(BuildContext context,{required bool listen}) {
    if(listen){
      return context.dependOnInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    }else{
      return context.getInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    }
  }

  @override
  State<ChangeNotifierProvider> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends Listenable> extends
State<ChangeNotifierProvider<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (BuildContext context, Widget? child) {
        return _InheritedWidget(
          model: model,
          child: widget.child,
        );
      },
    );
  }
}

class _InheritedWidget<T> extends InheritedWidget {
  final T model;

  const _InheritedWidget(
      {super.key, required this.model, required super.child});


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

extension Consumer on BuildContext{
  T watch<T>() => ChangeNotifierProvider.of(this,listen: true);
  T read<T>() => ChangeNotifierProvider.of(this,listen: false);
}
