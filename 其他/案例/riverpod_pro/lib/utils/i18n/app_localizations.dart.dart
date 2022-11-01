import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  // 1
  final Locale locale;

  AppLocalizations(this.locale);

  // 2
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Map<String, Map<String, String>> _localizedStrings = {};

  // 3
  Future loadJson() async {
    final jsonString = await rootBundle.loadString("assets/json/i18n.json");
    Map<String, dynamic> map = json.decode(jsonString);
    _localizedStrings = map.map((key, value) => MapEntry(key, value.cast<String, String>()));
  }

  // 4
  String? get title => _localizedStrings[locale.languageCode]!["title"];

  String? get homeTitle => _localizedStrings[locale.languageCode]!["homeTitle"];

  String? get otherTitle => _localizedStrings[locale.languageCode]!["otherTitle"];

  String? get mineTitle => _localizedStrings[locale.languageCode]!["mineTitle"];
}
