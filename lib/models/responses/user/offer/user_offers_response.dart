import 'dart:convert';

import 'package:csh_app/models/items/Offer.dart';

UserOffersResponse userOffersResponseFromJson(String str) =>
    UserOffersResponse.fromJson(json.decode(str));

class UserOffersResponse {
  UserOffersResponse({
    required this.offers,
    required this.success,
  });

  List<Offer> offers;
  bool success;

  factory UserOffersResponse.fromJson(Map<String, dynamic> json) =>
      UserOffersResponse(
        success: json["success"],
        offers: List<Offer>.from(
            json["payload"]['data'].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"success": success, "offers": offers};
}
