/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-11-02 16:29:16
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-11-02 16:50:46
 * @FilePath: /provider_init/lib/home/home_page.dart
 * @Description: UI
 */

import 'package:flutter/material.dart';
import 'package:provider_init/home/home_vm.dart';
import 'package:provider_init/utils/provider_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeVM _homeVM = HomeVM();

  @override
  void dispose() {
    _homeVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ProviderWidget<HomeVM>(
        autoDispose: false,
        model: _homeVM,
        builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => ref.add(),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('+'),
                ),
              ),
              Text('${ref.num}'),
              InkWell(
                onTap: () => ref.minus(),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('-'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
