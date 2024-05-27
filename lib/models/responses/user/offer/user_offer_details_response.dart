// To parse this JSON data, do
//
//     final userOfferDetailsResponse = userOfferDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserOfferDetailsResponse userOfferDetailsResponseFromMap(String str) =>
    UserOfferDetailsResponse.fromMap(json.decode(str));

String userOfferDetailsResponseToMap(UserOfferDetailsResponse data) =>
    json.encode(data.toMap());

class UserOfferDetailsResponse {
  bool success;
  OfferDetailsItem payload;
  String message;

  UserOfferDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserOfferDetailsResponse.fromMap(Map<String, dynamic> json) =>
      UserOfferDetailsResponse(
        success: json["success"],
        payload: OfferDetailsItem.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class OfferDetailsItem {
  int id;
  String name;
  String description;
  String image;
  String startDate;
  String endDate;
  String cashbackAmount;
  bool isFavorite;
  int days_left;
  Shop shop;
  List<dynamic> ratings;

  OfferDetailsItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.cashbackAmount,
    required this.isFavorite,
    required this.days_left,
    required this.shop,
    required this.ratings,
  });

  factory OfferDetailsItem.fromMap(Map<String, dynamic> json) =>
      OfferDetailsItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        cashbackAmount: json["cashback_amount"],
        isFavorite: json["isFavorite"],
        days_left: json['days_left'],
        shop: Shop.fromMap(json["shop"]),
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "start_date": startDate,
        "end_date": endDate,
        "cashback_amount": cashbackAmount,
        "isFavorite": isFavorite,
        "days_left": days_left,
        "shop": shop.toMap(),
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
      };
}

class Shop {
  String longitude;
  String latitude;
  String shopContactEmail;
  String shopContactPhone;
  List<Availability> availability;

  Shop({
    required this.longitude,
    required this.latitude,
    required this.shopContactEmail,
    required this.shopContactPhone,
    required this.availability,
  });

  factory Shop.fromMap(Map<String, dynamic> json) => Shop(
        longitude: json["longitude"],
        latitude: json["latitude"],
        shopContactEmail: json["shop_contact_email"],
        shopContactPhone: json["shop_contact_phone"],
        availability: List<Availability>.from(
            json["availability"].map((x) => Availability.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "longitude": longitude,
        "latitude": latitude,
        "shop_contact_email": shopContactEmail,
        "shop_contact_phone": shopContactPhone,
        "availability": List<dynamic>.from(availability.map((x) => x.toMap())),
      };
}

class Availability {
  int id;
  String day;
  int status;
  int shopId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Slot> slots;

  Availability({
    required this.id,
    required this.day,
    required this.status,
    required this.shopId,
    required this.createdAt,
    required this.updatedAt,
    required this.slots,
  });

  factory Availability.fromMap(Map<String, dynamic> json) => Availability(
        id: json["id"],
        day: json["day"],
        status: json["status"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "day": day,
        "status": status,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "slots": List<dynamic>.from(slots.map((x) => x.toMap())),
      };
}

class Slot {
  int id;
  DateTime start;
  DateTime end;
  int shopAvailabilityId;
  DateTime createdAt;
  DateTime updatedAt;
  String startFormatted;
  String endFormatted;

  Slot({
    required this.id,
    required this.start,
    required this.end,
    required this.shopAvailabilityId,
    required this.createdAt,
    required this.updatedAt,
    required this.startFormatted,
    required this.endFormatted,
  });

  factory Slot.fromMap(Map<String, dynamic> json) => Slot(
        id: json["id"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        shopAvailabilityId: json["shop_availability_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        startFormatted: json["start_formatted"],
        endFormatted: json["end_formatted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "shop_availability_id": shopAvailabilityId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "start_formatted": startFormatted,
        "end_formatted": endFormatted,
      };
}
