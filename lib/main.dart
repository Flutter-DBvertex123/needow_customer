// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:newdow_customer/utils/app_services/firebase_notification_service.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/automaticNoConnectionBanner.dart';
// import 'package:newdow_customer/utils/networkController.dart';
// import 'package:newdow_customer/utils/networkHelper.dart';
// import 'package:newdow_customer/utils/networkService.dart';
// import 'package:newdow_customer/utils/noInternetBanner.dart';
//
// import 'binding/service_locater.dart';
// import 'features/auth/view/login_screen.dart';
// import 'features/auth/view/splash_screen.dart';
// import 'package:flutter/material.dart';
//
// import 'firebase_options.dart';
//
// //
// // @pragma('vm:entry-point')
// // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
// //   print("📦 Background message: ${message.messageId}");
// // }
// const String kNotificationChannelId = 'high_importance_channel';
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   log("📦 Background message: ${message.messageId}");
// }
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   //ServiceLocater.initServices();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //
// //   FirebaseMessaging.onBackgroundMessage(
// //       firebaseMessagingBackgroundHandler);
// //   await FCMService().init();
// //   //AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
// //   Get.put(NetworkController());
// //   ServiceLocater.initServices();
// //   runApp(MyApp());
// // }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseMessaging.onBackgroundMessage(
//       firebaseMessagingBackgroundHandler);
//   final fcmService = Get.put(FCMService(), permanent: true);
//   //await FCMService().init(); // must be BEFORE runApp
//  await   fcmService.init();
//   Get.put(NetworkController());
//   ServiceLocater.initServices();
//
//   runApp(const MyApp());
// }
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   Get.put(NetworkController());
// //   ServiceLocater.initServices();
// //   runApp(MyApp());
// // }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return GetMaterialApp(
//     //   theme: AppTheme.lightTheme,
//     //   debugShowCheckedModeBanner: false,
//     //   home: SplashScreen(),
//     // );
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       builder: (context, child) {
//         final network = Get.find<NetworkController>();
//
//         ever(network.hasInternet, (bool hasInternet) {
//           if (!hasInternet) {
//             _showNoInternetDialog(context);
//           } else {
//             if (Get.isDialogOpen == true) {
//               //ServiceLocater.initServices();
//               Get.back(); // close dialog automatically
//             }
//           }
//         });
//
//         return child!;
//       },
//       home: SplashScreen(),
//     );
//
//   }
// }
// void _showNoInternetDialog(BuildContext context) {
//   if (Get.isDialogOpen == true) return;
//
//   Get.dialog(
//     AlertDialog(
//       title: Text("No Internet"),
//       content: Text("Waiting for connection..."),
//     ),
//     barrierDismissible: false,
//   );
// }
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/utils/app_services/DeepLink.dart';

import 'firebase_options.dart';
import 'utils/app_services/firebase_notification_service.dart';
import 'utils/apptheme.dart';
import 'utils/networkController.dart';
import 'binding/service_locater.dart';
import 'features/auth/view/splash_screen.dart';

const String kNotificationChannelId = 'high_importance_channel';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log("📦 Background message received: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DeepLinkService.init();
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  // Init services BEFORE UI
  Get.put(NetworkController(), permanent: true);
  Get.put(FCMService(), permanent: true);

  ServiceLocater.initServices();

  await Get.find<FCMService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
