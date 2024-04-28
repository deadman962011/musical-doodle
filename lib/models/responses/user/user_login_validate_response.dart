// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

UserValidateLoginResponse userValidateloginResponseFromJson(String str) => UserValidateLoginResponse.fromJson(json.decode(str));

class UserValidateLoginResponse {
  UserValidateLoginResponse({
    required this.success,
   required this.payload
  });

  bool success;
  Map<String,dynamic> payload;

  factory UserValidateLoginResponse.fromJson(Map<String, dynamic> json) => UserValidateLoginResponse(
    success: json["success"],
   payload: json['payload']
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "payload": payload
  };
}

