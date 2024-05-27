import 'dart:io';
import 'package:com.mybill.app/generated/l10n.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonFunctions {
  BuildContext context;

  CommonFunctions(this.context);

  appExitDialog() {
    showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection:
                  app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
              child: AlertDialog(
                content: Text(S.of(context).home_screen_close_app),
                actions: [
                  TextButton(
                      onPressed: () {
                        Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                      },
                      child: Text(
                        S.of(context).yes,
                        style: TextStyle(color: MyTheme.accent_color),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).no,
                          style: TextStyle(color: MyTheme.accent_color))),
                ],
              ),
            ));
  }
}
