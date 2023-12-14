import 'dart:io';

import 'package:bookbox/firebase_options.dart';
import 'package:bookbox/service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';

class FCMService {
  FCMService._();

  static Logger logger = Logger("FCMService");

  static FirebaseMessaging? messaging;

  static Future<void> initialize() async {
    if (kIsWeb) return;

    await Firebase.initializeApp(
        name: 'Bookbox', options: DefaultFirebaseOptions.currentPlatform);

    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging!.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    await messaging!.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      throw Exception('${settings.authorizationStatus}');
    } else {
      messaging!.onTokenRefresh.listen((token) async {}).onError((e) {
        throw Exception("messaging!.onTokenRefresh ${e.toString()}");
      });
    }
  }

  static Future<void> listenOnForegroundMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String? title = Platform.isAndroid
          ? message.notification?.title
          : message.data["title"];
      String? body = Platform.isAndroid
          ? message.notification?.body
          : message.data["body"];
      await NotificationService.showNotification(
        title: title,
        body: body,
        url: "url",
        id: 0,
      );
    });
  }

  static Future<void> listenOnMessageOpenedApp() async {
    // * ios click notification callback
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print("OpenedApp");
      print(message);

      // goPage(message.data["url"], int.parse(message.data["badge"]),
      //     int.parse(message.data["channel_id"]));
    });
  }

  static Future<String?> getFCMToken() async {
    return await messaging!.getToken();
  }

  // static void goPage(String url, int count, int channelId) {
  //   if (appRouter.current.name == "ChatPageRoute") {
  //     return;
  //   }
  //   appRouter.push(ChatPageRoute(
  //       channelUrl: url, unreadCount: count, channelId: channelId));
  // }
}
