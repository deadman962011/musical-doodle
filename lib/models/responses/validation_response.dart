import 'dart:convert';




ValidationResponse validationResponseFromJson(String str) => ValidationResponse.fromJson(json.decode(str));


String validationResponseToJson(ValidationResponse data) => json.encode(data.toJson());

class ValidationResponse {
  ValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory ValidationResponse.fromJson(Map<String, dynamic> json) => ValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}