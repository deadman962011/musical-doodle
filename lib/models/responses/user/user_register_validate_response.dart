// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

UserValidateRegisterResponse userValidateRegisterResponseFromJson(String str) => UserValidateRegisterResponse.fromJson(json.decode(str));

class UserValidateRegisterResponse {
  UserValidateRegisterResponse({
    required this.success,
    required this.payload
    
  });

  bool success;
  Map<String,dynamic> payload;

  factory UserValidateRegisterResponse.fromJson(Map<String, dynamic> json) => UserValidateRegisterResponse(
    success: json["success"],
    payload : json['payload']
    
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "email":payload
    
  };
}

