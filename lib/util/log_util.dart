// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class LogUtil extends ProviderObserver {
  LogUtil({this.excludedKeys});
  Set<String>? excludedKeys;
  static void initRootLogger() {
    if (kDebugMode) {
      Logger.root.level = Level.ALL;
    } else {
      Logger.root.level = Level.OFF;
    }
    hierarchicalLoggingEnabled = true;

    Logger.root.onRecord.listen((record) {
      if (!kDebugMode) {
        return;
      }

      var start = '\x1b[90m';
      const white = '\x1b[37m';

      switch (record.level.name) {
        case 'INFO':
          start = '\x1b[32m';
          break;
        case 'WARNING':
          start = '\x1b[93m';
          break;
        case 'CONFIG':
          start = '\x1b[93m';
          break;
        case 'SEVERE':
          start = '\x1b[103m\x1b[31m';
          break;
        case 'SHOUT':
          start = '\x1b[41m\x1b[93m';
          break;
      }

      final message =
          '$white${record.time}$start\n[${record.level.name}]\n${record.message}';
      log(
        message,
        name: record.loggerName.padRight(25),
        level: record.level.value,
        time: record.time,
      );
    });
  }

  /// info: white
  /// fine, finer, finest: grey
  /// warning: yellow
  /// severe: red text, yellow bg
  /// shout: red
  /// shout: red

  final Logger _log = Logger("Provider");

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (excludedKeys != null) {
      if (!excludedKeys!.contains(provider.name)) {
        _log.info(
            "add provider: ${provider.name ?? provider.runtimeType}\nvalue: ${value.toString()}");
      }
    }
  }

  @override
  void providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (excludedKeys != null) {
      if (!excludedKeys!.contains(provider.name)) {
        _log.info(
          "fail provider: ${provider.name ?? provider.runtimeType}\nerror: ${error.toString()}",
        );
      }
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (excludedKeys != null) {
      if (!excludedKeys!.contains(provider.name)) {
        _log.info(
          "update provider: ${provider.name ?? provider.runtimeType}\npreviousValue: ${previousValue.toString()}\nnewValue: ${newValue.toString()}",
        );
      }
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    if (excludedKeys != null) {
      if (!excludedKeys!.contains(provider.name)) {
        _log.info(
          "dispose provider: ${provider.name ?? provider.runtimeType}\ncontainers: $container",
        );
      }
    }
  }
}
