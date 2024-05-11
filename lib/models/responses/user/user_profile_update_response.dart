import 'dart:convert';

UserProfileUpdateResponse userProfileUpdateResponseFromJson(String str) =>
    UserProfileUpdateResponse.fromJson(json.decode(str));

class UserProfileUpdateResponse {
  UserProfileUpdateResponse({
    required this.success,
  });

  bool success;

  factory UserProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileUpdateResponse(success: json["success"]);

  Map<String, dynamic> toJson() => {"success": success};
}
