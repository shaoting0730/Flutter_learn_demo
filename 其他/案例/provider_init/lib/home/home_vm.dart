/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-11-02 16:29:16
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-11-02 16:40:03
 * @FilePath: /provider_init/lib/home/home_vm.dart
 * @Description: 逻辑
 */

import 'package:flutter/material.dart';

class HomeVM extends ChangeNotifier{
  int num = 0;
 

  void add(){
    num++;
    notifyListeners();
  }

  void minus(){
    num--;
    notifyListeners();
  }

}