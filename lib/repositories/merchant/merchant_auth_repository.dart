import 'dart:convert';
import 'package:csh_app/models/responses/merchant/merchant_complete_register_response.dart';
import 'package:csh_app/models/responses/merchant/merchant_login_response.dart';
import 'package:csh_app/models/responses/merchant/merchant_validate_login_response.dart';
// import 'package:csh_app/models/merchant/merchant_validate_login_response.dart';
import 'package:csh_app/models/responses/merchant/merchant_validate_register_response.dart';
import 'package:csh_app/models/responses/merchant/validation/merchant_login_validatiom_response.dart';
import 'package:csh_app/models/responses/validation_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

class MerchantAuthRepository {
  Future<dynamic> getMerchantAuthenticateResponse(
      @required String email) async {
    var post_body = jsonEncode({"email": "${email}"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 200) {
      return merchantloginResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantValidateMagicLinkResponse(
      @required String token, @required String action) async {
    var post_body = jsonEncode({"token": token, "action": action});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth/validate");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      debugPrint(response.body);
      if (action == 'verifyShopLogin') {
        return merchantValidateloginResponseFromJson(response.body);
      } else if (action == 'verifyShopRegister') {
        return merchantValidateRegisterResponseFromJson(response.body);
      }
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantCompleteRegisterResponse(
    @required String shop_name,
    @required String shop_address,
    @required String categories_ids,
    @required String tax_register,
    @required String shop_admin_name,
    @required String shop_admin_phone,
    @required String shop_admin_email,
    @required String longitude,
    @required String latitude,
    String referral_code,
  ) async {
    var post_body = jsonEncode({
      "shop_name": shop_name,
      'shop_address': shop_address,
      "categories_ids": categories_ids,
      "tax_register": tax_register,
      "shop_admin_name": shop_admin_name,
      "shop_admin_phone": shop_admin_phone,
      "shop_admin_email": shop_admin_email,
      "longitude": longitude,
      "latitude": latitude,
      "referral_code": referral_code
    });
    debugPrint(post_body.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth/register/complete");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 201) {
      return merchantCompleteRegisterResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}


//   Future<dynamic> getSignupResponse(
//     @required String name,
//     @required String phone,
//     @required String password,
//   ) async {
//     var post_body = jsonEncode({
//       "name": "$name",
//       "phone": "${phone}",
//       "password": "$password",
//     });

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/register");
//     final response = await http.post(url,
//         headers: {
//           'Accept': 'application/json',
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);
//     print(response.body);
//     if (response.statusCode == 201) {
//       return true;
//       // return signupResponseFromJson(response.body);
//     } else if (response.statusCode == 422) {
//       return signupValidationResponseFromJson(response.body);
//       // debugPrint('register response=>>>>>>>>>>> ${response.body} ');
//     }
//   }

//   Future<dynamic> getSignupVerifyResponse(
//     String name,
//     String phone,
//     String otp,
//   ) async {
//     var post_body = jsonEncode({
//       "name": "$name",
//       "phone": "${phone}",
//       "otp": "$otp",
//     });

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/register/verfiy");
//     final response = await http.post(url,
//         headers: {
//           'Accept': 'application/json',
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);
//     print(response.body);
//     if (response.statusCode == 201) {
//       return signupResponseFromJson(response.body);
//     } else {
//       false;
//     }
//   }

//   Future<dynamic> getPasswordForgetResponse(@required String phone) async {
//     var post_body = jsonEncode({"phone": "$phone"});

//     Uri url = Uri.parse(
//       "${AppConfig.BASE_URL}/auth/password/otp/request",
//     );

//     final response = await http.post(url,
//         headers: {
//           'Accept': 'application/json',
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     if (response.statusCode == 201) {
//       return true;
//       // return passwordForgetResponseFromJson(response.body);
//     } else if (response.statusCode == 422) {
//       return forgotPasswordValidationResponseFromJson(response.body);
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> getPasswordForgetVerifyResponse(
//       @required String phone, @required String otp) async {
//     var post_body = jsonEncode({"phone": "$phone", "otp": "$otp"});

//     Uri url = Uri.parse(
//       "${AppConfig.BASE_URL}/auth/password/change/request",
//     );

//     final response = await http.post(url,
//         headers: {
//           'Accept': 'application/json',
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);
//     debugPrint(response.body.toString());
//     if (response.statusCode == 201) {
//       return passwordVerifyResponseFromJson(response.body);
//     } else {
//       return false;
//     }
//   }

//   Future<dynamic> getPasswordChangeResponse(
//     @required String phone,
//     @required String token,
//     @required String password,
//     @required String password_confirmation,
//   ) async {
//     var post_body = jsonEncode({
//       "phone": "$phone",
//       "token": "$token",
//       "password": "$password",
//       "password_confirmation": "$password_confirmation"
//     });

//     Uri url = Uri.parse(
//       "${AppConfig.BASE_URL}/auth/password/change",
//     );

//     final response = await http.post(url,
//         headers: {
//           'Accept': 'application/json',
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);
//     debugPrint(response.body.toString());
//     if (response.statusCode == 201) {
//       return true;
//     }
//     else if(response.statusCode == 422){
//       return passwordChangeValidationResponseFromJson(response.body);
//     }
//     else {
//       return false;
//     }
//   }

//   Future<LogoutResponse> getLogoutResponse() async {
//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/logout");
//     final response = await http.get(
//       url,
//       headers: {
//         "Authorization": "Bearer ${access_token.$}",
//         "Accept-Language": app_language.$,
//       },
//     );

//     print(response.body);

//     return logoutResponseFromJson(response.body);
//   }

//   Future<LoginResponse> getSocialLoginResponse(@required String social_provider,
//       @required String name, @required String email, @required String provider,
//       {access_token = ""}) async {
//     email = email == ("null") ? "" : email;

//     var post_body = jsonEncode({
//       "name": "${name}",
//       "email": email,
//       "provider": "$provider",
//       "social_provider": "$social_provider",
//       "access_token": "$access_token"
//     });

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/social-login");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);
//     print(post_body);
//     print(response.body.toString());
//     return loginResponseFromJson(response.body);
//   }

//   Future<ResendCodeResponse> getResendCodeResponse(
//       @required int user_id, @required String verify_by) async {
//     var post_body =
//         jsonEncode({"user_id": "$user_id", "register_by": "$verify_by"});

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/resend_code");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     return resendCodeResponseFromJson(response.body);
//   }

//   Future<ConfirmCodeResponse> getConfirmCodeResponse(
//       @required int user_id, @required String verification_code) async {
//     var post_body = jsonEncode(
//         {"user_id": "$user_id", "verification_code": "$verification_code"});

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/confirm_code");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     return confirmCodeResponseFromJson(response.body);
//   }

//   Future<PasswordConfirmResponse> getPasswordConfirmResponse(
//       @required String verification_code, @required String password) async {
//     var post_body = jsonEncode(
//         {"verification_code": "$verification_code", "password": "$password"});

//     Uri url = Uri.parse(
//       "${AppConfig.BASE_URL}/auth/password/confirm_reset",
//     );
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     return passwordConfirmResponseFromJson(response.body);
//   }

//   Future<ResendCodeResponse> getPasswordResendCodeResponse(
//       @required String email_or_code, @required String verify_by) async {
//     var post_body = jsonEncode(
//         {"email_or_code": "$email_or_code", "verify_by": "$verify_by"});

//     Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/password/resend_code");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     return resendCodeResponseFromJson(response.body);
//   }

//   Future<UserByTokenResponse> getUserByTokenResponse() async {
//     var post_body = jsonEncode({"access_token": "${access_token.$}"});
//     Uri url = Uri.parse("${AppConfig.BASE_URL}/get-user-by-access_token");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept-Language": app_language.$,
//         },
//         body: post_body);

//     return userByTokenResponseFromJson(response.body);
//   }
// }
