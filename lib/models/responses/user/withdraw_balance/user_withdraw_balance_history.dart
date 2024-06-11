// To parse this JSON data, do
//
//     final userWithdrawBalanceHistoryResponse = userWithdrawBalanceHistoryResponseFromMap(jsonString);

import 'dart:convert';

UserWithdrawBalanceHistoryResponse userWithdrawBalanceHistoryResponseFromMap(
        String str) =>
    UserWithdrawBalanceHistoryResponse.fromMap(json.decode(str));

String userWithdrawBalanceHistoryResponseToMap(
        UserWithdrawBalanceHistoryResponse data) =>
    json.encode(data.toMap());

class UserWithdrawBalanceHistoryResponse {
  bool success;
  Payload payload;
  String message;

  UserWithdrawBalanceHistoryResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserWithdrawBalanceHistoryResponse.fromMap(
          Map<String, dynamic> json) =>
      UserWithdrawBalanceHistoryResponse(
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
  List<WithdrawBalanceHistoryItem> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
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
        data: List<WithdrawBalanceHistoryItem>.from(
            json["data"].map((x) => WithdrawBalanceHistoryItem.fromMap(x))),
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

class WithdrawBalanceHistoryItem {
  String amount;
  DateTime at;
  String state;

  WithdrawBalanceHistoryItem({
    required this.amount,
    required this.at,
    required this.state,
  });

  factory WithdrawBalanceHistoryItem.fromMap(Map<String, dynamic> json) =>
      WithdrawBalanceHistoryItem(
        amount: json["amount"],
        at: DateTime.parse(json["at"]),
        state: json["state"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "at": at.toIso8601String(),
        "state": state,
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
