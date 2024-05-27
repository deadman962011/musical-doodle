import 'package:com.mybill.app/my_theme.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class ToastComponent {
  static showDialog(String msg, BuildContext context,
      {duration = 0, gravity = 0}) {
    ToastContext().init(context);
    Toast.show(msg,
        duration: duration != 0 ? duration : Toast.lengthShort,
        gravity: gravity != 0 ? gravity : Toast.bottom,
        backgroundColor: const Color.fromRGBO(239, 239, 239, .9),
        textStyle: TextStyle(color: MyTheme.font_grey),
        border: const Border(
            top: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            bottom: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            right: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            left: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            )),
        backgroundRadius: 6);
  }
}
