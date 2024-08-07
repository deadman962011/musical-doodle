// import 'package:com.mybill.app/features/auth/controllers/auth_controller.dart';
// import 'package:com.mybill.app/features/chat/controllers/chat_controller.dart';
// import 'package:com.mybill.app/features/dashboard/screens/dashboard_screen.dart';
// import 'package:com.mybill.app/features/notification/controllers/notification_controller.dart';
// import 'package:com.mybill.app/features/notification/domain/models/notification_body_model.dart';
// import 'package:com.mybill.app/helper/route_helper.dart';
// import 'package:com.mybill.app/util/app_constants.dart';
// import 'package:com.mybill.app/common/enums/user_type.dart';
// import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/models/items/notification_body.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_cashback_recived.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offers_response.dart';
import 'package:com.mybill.app/repositories/user/user_offers_repository.dart';
import 'package:com.mybill.app/ui_elements/dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_context/one_context.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      try {
        NotificationBodyModel payload;
        debugPrint('notification recived ');
        if (response.payload!.isNotEmpty) {
          payload =
              NotificationBodyModel.fromJson(jsonDecode(response.payload!));
          // if (payload.notificationType == NotificationType.order) {
          //   if (Get.find<AuthController>().isGuestLoggedIn()) {
          //     Get.to(
          //         () => const DashboardScreen(pageIndex: 3, fromSplash: false));
          //   } else {
          //     Get.toNamed(RouteHelper.getOrderDetailsRoute(
          //         int.parse(payload.orderId.toString())));
          //   }
          // } else if (payload.notificationType == NotificationType.general) {
          //   Get.toNamed(
          //       RouteHelper.getNotificationRoute(fromNotification: true));
          // } else {
          //   Get.toNamed(RouteHelper.getChatRoute(
          //       notificationBody: payload,
          //       conversationID: payload.conversationId));
          // }
        }
      } catch (_) {
        debugPrint(_.toString());
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.data}");
      // if (message.data['type'] == 'message' &&
      //     Get.currentRoute.startsWith(RouteHelper.messages)) {
      //   if (Get.find<AuthController>().isLoggedIn()) {
      //     Get.find<ChatController>().getConversationList(1);
      //     if (Get.find<ChatController>()
      //             .messageModel!
      //             .conversation!
      //             .id
      //             .toString() ==
      //         message.data['conversation_id'].toString()) {
      //       Get.find<ChatController>().getMessages(
      //         1,
      //         NotificationBodyModel(
      //           notificationType: NotificationType.message,
      //           adminId: message.data['sender_type'] == UserType.admin.name
      //               ? 0
      //               : null,
      //           restaurantId:
      //               message.data['sender_type'] == UserType.vendor.name
      //                   ? 0
      //                   : null,
      //           deliverymanId:
      //               message.data['sender_type'] == UserType.delivery_man.name
      //                   ? 0
      //                   : null,
      //         ),
      //         null,
      //         int.parse(message.data['conversation_id'].toString()),
      //       );
      //     } else {
      //       NotificationHelper.showNotification(
      //           message, flutterLocalNotificationsPlugin, false);
      //     }
      //   }
      // } else if (message.data['type'] == 'message' &&
      //     Get.currentRoute.startsWith(RouteHelper.conversation)) {
      //   if (Get.find<AuthController>().isLoggedIn()) {
      //     Get.find<ChatController>().getConversationList(1);
      //   }
      //   NotificationHelper.showNotification(
      //       message, flutterLocalNotificationsPlugin, false);
      // } else {
      //   NotificationHelper.showNotification(
      //       message, flutterLocalNotificationsPlugin, false);
      //   if (Get.find<AuthController>().isLoggedIn()) {
      //     Get.find<OrderController>().getRunningOrders(1);
      //     Get.find<OrderController>().getHistoryOrders(1);
      //     Get.find<NotificationController>().getNotificationList(true);
      //   }
      // }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (message.data.isNotEmpty) {
          NotificationBodyModel notificationBody =
              convertNotification(message.data);
          // if (notificationBody.notificationType == NotificationType.order) {
          //   Get.toNamed(RouteHelper.getOrderDetailsRoute(
          //       int.parse(message.data['order_id'])));
          // } else if (notificationBody.notificationType ==
          //     NotificationType.general) {
          //   Get.toNamed(
          //       RouteHelper.getNotificationRoute(fromNotification: true));
          // } else {
          //   Get.toNamed(RouteHelper.getChatRoute(
          //       notificationBody: notificationBody,
          //       conversationID: notificationBody.conversationId));
          // }
        }
      } catch (_) {}
    });
  }

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
    bool data,
  ) async {
    String? title;
    String? body;
    String? orderID;
    String? image;
    NotificationBodyModel notificationBody = convertNotification(message.data);
    if (data) {
      title = message.data['title'];
      body = message.data['body'];
      image =
          (message.data['image'] != null && message.data['image'].isNotEmpty)
              ? message.data['image'].startsWith('http')
                  ? message.data['image']
                  : '${message.data['image']}'
              : null;
      debugPrint('notifications image is ${image}');
    } else {
      title = message.notification!.title;
      body = message.notification!.body;
      orderID = message.notification!.titleLocKey;
      if (Platform.isAndroid) {
        image = (message.notification!.android!.imageUrl != null &&
                message.notification!.android!.imageUrl!.isNotEmpty)
            ? message.notification!.android!.imageUrl!.startsWith('http')
                ? message.notification!.android!.imageUrl
                : '${message.notification!.android!.imageUrl}'
            : null;
      } else if (Platform.isIOS) {
        image = (message.notification!.apple!.imageUrl != null &&
                message.notification!.apple!.imageUrl!.isNotEmpty)
            ? message.notification!.apple!.imageUrl!
            : null;
      }
    }

    if (notificationBody.notificationType.toString() ==
        'NotificationType.cashback_recived') {
      //get invoice amount information
      var response = await UserOfferRepository()
          .getUserOfferCashbackRecivedResponse(id: notificationBody.offer_Id!);
      debugPrint(response.runtimeType.toString());
      if (response.runtimeType.toString() == 'UserOfferCashbackRecived') {
        if (OneContext.hasContext) {
          UserOfferCashbackRecived data = response;
          OneContext().showDialog(
            builder: (BuildContext context) => UserCashbackRecivedDialog(
              offer_id: notificationBody.offer_Id!,
              cashback_amount: data.payload.amount,
            ),
          );
        }
      }
    }

    if (image != null && image.isNotEmpty) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(
            title, body, orderID, notificationBody, image, fln);
      } catch (e) {
        await showBigTextNotification(
            title, body!, orderID, notificationBody, fln);
      }
    } else {
      await showBigTextNotification(
          title, body!, orderID, notificationBody, fln);
    }
  }

  static Future<void> showTextNotification(
      String title,
      String body,
      String orderID,
      NotificationBodyModel? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'mybill',
      'mybill',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: notificationBody != null
            ? jsonEncode(notificationBody.toJson())
            : null);
  }

  static Future<void> showBigTextNotification(
      String? title,
      String body,
      String? orderID,
      NotificationBodyModel? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'mybill',
      'mybill',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: notificationBody != null
            ? jsonEncode(notificationBody.toJson())
            : null);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
    String? title,
    String? body,
    String? orderID,
    NotificationBodyModel? notificationBody,
    String image,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'mybill',
      'mybill',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: notificationBody != null
            ? jsonEncode(notificationBody.toJson())
            : null);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBodyModel convertNotification(Map<String, dynamic> data) {
    if (data['type'] == 'general') {
      return NotificationBodyModel(notificationType: NotificationType.general);
    } else if (data['type'] == 'cashback_recived') {
      debugPrint(data.toString());
      return NotificationBodyModel(
          offer_Id: int.parse(data['offer_id']),
          cashback_amount: int.parse(data['cashback_amount']),
          notificationType: NotificationType.cashback_recived);
    } else {
      return NotificationBodyModel(notificationType: NotificationType.other);
    }

    // else if (data['type'] == 'order_status') {
    //   return NotificationBodyModel(
    //       notificationType: NotificationType.order,
    //       orderId: int.parse(data['order_id']));
    // } else {
    //   return NotificationBodyModel(
    //     notificationType: NotificationType.message,
    //     deliverymanId: data['sender_type'] == 'delivery_man' ? 0 : null,
    //     adminId: data['sender_type'] == 'admin' ? 0 : null,
    //     restaurantId: data['sender_type'] == 'vendor' ? 0 : null,
    //     conversationId: int.parse(data['conversation_id'].toString()),
    //   );
    // }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint(
      "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new DarwinInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
}
