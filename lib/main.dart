import 'dart:async';
import 'dart:io';

import 'package:bookbox/domain/app/app.dart';
import 'package:bookbox/domain/chat/sendbird/sendbird.dart';
import 'package:bookbox/gen/assets.gen.dart';
import 'package:bookbox/service/fcm_service.dart';
import 'package:bookbox/service/notification_service.dart';
import 'package:bookbox/util/log_util.dart';
import 'package:bookbox/util/permission_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Platform.isAndroid) {
    await NotificationService.initialize();
    await NotificationService.showNotification(
      title: message.data["title"],
      body: message.data["body"],
      url: "url",
      id: 0,
    );
  }
}

void main() {
  runZonedGuarded(() async {
    print("runZonedGuarded");

    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    print("widgetsBinding");

    await dotenv.load(fileName: Assets.env);
    print("dotenv.load");

    final permission = await Geolocator.checkPermission();
    print("Geolocator.checkPermission");

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    await NotificationService.initialize();
    print("NotificationService.initialize");

    SendBird.init();
    await PermissionHelper.requestNotificationPermission();
    print("requestNotificationPermission");

    await FCMService.initialize();
    print("FCMService.initialize");

    await FCMService.listenOnForegroundMessage();
    print("FCMService.listenOnForegroundMessage");

    FCMService.listenOnMessageOpenedApp();
    print("FCMService.listenOnMessageOpenedApp");

    runApp(ProviderScope(observers: [LogUtil()], child: const App()));
  }, (error, stack) {});
}
