import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ MyBill " + this_year; //this shows in the splash screen
  static String app_name = "MyBill"; //this shows in the splash screen
  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = true;

  static const bool IsDevelp = false;

  //configure this

  // static const DOMAIN_PATH = "192.168.6.1/folder"; //localhost
  //192.168.56.1
  // https://admin.mybill1.com/
  // static const DOMAIN_PATH = "192.168.43.103:8000"; // directly inside the public folder
  static const DOMAIN_PATH = IsDevelp
      ? "192.168.43.103:8000"
      : 'admin.mybill1.com'; //  http://192.168.43.103:8000/
  // 192.168.43.103
  //do not configure these below
  static const String API_ENDPATH = "api/v1";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
  // http://192.168.43.103:5000/api/v2
  // static const String BASE_URL = "http://192.168.43.103:5000/api/v2";
}
