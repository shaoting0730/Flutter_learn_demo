import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/detailspage.dart';
import '../pages/otherpaage.dart';

Handler detailsHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String paramsId = params['id'].first;
  return DetailsPage(paramsId);
});

Handler otherHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OtherPage();
});