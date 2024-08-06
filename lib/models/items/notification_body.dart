enum NotificationType {
  general,
  cashback_recived,
  other
  // message,
  // order,
}

class NotificationBodyModel {
  NotificationType? notificationType;
  int? orderId;
  int? adminId;
  int? deliverymanId;
  int? restaurantId;

  int? offer_Id;
  int? cashback_amount;

  String? type;
  int? conversationId;
  int? index;
  String? image;
  String? name;
  String? receiverType;

  NotificationBodyModel({
    this.notificationType,
    this.orderId,
    this.adminId,
    this.deliverymanId,
    this.restaurantId,
    this.offer_Id,
    this.cashback_amount,
    this.type,
    this.conversationId,
    this.index,
    this.image,
    this.name,
    this.receiverType,
  });

  NotificationBodyModel.fromJson(Map<String, dynamic> json) {
    notificationType = convertToEnum(json['order_notification']);
    orderId = json['order_id'];
    adminId = json['admin_id'];
    deliverymanId = json['deliveryman_id'];
    restaurantId = json['restaurant_id'];

    offer_Id = json['offer_Id'];
    cashback_amount = json['cashback_amount'];
    type = json['type'];
    conversationId = json['conversation_id'];
    index = json['index'];
    image = json['image'];
    name = json['name'];
    receiverType = json['receiver_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_notification'] = notificationType.toString();
    data['order_id'] = orderId;
    data['admin_id'] = adminId;
    data['deliveryman_id'] = deliverymanId;
    data['restaurant_id'] = restaurantId;

    data['offer_Id'] = offer_Id;
    data['cashback_amount'] = cashback_amount;

    data['type'] = type;
    data['conversation_id'] = conversationId;
    data['index'] = index;
    data['image'] = image;
    data['name'] = name;
    data['receiver_type'] = receiverType;
    return data;
  }

  NotificationType convertToEnum(String? enumString) {
    if (enumString == NotificationType.general.toString()) {
      return NotificationType.general;
    } else if (enumString == NotificationType.cashback_recived.toString()) {
      return NotificationType.cashback_recived;
    } else if (enumString == NotificationType.other.toString()) {
      return NotificationType.other;
    }
    return NotificationType.general;
  }
}
