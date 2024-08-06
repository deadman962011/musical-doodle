import 'package:flutter/material.dart';

class MyTheme {
  /*configurable colors stars*/
  static Color accent_color = const Color.fromRGBO(74, 255, 177, 1);
  static Color accent_color_shadow =
      Color.fromARGB(255, 151, 255, 210); // this color is a dropshadow of
  static Color soft_accent_color = const Color.fromRGBO(254, 234, 209, 1);
  static Color splash_screen_color = const Color.fromRGBO(
      255, 255, 255, 1); // if not sure , use the same color as accent color
  static Color background_color = const Color.fromRGBO(255, 255, 255, 1);
  static Color warning_color = const Color.fromRGBO(255, 200, 114, 1);
  static Color background_item_color = const Color.fromRGBO(236, 236, 236, 1);
  /*configurable colors ends*/
  // background: rgba(255, 200, 114, 1);

  /*If you are not a developer, do not change the bottom colors*/
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color noColor = const Color.fromRGBO(255, 255, 255, 0);
  static Color light_grey = const Color.fromRGBO(239, 239, 239, 1);
  static Color dark_grey = const Color.fromRGBO(107, 115, 119, 1);
  static Color medium_grey = const Color.fromRGBO(167, 175, 179, 1);
  static Color medium_grey_50 = const Color.fromRGBO(167, 175, 179, .5);
  static Color grey_153 = const Color.fromRGBO(153, 153, 153, 1);
  static Color dark_font_grey = const Color.fromRGBO(62, 68, 71, 1);
  static Color font_grey = const Color.fromRGBO(107, 115, 119, 1);
  static Color textfield_grey = const Color.fromRGBO(209, 209, 209, 1);
  static Color golden = const Color.fromRGBO(255, 168, 0, 1);

  static Color amber = const Color.fromRGBO(254, 234, 209, 1);
  static Color golden_shadow = const Color.fromRGBO(255, 168, 0, .4);
  static Color green = const Color.fromRGBO(0, 204, 176, 1);
  static Color red = const Color.fromRGBO(239, 82, 97, 1);
  static Color box_gray = const Color.fromARGB(255, 225, 225, 225);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;
  static Color divider_color = const Color.fromRGBO(201, 201, 201, 1);

  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/
}
