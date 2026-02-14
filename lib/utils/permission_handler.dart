import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  static Future<void> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

  /// Request location permission

