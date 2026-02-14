//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/orders/view/view_order_screen.dart';
// import '../../../utils/app_services/firebase_notification_service.dart';
// import '../../../utils/getSize.dart';
// import '../../../utils/constants.dart';
// import '../../../utils/permission_handler.dart';
// import '../../../utils/prefs.dart';
// import '../../../widgets/navbar.dart';
// import '../../orders/controllers/orderController.dart';
// import 'login_screen.dart';
// import 'onboarding.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _startFlow();
//   }
//   //
//   // Future<void> _startFlow() async {
//   //   // STEP 1 → Request permissions
//   //   await AppPermissionHandler.checkLocationPermission();
//   //
//   //   // STEP 2 → Wait splash
//   //   await Future.delayed(const Duration(seconds: 2));
//   //
//   //   // STEP 3 → Wait until Internet is available
//   //   bool connected = await _waitForInternet();
//   //   if (!connected) return; // If user closes app, just return
//   //
//   //   // STEP 4 → Continue app logic
//   //   final token = await AuthStorage.getAccessToken();
//   //   if (!mounted) return;
//   //
//   //   if (token != null && token.isNotEmpty) {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (_) => CustomBottomNav()),
//   //     );
//   //   } else {
//   //     Get.off(() => Onboarding());
//   //   }
//   // }
//   Future<void> _startFlow() async {
//     // STEP 1 → Permissions
//     await AppPermissionHandler.checkLocationPermission();
//
//     // STEP 2 → Splash delay
//     await Future.delayed(const Duration(seconds: 2));
//
//     // STEP 3 → Internet check
//     bool connected = await _waitForInternet();
//     if (!connected || !mounted) return;
//
//     // STEP 4 → Auth check
//     final token = await AuthStorage.getAccessToken();
//     if (!mounted) return;
//
//     final fcmService = Get.find<FCMService>();
//     final intent = fcmService.pendingIntent;
//
//     // 🔐 NOT LOGGED IN
//     if (token == null || token.isEmpty) {
//       if (intent != null) {
//         // Save intent for after login
//         fcmService.pendingIntent = intent;
//       }
//       Get.off(() => Onboarding());
//       return;
//     }
//
//     // ✅ LOGGED IN
//     if (intent != null) {
//       await _handleNotificationIntent(intent);
//       fcmService.pendingIntent = null;
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => CustomBottomNav()),
//       );
//     }
//   }
//   Future<void> _handleNotificationIntent(NotificationIntent intent) async {
//     if (intent.type == 'order' && intent.orderId != null) {
//       try {
//         // Optional loader screen
//         final order = await Get.find<OrderController>().getOrderById(intent.orderId!);
//
//         Get.offAll(() => ViewOrderScreen(order: order));
//       } catch (e) {
//         // Fallback if API fails
//         Get.offAll(() => CustomBottomNav());
//       }
//     } else {
//       Get.offAll(() => CustomBottomNav());
//     }
//   }
//
//
//   Future<bool> _waitForInternet() async {
//     while (!await InternetConnectionChecker().hasConnection) {
//       if (!mounted) return false; // User closed app
//       await _showNoInternetDialog();
//     }
//     return true;
//   }
//
//   Future<void> _showNoInternetDialog() async {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         title: const Text("No Internet"),
//         content: const Text("Please check your connection..."),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               Navigator.of(ctx).pop();
//               // Wait a bit before checking again
//               await Future.delayed(const Duration(seconds: 2));
//             },
//             child: const Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff08583C),
//       body: Center(
//         child: Image.asset(logoLite, height: 0.12.toHeightPercent()),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../utils/app_services/ServerChecker.dart';
import '../../../utils/app_services/firebase_notification_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/permission_handler.dart';
import '../../../utils/prefs.dart';
import '../../../utils/serverNotFoundScreen.dart';
import '../../../widgets/navbar.dart';
import '../../address/controller/addressController.dart';
import '../../orders/controllers/orderController.dart';
import '../../orders/view/track_order_screen.dart';
import '../../orders/view/view_order_screen.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  // Future<void> _startFlow() async {
  //   await AppPermissionHandler.checkLocationPermission();
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   if (!await _waitForInternet() || !mounted) return;
  //
  //   final token = await AuthStorage.getAccessToken();
  //   final fcmService = Get.find<FCMService>();
  //   final intent = fcmService.pendingIntent;
  //
  //   // Not logged in
  //   if (token == null || token.isEmpty) {
  //     Get.off(() => const Onboarding());
  //     return;
  //   }
  //
  //   // Logged in + notification
  //   if (intent != null) {
  //     await _handleNotificationIntent(intent);
  //     fcmService.pendingIntent = null;
  //     return;
  //   }
  //
  //   // Normal launch
  //   Get.off(() => const CustomBottomNav());
  // }
  Future<void> _startFlow() async {
    await AppPermissionHandler.checkLocationPermission();
    await Future.delayed(const Duration(seconds: 2));

    if (!await _waitForInternet() || !mounted) return;

    final hasIssue = await ServerHealthHelper.hasServerIssue();

    if (hasIssue) {
      // Show maintenance / error screen
      Get.to(() => const ServerNotFoundScreen());
      return;
    }

    final token = await AuthStorage.getAccessToken();
    final fcmService = Get.find<FCMService>();
    final intent = fcmService.pendingIntent;

    // Not logged in
    if (token == null || token.isEmpty) {
      Get.off(() => const Onboarding());
      return;
    }

    // Logged in (normal OR notification)
    // ❗ Always go to BottomNav

      await Get.find<AddressController>().loadAddresses();

    Get.offAll(() => const CustomBottomNav());
  }

  Future<void> _handleNotificationIntent(NotificationIntent intent) async {
    try {
      final order = await Get.find<OrderController>()
          .getOrderById(intent.params);

      Get.to(() => TrackOrderScreen(order: order));
    } catch (_) {
      Get.offAll(() => const CustomBottomNav());
    }
  }

  Future<bool> _waitForInternet() async {
    while (!await InternetConnectionChecker().hasConnection) {
      if (!mounted) return false;
      await _showNoInternetDialog();
    }
    return true;
  }

  Future<void> _showNoInternetDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text("No Internet"),
        content: Text("Please check your connection"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08583C),
      body: Center(
        child: Image.asset(logoLite, height: 0.12.toHeightPercent()),
      ),
    );
  }
}
