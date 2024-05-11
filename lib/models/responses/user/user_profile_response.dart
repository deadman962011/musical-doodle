import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

class UserProfileResponse {
  UserProfileResponse({required this.success, required this.payload});

  bool success;
  Map<String, dynamic> payload;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(success: json["success"], payload: json['payload']);

  Map<String, dynamic> toJson() => {"success": success, "payload": payload};
}
