import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger("NotificationService");

class NotificationService {
  NotificationService._();

  static Future<bool?> initialize() async {
    const androidChannel = AndroidNotificationChannel(
      'default_notification_channel_id',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            requestProvisionalPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) {}));
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
    bool? result = await FlutterLocalNotificationsPlugin()
        .initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: notificationTap,
      // onDidReceiveBackgroundNotificationResponse: notificationTap,
    )
        .onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      return null;
    });
    return result;
  }

  static Future<void> showNotification({
    required String? title,
    required String? body,
    required String? url,
    required int id,
  }) async {
    const androidChannel = AndroidNotificationChannel(
      'default_notification_channel_id',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          importance: Importance.max,
          priority: Priority.max,
          showWhen: true,
          playSound: true,
          enableVibration: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentBadge: true,
          presentAlert: true,
          presentSound: true,
          presentBanner: true,
          presentList: true,
        ));
    await FlutterLocalNotificationsPlugin()
        .show(id, title, body, notificationDetails, payload: "");
  }

  static void notificationTap(NotificationResponse notificationResponse) {
    // goPage(notificationResponse.payload);
  }

  static Future<void> test() async {
    // print("SHOW1");
    // const androidChannel = AndroidNotificationChannel(
    //   'default_notification_channel_id',
    //   'High Importance Notifications',
    //   description: 'This channel is used for important notifications.',
    //   importance: Importance.max,
    // );
    // print("SHOW2");
    // final notificationDetails = NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       androidChannel.id,
    //       androidChannel.name,
    //       channelDescription: androidChannel.description,
    //       importance: Importance.max,
    //       priority: Priority.max,
    //       showWhen: true,
    //       playSound: true,
    //       enableVibration: true,
    //     ),
    //     iOS: const DarwinNotificationDetails(
    //       presentBadge: true,
    //       presentAlert: true,
    //       presentSound: true,
    //       presentBanner: true,
    //       presentList: true,
    //     ));
    // print("TSET");
    // await FlutterLocalNotificationsPlugin()
    //     .show(1, "title", "body", notificationDetails, payload: "");
  }

  // static Future<void> listenTerminated() async {
  //   NotificationAppLaunchDetails? initialNotification =
  //       await FlutterLocalNotificationsPlugin()
  //           .getNotificationAppLaunchDetails();

  //   if (initialNotification?.didNotificationLaunchApp ?? false) {
  //     final payload = initialNotification?.notificationResponse?.payload;
  //     if (appRouter.current.name == "ChatPageRoute") {
  //       return;
  //     }
  //     if (payload == "" || payload == null) {
  //       return;
  //     }
  //     final data = jsonDecode(payload);
  //     appRouter.push(ChatPageRoute(
  //         channelUrl: data["url"],
  //         unreadCount: int.tryParse(data["badge"]),
  //         channelId: data["channel_id"]));
  //   }
  // }

  // static void goPage(String? payload) {
  //   if (appRouter.current.name == "ChatPageRoute") {
  //     return;
  //   }
  //   if (payload == "" || payload == null) {
  //     return;
  //   }
  //   final data = jsonDecode(payload);
  //   appRouter.push(ChatPageRoute(
  //     channelUrl: data["url"],
  //     channelId: data["channel_id"],
  //     unreadCount: int.tryParse(data["badge"]),
  //   ));
  // }

  static Future<void> removeNotifications(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
  }
}
