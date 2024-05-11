import 'dart:convert';

UserProfileUploadImageResponse userProfileUploadImageResponseFromJson(
        String str) =>
    UserProfileUploadImageResponse.fromJson(json.decode(str));

class UserProfileUploadImageResponse {
  UserProfileUploadImageResponse({required this.success, required this.path});

  bool success;
  String path;

  factory UserProfileUploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileUploadImageResponse(
          success: json["success"], path: json['path']);

  Map<String, dynamic> toJson() => {"success": success, "path": path};
}
