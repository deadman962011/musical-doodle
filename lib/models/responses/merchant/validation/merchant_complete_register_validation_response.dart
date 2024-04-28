// import 'dart:convert';




// MerchantCompleteRegisterValidationResponse merchantLoginValidationResponseFromJson(String str) => MerchantCompleteRegisterValidationResponse.fromJson(json.decode(str));


// String merchantValidationResponseToJson(MerchantCompleteRegisterValidationResponse data) => json.encode(data.toJson());

// class MerchantCompleteRegisterValidationResponse {
//   MerchantCompleteRegisterValidationResponse({
//     required this.message,
//     required this.errors,
//   });


//   String message;
//   Map<String,dynamic> errors;

//   factory MerchantCompleteRegisterValidationResponse.fromJson(Map<String, dynamic> json) => MerchantLoginValidationResponse(
//     message: json["message"],
//     errors: json["errors"],
//   );

//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "errors": errors,
//   };
// }