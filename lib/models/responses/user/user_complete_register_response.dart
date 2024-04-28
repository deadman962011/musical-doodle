import 'dart:convert';

UserCompleteRegisterResponse userCompleteRegisterResponseFromJson(String str) => UserCompleteRegisterResponse.fromJson(json.decode(str));

class UserCompleteRegisterResponse {
  UserCompleteRegisterResponse({
    required this.success,
    required this.payload
  });

  bool success;
  Map<String,dynamic> payload;

  factory UserCompleteRegisterResponse.fromJson(Map<String, dynamic> json) => UserCompleteRegisterResponse(
    success: json["success"],
    payload:json['payload']
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "payload":payload
  };
}

