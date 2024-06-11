import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';

class BoxDecorations {
  static BoxDecoration buildBoxDecoration(
      {double radius = 6.0, double blurRadius = 20}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: blurRadius,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 0.0), // shadow direction: bottom right
        )
      ],
    );
  }

  static BoxDecoration buildBoxDecoration2({double radius = 6.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: const Color.fromARGB(255, 236, 236, 236),
      // Colors.grey.shade200
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 10.0), // shadow direction: bottom right
        )
      ],
    );
  }

  static BoxDecoration buildBoxDecoration_1({double radius = 6.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      border: Border.all(width: 0.2, color: Colors.black.withOpacity(.24)),
      boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(.24), //color: Colors.black.withOpacity(.24),
          blurRadius: 6,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 0.0), // shadow direction: bottom right
        )
      ],
    );
  }

  static BoxDecoration buildBoxDecoration_2({double radius = 6.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: MyTheme.background_item_color,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 8.0), // shadow direction: bottom right
        )
      ],
    );
  }

  static BoxDecoration buildCartCircularButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: const Color.fromRGBO(229, 241, 248, 1),
    );
  }

  static BoxDecoration buildCircularButtonDecoration_1() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(36.0),
      color: Colors.white.withOpacity(.80),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 10.0), // shadow direction: bottom right
        )
      ],
    );
  }
}
