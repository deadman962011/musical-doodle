import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

class MyTheme{
  /*configurable colors stars*/
  static Color accent_color =  const Color.fromRGBO(84, 38, 222, 1) ;
  static Color accent_color_shadow = Color.fromRGBO(156, 135, 219, 1); // this color is a dropshadow of
  static Color soft_accent_color = Color.fromRGBO(254,234,209, 1);
  static Color splash_screen_color = Color.fromRGBO(84, 38, 222, 1); // if not sure , use the same color as accent color
  static Color background_color = Color.fromRGBO(255,255,255, 1);
  static Color warning_color = Color.fromRGBO(255,200,114, 1);
  static Color background_item_color = Color.fromRGBO(236, 236, 236, 1);
  /*configurable colors ends*/
  // background: rgba(255, 200, 114, 1);

  /*If you are not a developer, do not change the bottom colors*/
  static Color white = Color.fromRGBO(255,255,255, 1);
  static Color noColor = Color.fromRGBO(255,255,255, 0);
  static Color light_grey = Color.fromRGBO(239,239,239, 1);
  static Color dark_grey = Color.fromRGBO(107,115,119, 1);
  static Color medium_grey = Color.fromRGBO(167,175,179, 1);
  static Color medium_grey_50 = Color.fromRGBO(167,175,179, .5);
  static Color grey_153 = Color.fromRGBO(153,153,153, 1);
  static Color dark_font_grey = Color.fromRGBO(62,68,71, 1);
  static Color font_grey = Color.fromRGBO(107,115,119, 1);
  static Color textfield_grey = Color.fromRGBO(209,209,209, 1);
  static Color golden = Color.fromRGBO(255, 168, 0, 1);


  static Color amber = Color.fromRGBO(254, 234, 209, 1);
  static Color golden_shadow = Color.fromRGBO(255, 168, 0, .4);
  static Color green = Color.fromRGBO(0, 204, 176, 1);
  static Color red=Color.fromRGBO(239, 82, 97, 1);
  static Color box_gray=Color.fromARGB(255, 225, 225, 225);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;

  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/



}