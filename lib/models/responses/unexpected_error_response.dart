import 'dart:convert';

UnexpectedErrorResponse unexpectedErrorResponseFromJson(String str) =>
    UnexpectedErrorResponse.fromJson(json.decode(str));

String validationResponseToJson(UnexpectedErrorResponse data) =>
    json.encode(data.toJson());

class UnexpectedErrorResponse {
  UnexpectedErrorResponse({
    required this.message,
  });

  String message;

  factory UnexpectedErrorResponse.fromJson(Map<String, dynamic> json) =>
      UnexpectedErrorResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
