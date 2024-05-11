import 'dart:convert';

FileUploadResponse fileUploadResponseFromJson(String str) =>
    FileUploadResponse.fromJson(json.decode(str));

class FileUploadResponse {
  FileUploadResponse(
      {required this.success, required this.path, required this.id});

  bool success;
  int id;
  String path;

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      FileUploadResponse(
          success: json["success"],
          id: json['payload']['id'],
          path: json['payload']['path']);

  Map<String, dynamic> toJson() => {"success": success, "id": id, "path": path};
}
