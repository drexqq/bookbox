import 'dart:async';

import 'package:bookbox/domain/app/app.dart';
import 'package:bookbox/gen/assets.gen.dart';
import 'package:bookbox/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: Assets.env);

    runApp(ProviderScope(observers: [LogUtil()], child: const App()));
  }, (error, stack) {});
}
