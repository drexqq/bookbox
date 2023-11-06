// Package imports:
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestMicrophonePermission() async {
    final permission = await Permission.microphone.request();
    if (permission.isGranted) {
      return true;
    } else {
      return false;
      // throw RecordingPermissionException('mic permission');
    }
  }

  static Future<bool> requestNotificationPermission() async {
    final permission = await Permission.notification.request();
    if (permission.isGranted) {
      return true;
    } else {
      openAppSettings();
      return false;
    }
  }

  static Future<bool> requestPhotoLibraryPermission() async {
    final permission = await Permission.photos.request();
    if (permission.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> requestCameraPermission() async {
    final permission = await Permission.camera.request();
    if (permission.isGranted) {
      return true;
    } else {
      openAppSettings();
      return false;
    }
  }

  static Future<void> goSetting() async {
    await openAppSettings();
  }
}
