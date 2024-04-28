// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

UserLoginResponse userLoginResponseFromJson(String str) => UserLoginResponse.fromJson(json.decode(str));

class UserLoginResponse {
  UserLoginResponse({
    required this.success,
  });

  bool success;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) => UserLoginResponse(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,

  };
}

