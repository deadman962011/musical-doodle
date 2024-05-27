import 'package:flutter/material.dart';

class LangConfig {
  static const langList = [
    'ar',
    'en'
  ];
  List<Locale> localList = [];

  List<Locale> supportedLocales() {
    for (var lang in langList) {
      var local = Locale(lang, '');
      localList.add(local);
    }

    return localList;
  }
}
