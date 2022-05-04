import 'package:flutter/material.dart';

class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('无网络'),
    );
  }
}
