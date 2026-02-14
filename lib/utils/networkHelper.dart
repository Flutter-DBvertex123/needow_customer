import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetListener {
  static bool _isDialogOpen = false;

  static void initialize() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      var hasInternet = status == InternetConnectionStatus.connected;

      if (!hasInternet) {
        _openDialog();
      } else {
        _closeDialog();
      }
    });
  }

  static void _openDialog() {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    final context = Get.overlayContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("No Internet"),
        content: Text("Please check your connection..."),
      ),
    );
  }

  static void _closeDialog() {
    if (!_isDialogOpen) return;
    _isDialogOpen = false;

    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}


class InternetWatcher {
  static bool _isDialogOpen = false;

  static void start() {
    InternetConnectionChecker()
        .onStatusChange
        .listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      if (!hasInternet) {
        _openDialog();
      } else {
        _closeDialog();
      }
    });
  }

  static void _openDialog() {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    final ctx = Get.overlayContext;
    if (ctx == null) return;

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("No Internet"),
        content: Text("Waiting for connection…"),
      ),
    );
  }

  static void _closeDialog() {
    if (!_isDialogOpen) return;

    if (Get.isDialogOpen == true) {
      Get.back();
    }

    _isDialogOpen = false;
  }
}
void showNoInternetDialog(BuildContext context, {required VoidCallback onRetry}) {
  if (Get.isDialogOpen == true) return;

  Get.dialog(
    AlertDialog(
      title: const Text("No Internet"),
      content: const Text("Please check your connection..."),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // close dialog
            onRetry();
          },
          child: const Text("Retry"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}