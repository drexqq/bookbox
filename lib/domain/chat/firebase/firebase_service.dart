import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class FirebaseService{

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Background message
    debugPrint("background handle!");
  }

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Foreground message
      debugPrint("foreground!");
    });
    await _registerPushToken();
  }
  
  Future<void> _registerPushToken() async {
    final type = _getPushTokenType();
    final token = await _getToken();

    if(type == null|| token == null){
      debugPrint("_registerPushToken error :: type or token is null");
      return;
    }

    await SendbirdChat.registerPushToken(
      type: type,
      token: token,
      unique: true,
    );

  }

  PushTokenType? _getPushTokenType() {
    PushTokenType? pushTokenType;
    if (Platform.isAndroid) {
      pushTokenType = PushTokenType.fcm;
    } else if (Platform.isIOS) {
      pushTokenType = PushTokenType.apns;
    }
    return pushTokenType;
  }

  Future<String?> _getToken() async {
    String? token;
    if (Platform.isAndroid) {
      token = await FirebaseMessaging.instance.getToken();
    } else if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    }
    return token;
  }

}