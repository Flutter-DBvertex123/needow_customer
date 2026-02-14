// /*
// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// import '../features/home/view/dashboard_screen.dart';
// import 'apptheme.dart';
//
// class AutomaticNoConnectionDialog {
//   static StreamSubscription<List<ConnectivityResult>>? _listener;
//   static bool _isDialogShowing = false;
//   static BuildContext? _currentContext;
//
//   static void startListening() {
//     _listener?.cancel();
//
//     _listener = Connectivity().onConnectivityChanged.listen(
//           (List<ConnectivityResult> result) async {
//         bool hasInternet = await InternetConnectionChecker().hasConnection;
//
//         if (!hasInternet) {
//           /// NO INTERNET
//           _showNoInternetDialog();
//         } else {
//           /// INTERNET RESTORED
//           if (_isDialogShowing) {
//             _dismissDialog();
//             _showInternetRestoredDialog();
//           }
//         }
//       },
//     );
//   }
//
//   static void dispose() {
//     _listener?.cancel();
//     _dismissDialog();
//   }
//
//   // ================= NO INTERNET DIALOG =================
//
//   static void _showNoInternetDialog() {
//     if (_isDialogShowing || getMsGlobalContext() == null) return;
//
//     _isDialogShowing = true;
//     _currentContext = getMsGlobalContext();
//     AudioPlayerManager().pause();
//
//     showDialog(
//       context: _currentContext!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           child: AlertDialog(
//             backgroundColor: Colors.grey[900],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(color: Colors.green),
//                 const SizedBox(height: 20),
//                  Text("No Internet Connection",),
//                 const SizedBox(height: 10),
//                 const Text("Waiting for connection...", ),
//               ],
//             ),
//           ),
//         );
//       },
//     ).then((_) => _cleanupDialog());
//   }
//
//   // ================= INTERNET RESTORED DIALOG =================
//
//   static void _showInternetRestoredDialog() {
//     _dismissDialog();
//
//     showDialog(
//       context: getGlobalContext()!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey[900],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               CircularProgressIndicator(color: AppTheme.accentColor),
//               SizedBox(height: 20),
//               Text("Internet Restored", color: Colors.white),
//               SizedBox(height: 10),
//               Text("Refreshing...", color: Colors.white70),
//             ],
//           ),
//         );
//       },
//     );
//
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.of(getGlobalContext()!).pop();
//       _reloadVisibleScreen();
//     });
//   }
//
//   // ================= DISMISS =================
//
//   static void _dismissDialog() {
//     if (_isDialogShowing && _currentContext != null) {
//       Navigator.of(_currentContext!).pop();
//       _cleanupDialog();
//     }
//   }
//
//   static void _cleanupDialog() {
//     _isDialogShowing = false;
//     _currentContext = null;
//   }
//
//   // ================= RELOAD =================
//
//   static void _reloadVisibleScreen() {
//     Navigator.create().pushNamedAndRemoveUntil(
//       HomeScreen.isHomeShowing
//           ? Naviagtor.homeRoute
//           : Naviagtor.splashRoute,
//           (f) => false,
//     );
//   }
// }
// */
// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// import '../features/home/view/dashboard_screen.dart';
// import '../main.dart';
//
// class AutomaticNoConnectionDialog {
//   static StreamSubscription<List<ConnectivityResult>>? _listener;
//   static bool _isDialogShowing = false;
//   static BuildContext? _currentContext;
//
//   static void startListening() {
//     _listener?.cancel();
//
//     _listener = Connectivity().onConnectivityChanged.listen(
//           (List<ConnectivityResult> result) async {
//         bool hasInternet = await InternetConnectionChecker().hasConnection;
//
//         if (!hasInternet) {
//           /// NO INTERNET
//           _showNoInternetDialog();
//         } else {
//           /// INTERNET RESTORED
//           if (_isDialogShowing) {
//             _dismissDialog();
//             _showInternetRestoredDialog();
//           }
//         }
//       },
//     );
//   }
//
//   static void dispose() {
//     _listener?.cancel();
//     _dismissDialog();
//   }
//
//   // ================= NO INTERNET DIALOG =================
//
//   static void _showNoInternetDialog() {
//     if (_isDialogShowing || getMsGlobalContext() == null) return;
//
//     _isDialogShowing = true;
//     _currentContext = getMsGlobalContext();
//     //AudioPlayerManager().pause();
//
//     showDialog(
//       context: _currentContext!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           child: AlertDialog(
//             backgroundColor: Colors.grey[900],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 CircularProgressIndicator(color: Colors.green),
//                 SizedBox(height: 20),
//                 Text("No Internet Connection",),
//                 SizedBox(height: 10),
//                 Text("Waiting for connection...",),
//               ],
//             ),
//           ),
//         );
//       },
//     ).then((_) => _cleanupDialog());
//   }
//
//   // ================= INTERNET RESTORED DIALOG =================
//
//   static void _showInternetRestoredDialog() {
//     _dismissDialog();
//
//     showDialog(
//       context: getMsGlobalContext()!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey[900],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               CircularProgressIndicator(color: Colors.green),
//               SizedBox(height: 20),
//               Text("Internet Restored", ),
//               SizedBox(height: 10),
//               Text("Refreshing...", ),
//             ],
//           ),
//         );
//       },
//     );
//
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.of(getMsGlobalContext()!).pop();
//       _reloadVisibleScreen();
//     });
//   }
//
//   // ================= DISMISS =================
//
//   static void _dismissDialog() {
//     if (_isDialogShowing && _currentContext != null) {
//       Navigator.of(_currentContext!).pop();
//       _cleanupDialog();
//     }
//   }
//
//   static void _cleanupDialog() {
//     _isDialogShowing = false;
//     _currentContext = null;
//   }
//
//   // ================= RELOAD =================
//   static void _reloadVisibleScreen() {
//     final context = getMsGlobalContext();
//     if (context == null) return;
//
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (_) => HomeScreen()),
//           (route) => false,
//     );
//   }
//
// }
