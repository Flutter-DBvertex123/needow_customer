// 1. DEFINE ROUTES - Create a routes file or in your main.dart

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/auth/view/splash_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String product = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const SplashScreen(),
    ),

  ];
}
