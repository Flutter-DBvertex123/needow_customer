import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'networkService.dart';


class NoInternetBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return NetworkService.to.isOnline.value
          ? const SizedBox.shrink()
          : Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: Colors.red,
        child: const Text(
          "No Internet Connection",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
