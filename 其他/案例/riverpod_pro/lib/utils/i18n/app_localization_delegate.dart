import 'package:flutter/material.dart';
import 'package:fruit/utils/i18n/app_localizations.dart.dart';

class APPLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  // 1.
  static APPLocalizationDelegate delegate = APPLocalizationDelegate();

  // 2.
  @override
  bool isSupported(Locale locale) {
    return ["en", "zh", "he"].contains(locale.languageCode);
  }

  // 3
  @override
  Future<AppLocalizations> load(Locale locale) async {
    final appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadJson();
    return appLocalizations;
  }

  // 4
  @override
  bool shouldReload(APPLocalizationDelegate old) {
    return false;
  }
}
