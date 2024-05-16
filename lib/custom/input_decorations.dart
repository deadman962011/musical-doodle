import 'package:com.mybill.app/custom/input_shadow_border_decoration.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/my_theme.dart';

class InputDecorations {
  static InputDecoration buildInputDecoration_1(
      {hint_text = "",
      error_text = null,
      horizontalPadding = 16.00,
      verticalPadding = 0.00}) {
    return InputDecoration(
        errorMaxLines: 3,
        hintText: hint_text,
        errorText: error_text,
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.red, width: 0.6),
          borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.red, width: 0.6),
          borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.medium_grey_50, width: 0.6),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.8),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.00,
        ));
  }

  static InputDecoration buildDropdownInputDecoration_1(
      {hint_text = "", horizontalPadding = 16.00, verticalPadding = 0.00}) {
    return InputDecoration(
        hintText: hint_text,
        filled: true,
        fillColor: MyTheme.white,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.red, width: 0.6),
          borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.red, width: 0.6),
          borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.medium_grey_50, width: 0.6),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.8),
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.00,
        ));
  }

  static InputDecoration buildInputDecoration_phone({hint_text = ""}) {
    return InputDecoration(
        hintText: hint_text,
        hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0))),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0));
  }

  static InputDecoration buildInputDecorationMobile(
      {hint_text = "", horizontalPadding = 16.00, verticalPadding = 0.00}) {
    return InputDecoration(
      isDense: true,
      hintText: hint_text,
      filled: true,
      border: OutlineInputBorder(),
      fillColor: MyTheme.white,
      hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyTheme.noColor, width: 0.2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0))),
      contentPadding: EdgeInsets.symmetric(vertical: 5),
    );
  }
}
