import 'dart:async';

import 'package:bookbox/domain/app/app.dart';
import 'package:bookbox/domain/chat/sendbird/sendbird.dart';
import 'package:bookbox/gen/assets.gen.dart';
import 'package:bookbox/util/log_util.dart';
import 'package:bookbox/util/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: Assets.env);
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    SendBird.init();

    runApp(ProviderScope(observers: [LogUtil()], child: const App()));
  }, (error, stack) {});
}
