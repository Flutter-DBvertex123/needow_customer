// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
// import 'package:newdow_customer/features/orders/view/view_order_screen.dart';
//
//
//
// RxString fcmToken = ''.obs;
//
// class FCMService {
//   final _messaging = FirebaseMessaging.instance;
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//
//   // Store the last token sent to the server
//   String? _lastTokenSentToServer;
//
//   Future<void> init() async {
//     // Ask for permission
//     await _messaging.requestPermission(alert: true, badge: true, sound: true);
//
//     // Initialize local notifications
//     await _initLocalNotifications();
//
//     // 🔹 Handle terminated app
//     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       Future.delayed(Duration(seconds: 1), () {
//         _handleNavigation(initialMessage.data);
//       });
//     }
//
//     // 🔹 Handle foreground messages
//     FirebaseMessaging.onMessage.listen(_showNotification);
//
//     // 🔹 Handle background messages (tap)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) => Future.delayed(Duration(seconds: 1), () {
//         _handleNavigation(message.data);
//       }),
//     );
//
//     // 🔹 Get initial token and send to server if needed
//     await _handleToken();
//     // 🔹 Listen for token refresh
//     FirebaseMessaging.instance.onTokenRefresh.listen(_handleToken);
//   }
//
//   // ---------------- TOKEN MANAGEMENT ----------------
//   Future<void> _handleToken([String? newToken]) async {
//     final token = newToken ?? await _messaging.getToken();
//     if (token == null) return;
//
//     fcmToken.value = token;
//
//     // Only send to server if token changed
//     if (token != _lastTokenSentToServer) {
//       _lastTokenSentToServer = token;
//       _sendTokenToServer(token);
//     }
//   }
//
//   void _sendTokenToServer(String token) {
//     log("🔥 Sending FCM token to server: $token");
//     // Call your API here to update the token for the logged-in user
//   }
//
//   // ---------------- NOTIFICATIONS ----------------
//
//   Future<void> _showNotification(RemoteMessage message) async {
//     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//     await _localNotifications.show(
//       id,
//       message.notification?.title,
//       message.notification?.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       payload: message.data['type'], // Use type to navigate
//     );
//   }
//
//   Future<void> _initLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: androidSettings);
//
//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (details) {
//         if (details.payload != null) {
//           _handleNavigation({'type': details.payload});
//         }
//       },
//     );
//   }
//
//   // ---------------- NAVIGATION ----------------
//
//   void _handleNavigation(Map<String, dynamic> data) {
//     final type = data['type'];
//     if (type == 'order') {
//       // TODO: You can fetch order from API instead of hardcoding
//       Get.to(() => ViewOrderScreen(
//         order: OrderModel(
//           id: data['orderId'] ?? 'udhdb',
//           orderNumber: "shadbghjcb",
//           orderType: "fhdgf",
//           user: "hdjjc",
//           restaurant: "sndn",
//           items: [],
//           subtotal: 84.9,
//           tax: 23,
//           deliveryFee: 234,
//           discount: 3,
//           totalAmount: 23,
//           status: "xjcb",
//           paymentStatus: "pending",
//           paymentMethod: "cash",
//           paymentId: 'jsdsbdjks',
//           deliveryAgent: "sdhjsdn",
//           estimatedDeliveryTime: DateTime.now(),
//           customerNotes: "sdjdndfj",
//           restaurantNotes: "restaurantNotes",
//           coupon: "sdn",
//           statusHistory: [],
//           isScheduled: false,
//           scheduledFor: DateTime.now(),
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//           version: 2,
//         ),
//       ));
//     }
//
//   }
//   NotificationIntent? pendingIntent;
//
//   void handleNotificationData(Map<String, dynamic> data) {
//     final type = data['type'];
//     if (type == 'order') {
//       pendingIntent = NotificationIntent(
//         type: 'order',
//         orderId: data['orderId'],
//       );
//     }
//   }
// }
//    NotificationIntent? pendingIntent;
// class NotificationIntent {
//   final String type;
//   final String orderId;
//
//   NotificationIntent({required this.type, required this.orderId});
// }
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../main.dart';

RxString fcmToken = ''.obs;

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  NotificationIntent? pendingIntent;
  String? _lastTokenSent;

  Future<void> init() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    await _initLocalNotifications();

    // Terminated
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _captureIntent(initialMessage.data);
    }

    // Background tap
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) => _captureIntent(message.data),
    );

    // Foreground
    FirebaseMessaging.onMessage.listen(_showNotification);

    // Token
    await _handleToken();
    _messaging.onTokenRefresh.listen(_handleToken);
  }

  // ---------------- TOKEN ----------------

  Future<void> _handleToken([String? newToken]) async {
    final token = newToken ?? await _messaging.getToken();
    if (token == null || token == _lastTokenSent) return;

    _lastTokenSent = token;
    fcmToken.value = token;

    log("🔥 FCM Token updated: $token");
    // TODO: send token to backend
  }

  // ---------------- NOTIFICATION ----------------

  Future<void> _showNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotifications.show(
      id,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          kNotificationChannelId,
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: message.data['type'],
    );
  }

  Future<void> _initLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    const channel = AndroidNotificationChannel(
      kNotificationChannelId,
      'High Importance Notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          _captureIntent({'type': details.payload});
        }
      },
    );
  }

  // ---------------- INTENT ----------------

  void _captureIntent(Map<String, dynamic> data) {
    if (data['type'] == 'order' && data['params'] != null) {
      pendingIntent = NotificationIntent(
        type: 'order',
        params: data['params'],
      );
    }
    else if(data['type'] == 'notification' && data['params'] != null){
      pendingIntent = NotificationIntent(
        type: 'notification',
        params: data['params'],
      );
    }
  }
}

class NotificationIntent {
  final String type;
  final String params;

  NotificationIntent({
    required this.type,
    required this.params,
  });
}
