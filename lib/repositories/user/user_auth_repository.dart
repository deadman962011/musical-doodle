import 'dart:convert';
import 'package:com.mybill.app/models/responses/unexpected_error_response.dart';
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
    var postBody = jsonEncode({"email": email});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth");

    try {
      final response = await http.post(url,
          headers: {
            'Accept': 'application/json',
            "Content-Type": "application/json",
            "Accept-Language": app_language.$,
          },
          body: postBody);
      AppConfig.alice.onHttpResponse(response, body: postBody);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 && responseBody['success']) {
        return userLoginResponseFromJson(response.body);
      } else if (response.statusCode == 422) {
        return validationResponseFromJson(response.body);
      } else {
        return unexpectedErrorResponseFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getUserValidateMagicLinkResponse(
      @required String token, @required String action) async {
    var postBody = jsonEncode({"token": token, "action": action});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/validate");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: postBody);

    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success']) {
      if (action == 'verifyUserLogin') {
        return userValidateloginResponseFromJson(response.body);
      } else if (action == 'verifyUserRegister') {
        return userValidateRegisterResponseFromJson(response.body);
      }
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }

  Future<dynamic> getUserCompleteRegisterResponse(
    @required String email,
    @required String firstName,
    @required String lastName,
    @required String gender,
    @required String birthDate,
    String referralCode,
  ) async {
    var postBody = jsonEncode({
      "email": email,
      "first_name": firstName,
      'last_name': lastName,
      "birth_date": birthDate,
      "gender": gender,
      "referral_code": referralCode,
    });
    debugPrint(postBody.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/register/complete");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: postBody);

    debugPrint(response.body);
    AppConfig.alice.onHttpResponse(response, body: postBody);
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
    AppConfig.alice.onHttpResponse(response, body: null);
    if (response.statusCode == 200) {
      return userProfileResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserProfileUpdateResponse(
    @required String firstName,
    @required String lastName,
    @required String gender,
    @required String birthDate,
  ) async {
    var postBody = jsonEncode({
      "first_name": firstName,
      'last_name': lastName,
      "birth_date": birthDate,
      "gender": gender,
    });
    debugPrint(postBody);
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/profile");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);

    debugPrint(response.body);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    if (response.statusCode == 200) {
      return userProfileUpdateResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserProfileUpdateImageResponse(
      @required String image, @required String filename) async {
    var postBody = jsonEncode({"image": image, "filename": filename});
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/auth/profile/update-image");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    if (response.statusCode == 200) {
      return userProfileUploadImageResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
