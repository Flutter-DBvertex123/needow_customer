import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
