import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers{
  static String root = '/';
  static String detailsPage = './detail';
  static String otherPage = './other';
  static void configureRouters(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('错误路由');
      }
    );
    router.define(detailsPage,handler: detailsHandle);
    router.define(otherPage,handler: otherHandle);
  }
}