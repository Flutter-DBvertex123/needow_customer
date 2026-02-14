// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:needow/features/profile/view/profile_screen.dart';
// //
// // class CustomBottomNav extends StatefulWidget {
// //   const CustomBottomNav({
// //     super.key,});
// //   @override
// //   State<CustomBottomNav> createState() => _CustomBottomNavState();
// // }
// //
// // class _CustomBottomNavState extends State<CustomBottomNav> {
// //   int currentIndex = 0;
// //   void navigate(int changedValue){
// //     Get.to(ProfileScreen());
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomNavigationBar(
// //       type: BottomNavigationBarType.fixed,
// //
// //       backgroundColor: Colors.white,
// //       selectedItemColor: const Color(0xFF0A9962),
// //       unselectedItemColor: Colors.grey,
// //       currentIndex: currentIndex,
// //       onTap: (value) => navigate(value),
// //       items: const [
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.home_outlined,size: 30,),
// //           label: "Home",
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.shopping_bag_outlined,size: 30),
// //           label: "Orders",
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.notifications_outlined,size: 30),
// //           label: "Notifications",
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.currency_rupee_outlined,size: 30),
// //           label: "Earnings",
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.person_outline,size: 30),
// //           label: "Profile",
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:newdow_customer/features/cart/view/my_cart_screen.dart';
// import 'package:newdow_customer/features/cutomerSupport/view/cutomer_support_screen.dart';
// import 'package:newdow_customer/features/profile/view/coupon_sceen.dart';
// import '../features/home/view/dashboard_screen.dart';
// import '../utils/apptheme.dart';
// import '../utils/constants.dart';
// // import your other screens
//
// class CustomBottomNav extends StatefulWidget {
//   int? currentIndex;
//    CustomBottomNav({super.key,this.currentIndex});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int currentIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     currentIndex = widget.currentIndex ?? 0;
//   }
//
//   final List<Widget> screens = [
//     //DashboardScreen(),
//      HomeScreen(),  // replace with HomeScreen()
//      CouponSceen(isFromBottamNav: true,), // replace with OrdersScreen()
//      CutomerSupportScreen(),
//      CartScreen(isFromBottamNav: true,)// replace with NotificationsScreen()
//     // replace with EarningsScreen()
//     //DashboardScreen(),
//
//    // OrdersScreen(),
//    // NotificationScreen(),
//    // EarningsScreen(),
//     //ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         selectedItemColor: const Color(0xFF0A9962),
//         unselectedItemColor: Colors.grey,
//         currentIndex: currentIndex,
//         onTap: (value) {
//           setState(() {
//             currentIndex = value;
//           });
//         },
//         items:  [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(nav_home,
//                 height: 30,
//                 colorFilter: ColorFilter.mode(
//                   currentIndex == 0 ? AppColors.primary : Color(0x80000000),
//                   BlendMode.srcIn,
//                 ),
//               ),
//             label: "Home"
//             ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(nav_offer,
//               height: 30,
//               colorFilter: ColorFilter.mode(
//                 currentIndex == 1 ? AppColors.primary : Color(0x80000000),
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Offer",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(nav_support,
//               height: 30,
//               colorFilter: ColorFilter.mode(
//                 currentIndex == 2 ? AppColors.primary : Color(0x80000000),
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Support",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(nav_cart,
//               height: 30,
//               colorFilter: ColorFilter.mode(
//                 currentIndex == 3 ? AppColors.primary : Color(0x80000000),
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Cart",
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/view/my_cart_screen.dart';
import 'package:newdow_customer/features/cutomerSupport/view/cutomer_support_screen.dart';
import 'package:newdow_customer/features/notification/view/notification_screen.dart';
import 'package:newdow_customer/features/profile/view/coupon_sceen.dart';
import '../features/home/view/dashboard_screen.dart';
import '../features/orders/controllers/orderController.dart';
import '../features/orders/view/track_order_screen.dart';
import '../utils/app_services/firebase_notification_service.dart';
import '../utils/apptheme.dart';
import '../utils/constants.dart';

class CustomBottomNav extends StatefulWidget {
  final int? currentIndex;
  const CustomBottomNav({super.key, this.currentIndex});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int currentIndex = 0;
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
   // loadAddress();
    currentIndex = widget.currentIndex ?? 0;
    _handleNotificationNavigation();
  }
  void _handleNotificationNavigation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fcmService = Get.find<FCMService>();
      final intent = fcmService.pendingIntent;

      if (intent == null) return;

      try {
        if(intent.type == "order") {
          final order = await Get.find<OrderController>()
              .getOrderById(intent.params);


          Get.to(() => TrackOrderScreen(order: order));
        }else if (intent.type == "notification"){
          print("notification for offer");
          Get.to(() => const NotificationScreen(),);
        }
      } catch (e) {
        // Optional: log error
      } finally {
        fcmService.pendingIntent = null;
      }
    });
  }

  Future<void> loadAddress() async {
    await Get.find<AddressController>().loadAddresses();
  }
  final List<Widget> screens = [
    HomeScreen(),
    CouponSceen(isFromBottamNav: true),
    CutomerSupportScreen(),
    CartScreen(isFromBottamNav: true),
  ];

  Future<bool> _onWillPop() async {
    // If user is not on the first tab, go to home tab instead of quitting
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      return false;
    }

    // Handle double-back press
    final now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      lastBackPressed = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return false;
    }

    // Exit app on second back
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                nav_home,
                height: 30,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0 ? AppColors.primary : const Color(0x80000000),
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                nav_offer,
                height: 30,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? AppColors.primary : const Color(0x80000000),
                  BlendMode.srcIn,
                ),
              ),
              label: "Offer",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                nav_support,
                height: 30,
                colorFilter: ColorFilter.mode(
                  currentIndex == 2 ? AppColors.primary : const Color(0x80000000),
                  BlendMode.srcIn,
                ),
              ),
              label: "Support",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                nav_cart,
                height: 30,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3 ? AppColors.primary : const Color(0x80000000),
                  BlendMode.srcIn,
                ),
              ),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
