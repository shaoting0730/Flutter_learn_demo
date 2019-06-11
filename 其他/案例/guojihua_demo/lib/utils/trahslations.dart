import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
/// 自定义的Translations类
class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    if(_localizedValues==null) {
      return "no locale";
    }
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
   String lang =  sp.get("lang");
   if(lang==null) {
     lang = "zh";
   }
   print('zh:$lang');
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_$lang.json");
    _localizedValues = json.decode(jsonContent);
    applic.shouldReload = false;
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

/// 自定义的localization代表，它的作用是在验证支持的语言前，初始化我们的自定义Translations类
class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  /// 改这里是为了不硬编码支持的语言
  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale)=> Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

/// Delegate类的实现，每次选择一种新的语言时，强制初始化一个新的Translations类
class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {

    return applic.shouldReload??false;
  }
}

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  // 支持的语言列表
  final List<String> supportedLanguages = ['en','zh'];

  // 支持的Locales列表
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  // 当语言改变时调用的方法
  LocaleChangeCallback onLocaleChanged;

  bool shouldReload;

  ///
  /// Internals
  ///
  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC(){
    return _applic;
  }

  APPLIC._internal();
}

APPLIC applic = new APPLIC();