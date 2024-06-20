// To parse this JSON data, do
//
//     final userWalletTransactionsResponse = userWalletTransactionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserWalletTransactionsResponse userWalletTransactionsResponseFromMap(
        String str) =>
    UserWalletTransactionsResponse.fromMap(json.decode(str));

String userWalletTransactionsResponseToMap(
        UserWalletTransactionsResponse data) =>
    json.encode(data.toMap());

class UserWalletTransactionsResponse {
  bool success;
  Payload payload;
  String message;

  UserWalletTransactionsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserWalletTransactionsResponse.fromMap(Map<String, dynamic> json) =>
      UserWalletTransactionsResponse(
        success: json["success"],
        payload: Payload.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class Payload {
  int currentPage;
  List<UserWalletTransactions> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  Payload({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        currentPage: json["current_page"],
        data: List<UserWalletTransactions>.from(
            json["data"].map((x) => UserWalletTransactions.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class UserWalletTransactions {
  int id;
  String amount;
  String type;
  String reason;
  String createdAt;

  UserWalletTransactions({
    required this.id,
    required this.amount,
    required this.type,
    required this.reason,
    required this.createdAt,
  });

  factory UserWalletTransactions.fromMap(Map<String, dynamic> json) =>
      UserWalletTransactions(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        reason: json["reason"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "type": type,
        "created_at": createdAt,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}



// // To parse this JSON data, do
// //
// //     final userWalletTransactionsResponse = userWalletTransactionsResponseFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// UserWalletTransactionsResponse userWalletTransactionsResponseFromMap(
//         String str) =>
//     UserWalletTransactionsResponse.fromMap(json.decode(str));

// String userWalletTransactionsResponseToMap(
//         UserWalletTransactionsResponse data) =>
//     json.encode(data.toMap());

// class UserWalletTransactionsResponse {
//   bool success;
//   List<UserWalletTransactions> payload;
//   String message;

//   UserWalletTransactionsResponse({
//     required this.success,
//     required this.payload,
//     required this.message,
//   });

//   factory UserWalletTransactionsResponse.fromMap(Map<String, dynamic> json) =>
//       UserWalletTransactionsResponse(
//         success: json["success"],
//         payload: List<UserWalletTransactions>.from(
//             json["payload"].map((x) => UserWalletTransactions.fromMap(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toMap() => {
//         "success": success,
//         "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
//         "message": message,
//       };
// }

// class UserWalletTransactions {
//   int id;
//   String amount;
//   String type;
//   String createdAt;

//   UserWalletTransactions({
//     required this.id,
//     required this.amount,
//     required this.type,
//     required this.createdAt,
//   });

//   factory UserWalletTransactions.fromMap(Map<String, dynamic> json) =>
//       UserWalletTransactions(
//         id: json["id"],
//         amount: json["amount"],
//         type: json["type"],
//         createdAt: json["created_at"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "amount": amount,
//         "type": type,
//         "created_at": createdAt,
//       };
// }
