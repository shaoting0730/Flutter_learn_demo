import 'package:flutter/cupertino.dart';
import 'change_notifier_provider.dart';

///响应数据变化的消费者
class NotifyConsumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;
  const NotifyConsumer({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}
