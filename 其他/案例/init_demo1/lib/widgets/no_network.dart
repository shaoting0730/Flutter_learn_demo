import 'package:flutter/material.dart';

class NoNetworkWidget extends StatelessWidget {
  final String error;
  const NoNetworkWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/widgets/noNetwork.png',
            width: 50,
          ),
          Text('网络出错了:$error'),
        ],
      ),
    );
  }
}
