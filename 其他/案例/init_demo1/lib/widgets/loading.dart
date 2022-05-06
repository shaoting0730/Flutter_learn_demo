import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/widgets/loading.gif',
            fit: BoxFit.contain,
            width: 200,
          ),
          const Text('正在加载中'),
        ],
      ),
    );
  }
}
