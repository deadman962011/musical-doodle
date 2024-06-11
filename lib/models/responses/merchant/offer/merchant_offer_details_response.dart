// To parse this JSON data, do
//
//     final merchantOfferDetailsResponse = merchantOfferDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantOfferDetailsResponse merchantOfferDetailsResponseFromMap(String str) =>
    MerchantOfferDetailsResponse.fromMap(json.decode(str));

String merchantOfferDetailsResponseToMap(MerchantOfferDetailsResponse data) =>
    json.encode(data.toMap());

class MerchantOfferDetailsResponse {
  bool success;
  OfferDetailsItem payload;
  String message;

  MerchantOfferDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantOfferDetailsResponse.fromMap(Map<String, dynamic> json) =>
      MerchantOfferDetailsResponse(
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
  int cashbackAmount;
  String startDate;
  String endDate;
  String state;
  int sales;
  int commissionAmountPercentage;
  int commission;
  List<OfferInvoiceMini> beneficiaries;
  int beneficiariesCount;

  OfferDetailsItem({
    required this.id,
    required this.name,
    required this.cashbackAmount,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.sales,
    required this.commissionAmountPercentage,
    required this.commission,
    required this.beneficiaries,
    required this.beneficiariesCount,
  });

  factory OfferDetailsItem.fromMap(Map<String, dynamic> json) =>
      OfferDetailsItem(
        id: json["id"],
        name: json["name"],
        cashbackAmount: json["cashback_amount"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        state: json["state"],
        sales: json["sales"],
        commissionAmountPercentage: json["commission_amount_percentage"],
        commission: json["commission"],
        beneficiaries: List<OfferInvoiceMini>.from(
            json["beneficiaries"].map((x) => OfferInvoiceMini.fromMap(x))),
        beneficiariesCount: json["beneficiaries_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "cashback_amount": cashbackAmount,
        "start_date": startDate,
        "end_date": endDate,
        "state": state,
        "sales": sales,
        "commission_amount_percentage": commissionAmountPercentage,
        "commission": commission,
        "beneficiaries":
            List<dynamic>.from(beneficiaries.map((x) => x.toMap())),
        "beneficiaries_count": beneficiariesCount,
      };
}

class OfferInvoiceMini {
  int id;
  String amount;
  String name;
  String state;
  DateTime createdAt;

  OfferInvoiceMini({
    required this.id,
    required this.amount,
    required this.name,
    required this.state,
    required this.createdAt,
  });

  factory OfferInvoiceMini.fromMap(Map<String, dynamic> json) =>
      OfferInvoiceMini(
        id: json["id"],
        amount: json["amount"],
        name: json["name"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "name": name,
        "state": state,
        "created_at": createdAt.toIso8601String(),
      };
}





// import 'dart:convert';

// MerchantOfferDetailsResponse merchantOfferDetailsResponseFromJson(String str) =>
//     MerchantOfferDetailsResponse.fromJson(json.decode(str));

// class MerchantOfferDetailsResponse {
//   MerchantOfferDetailsResponse({
//     required this.offer,
//     required this.success,
//   });

//   OfferWithDetails offer;
//   bool success;

//   factory MerchantOfferDetailsResponse.fromJson(Map<String, dynamic> json) =>
//       MerchantOfferDetailsResponse(
//         success: json["success"],
//         offer: json['payload'],
//       );

//   Map<String, dynamic> toJson() => {"success": success, "offer": offer};
// }

// class OfferWithDetails {
//   OfferWithDetails({
//     required this.id,
//     required this.name,
//     required this.state,
//     required this.sales,
//     required this.commission,
//     required this.start_date,
//     required this.end_date,
//   });

//   int id;
//   String name;
//   String state;
//   int commission;
//   String start_date;
//   String end_date;
//   List<OfferSale> sales;

//   factory OfferWithDetails.fromJson(Map<String, dynamic> json) =>
//       OfferWithDetails(
//         id: json["id"],
//         name: json['name'],
//         state: json['state'],
//         sales: json['sales'],
//         commission: json['commission'],
//         start_date: json['start_date'],
//         end_date: json['end_date'],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "start_date": start_date,
//         "end_date": end_date,
//         "commission": commission,
//         "state": state,
//         "sales": sales,
//       };
// }

// class OfferSale {
//   OfferSale({
//     required this.id,
//     required this.name,
//   });

//   int id;
//   String name;

//   factory OfferSale.fromJson(Map<String, dynamic> json) => OfferSale(
//         id: json["id"],
//         name: json['name'],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
