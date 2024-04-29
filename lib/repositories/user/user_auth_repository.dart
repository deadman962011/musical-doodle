import 'dart:convert';
import 'package:csh_app/models/responses/user/user_complete_register_response.dart';
import 'package:csh_app/models/responses/user/user_login_validate_response.dart';
import 'package:csh_app/models/responses/user/user_login_response.dart';
import 'package:csh_app/models/responses/user/user_register_validate_response.dart';
import 'package:csh_app/models/responses/validation_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

class UserAuthRepository {
  Future<dynamic> getUserAuthenticateResponse(@required String email) async {
    var post_body = jsonEncode({"email": "${email}"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 200) {
      return userLoginResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserValidateMagicLinkResponse(
      @required String token, @required String action) async {
    var post_body = jsonEncode({"token": token, "action": action});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/validate");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (action == 'verifyUserLogin') {
        return userValidateloginResponseFromJson(response.body);
      } else if (action == 'verifyUserRegister') {
        return userValidateRegisterResponseFromJson(response.body);
      }
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserCompleteRegisterResponse(
    @required String email,
    @required String first_name,
    @required String last_name,
    @required String gender,
    @required String birth_date,
    String referral_code,
  ) async {
    var post_body = jsonEncode({
      "email": email,
      "first_name": first_name,
      'last_name': last_name,
      "birth_date": birth_date,
      "gender": gender,
      "referral_code": referral_code,
    });
    debugPrint(post_body.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/register/complete");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 201) {
      return userCompleteRegisterResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
