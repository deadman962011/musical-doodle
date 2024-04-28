import 'package:flutter/material.dart';

class LangConfig {
  static const langList = [
    'ar',
    'en'
  ];
  List<Locale> localList = [];

  List<Locale> supportedLocales() {
    langList.forEach((lang) {
      var local = Locale(lang, '');
      localList.add(local);
    });

    return localList;
  }
}
