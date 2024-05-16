import 'dart:convert';
import 'package:com.mybill.app/models/responses/user/user_complete_register_response.dart';
import 'package:com.mybill.app/models/responses/user/user_login_validate_response.dart';
import 'package:com.mybill.app/models/responses/user/user_login_response.dart';
import 'package:com.mybill.app/models/responses/user/user_profile_response.dart';
import 'package:com.mybill.app/models/responses/user/user_profile_update_response.dart';
import 'package:com.mybill.app/models/responses/user/user_profile_upload_image_response.dart';
import 'package:com.mybill.app/models/responses/user/user_register_validate_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
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
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
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

  Future<dynamic> getUserProfileResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/profile");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    if (response.statusCode == 200) {
      return userProfileResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserProfileUpdateResponse(
    @required String first_name,
    @required String last_name,
    @required String gender,
    @required String birth_date,
  ) async {
    var post_body = jsonEncode({
      "first_name": first_name,
      'last_name': last_name,
      "birth_date": birth_date,
      "gender": gender,
    });
    debugPrint(post_body);
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/profile");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 200) {
      return userProfileUpdateResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserProfileUpdateImageResponse(
      @required String image, @required String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/profile/update-image");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);
    if (response.statusCode == 200) {
      return userProfileUploadImageResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
