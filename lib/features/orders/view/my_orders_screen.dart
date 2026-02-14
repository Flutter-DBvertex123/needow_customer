// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/controllers/orderController.dart';
// import 'package:newdow_customer/features/orders/view/view_order_screen.dart';
// import 'package:newdow_customer/features/profile/view/widgets/orderCard.dart';
// import 'package:newdow_customer/features/profile/view/widgets/orderList_shimmer_widget.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../orders/model/models/orderModel.dart';
//
// class MyOrdersScreen extends StatefulWidget {
//   bool? isFormBottamNav;
//    MyOrdersScreen({super.key,this.isFormBottamNav});
//
//   @override
//   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// }
//
// class _MyOrdersScreenState extends State<MyOrdersScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
// final orderController  = Get.find<OrderController>();
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        /*AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "My Orders",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.green,
//           labelColor: Colors.green,
//           unselectedLabelColor: Colors.black,
//           tabs: const [
//             Tab(text: "Active"),
//             Tab(text: "Completed"),
//             Tab(text: "Cancelled"),
//           ],
//         ),
//       ),*/
//       // body: SafeArea(
//       //   top: false,
//       //   child: CustomScrollView(
//       //     physics: NeverScrollableScrollPhysics(),
//       //     slivers: [
//       //     SliverAppBar(
//       //     leadingWidth: 75,
//       //     systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.background,
//       //     ),
//       //     toolbarHeight: 0.1.toHeightPercent(),
//       //     surfaceTintColor: AppColors.background,
//       //     title: Column(
//       //       children: [
//       //         Text("My Orders",style: TextStyle(fontSize: 22),),
//       //
//       //       ],
//       //     ),
//       //     leading: Padding(
//       //       padding: EdgeInsets.only(left: 16),
//       //       child: IconButton(
//       //         onPressed: () => Navigator.pop(context),
//       //         icon: CircleAvatar(
//       //           backgroundColor: AppColors.secondary,
//       //           radius: 30,
//       //           child: Icon(
//       //             Icons.arrow_back_sharp,
//       //             color: Colors.green,
//       //             size: 25,
//       //             weight: 800,
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //
//       //
//       //     // Provide a standard title.
//       //     centerTitle: true,
//       //     // Pin the app bar when scrolling.
//       //     pinned: true,
//       //     // Display a placeholder widget to visualize the shrinking size.
//       //     // Make the initial height of the SliverAppBar larger than normal.
//       //     collapsedHeight: 0.1.toHeightPercent(),
//       //       bottom: TabBar(
//       //         controller: _tabController,
//       //         indicatorColor: AppColors.primary,
//       //         labelColor: AppColors.primary,
//       //         unselectedLabelColor: Colors.black,
//       //         dividerColor: AppColors.primary.withValues(alpha: 0.5),
//       //         dividerHeight: 2,
//       //         indicatorSize: TabBarIndicatorSize.tab,
//       //         indicatorWeight: 4,
//       //         padding: EdgeInsets.symmetric(horizontal: 16),
//       //         tabs: const [
//       //           Tab(text: "Active"),
//       //           Tab(text: "Completed"),
//       //           Tab(text: "Cancelled"),
//       //         ],
//       //       ),
//       //   ),
//       //       SliverToBoxAdapter(
//       //         child: SizedBox(
//       //           height: 0.8.toHeightPercent(),
//       //           width: 1.toWidthPercent(),
//       //           // child: FutureBuilder<List<OrderModel>>(
//       //           //   future: _getOrders(),
//       //           //   builder: (context, asyncSnapshot) {
//       //           //     if(!asyncSnapshot.hasData && asyncSnapshot.data!.isEmpty){
//       //           //       return Center(child: Text("Orders not available"),);
//       //           //     }if(asyncSnapshot.connectionState == ConnectionState.waiting){
//       //           //       return Center(child: CircularProgressIndicator(),);
//       //           //     }
//       //           //     return TabBarView(
//       //           //       controller: _tabController,
//       //           //       children: [
//       //           //         buildOrderList("Active", filterOrders(asyncSnapshot.data!, "Active")),
//       //           //         buildOrderList("Completed", filterOrders(asyncSnapshot.data!, "Completed")),
//       //           //         buildOrderList("Cancelled", filterOrders(asyncSnapshot.data!, "Cancelled")),
//       //           //       ],
//       //           //     );
//       //           //   }
//       //           // ),
//       //           child: FutureBuilder<List<OrderModel>>(
//       //             future: _getOrders(),
//       //             builder: (context, asyncSnapshot) {
//       //
//       //               // 🔹 1. Loading
//       //               if (asyncSnapshot.connectionState == ConnectionState.waiting) {
//       //                 //return Center(child: CircularProgressIndicator());
//       //                 return OrderlistShimmerWidget();
//       //               }
//       //
//       //               // 🔹 2. Error
//       //               if (asyncSnapshot.hasError) {
//       //                 return Center(child: Text("Failed to load orders"));
//       //               }
//       //
//       //               // 🔹 3. No orders
//       //               if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
//       //                 return Center(child: Text("Orders not available"));
//       //               }
//       //
//       //               // 🔹 4. Success
//       //               return TabBarView(
//       //                 controller: _tabController,
//       //                 children: [
//       //                   buildOrderList("Active", filterOrders(asyncSnapshot.data!, "Active")),
//       //                   buildOrderList("Completed", filterOrders(asyncSnapshot.data!, "Completed")),
//       //                   buildOrderList("Cancelled", filterOrders(asyncSnapshot.data!, "Cancelled")),
//       //                 ],
//       //               );
//       //             },
//       //           )
//       //         ),
//       //       )
//       //     ],
//       //
//       //   ),
//       // ),
//       body: SafeArea(
//           top: false,
//           child: CustomScrollView(
//             slivers: [
//               DefaultAppBar(titleText: "My Orders", isFormBottamNav: false),
//               SliverToBoxAdapter(
//                  child:Padding(
//                    padding: const EdgeInsets.all(12.0),
//                    child: FutureBuilder<List<OrderModel>>(
//                         future: _getOrders(),
//                         builder: (BuildContext context, AsyncSnapshot snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                            //return Center(child: CircularProgressIndicator());
//                              return OrderlistShimmerWidget();
//                           }
//
//                           // 🔹 2. Error
//                           if (snapshot.hasError) {
//                           return Center(child: Text("Failed to load orders"));
//                         }
//
//                         // 🔹 3. No orders
//                           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           return Center(child: Text("Orders not available"));
//                         }
//                           return Container(
//
//                             height: 0.9.toHeightPercent(),
//                             child: ListView.separated(
//                                 itemBuilder: (context,index){
//                                   return orderCardWidget(order:  snapshot.data[index]);
//                                 },
//                                 separatorBuilder: (context, index) =>  Divider(height: 5, color: AppColors.primary.withValues(alpha: 0.5)),
//
//                                 itemCount: snapshot.data.length
//                             ),
//                           );
//                    }),
//                  )
//               )
//             ],
//           )),
//     );
//   }
//
//   Widget buildOrderList(String type,List<OrderModel> orders) {
//     return SizedBox(
//       height: 0.7.toHeightPercent(),
//       width: 1.toWidthPercent(),
//       child: ListView.separated(
//         padding: const EdgeInsets.all(12),
//         itemCount: orders.length,
//         separatorBuilder: (context, index) =>  Divider(height: 5, color: AppColors.primary.withValues(alpha: 0.5)),
//         itemBuilder: (context, index) {
//           // return orderCard(
//           //   context,
//           //   // orders[index].items[0].image[0], // basket image
//           //   //  orders[index].orderNumber,
//           //   //  orders[index].status,
//           //   //  orders[index].totalAmount.toString(),
//           //   orders[index],
//           //    type == "Cancelled"
//           // );
//           return SizedBox();
//         },
//       ),
//     );
//   }
//
//
//   // Widget orderCard(BuildContext context,OrderModel order,bool showReorder) {
//   //   String itemNames = order.items
//   //       .take(2)
//   //       .map((e) => e.name)
//   //       .join(", ");
//   //
//   //   if (order.items.length > 2) {
//   //     itemNames += " +${order.items.length - 2} more";
//   //   }
//   //
//   //   // 2nd Line: Total quantity
//   //   int totalQty = order.items.fold(0, (sum, item) => sum + item.quantity);
//   //
//   //   // Order type
//   //   String orderType = order.orderType.capitalize!;
//   //
//   //
//   //   return InkWell(
//   //     onTap: () => Get.to(ViewOrderScreen(order : order)),
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(12),
//   //       child: Row(
//   //         children: [
//   //           Container(
//   //             padding: EdgeInsets.all(2),
//   //             height: 0.12.toHeightPercent(),
//   //             width: 0.25.toWidthPercent(),
//   //             decoration: BoxDecoration(
//   //               color: Color(0xFFEBEBEB),
//   //               borderRadius: BorderRadius.circular(8),
//   //             ),
//   //             child: ClipRRect(
//   //               borderRadius: BorderRadius.circular(8),
//   //               child: Image.network(
//   //                 order.items[0].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
//   //                 width: 80,
//   //                 height: 80,
//   //                 fit: BoxFit.cover,
//   //                 errorBuilder: (_, __, ___) => Container(
//   //                   height: 80,
//   //                   width: 80,
//   //                   color: Colors.grey[300],
//   //                   child: Icon(Icons.broken_image, color: Colors.red),),
//   //               ),
//   //             ),
//   //           ),
//   //           const SizedBox(width: 12),
//   //           Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text(itemNames,
//   //                     style: const TextStyle(
//   //                         fontWeight: FontWeight.bold, fontSize: 15)),
//   //                 const SizedBox(height: 4),
//   //                 Text("$orderType | Qty: $totalQty pcs", style: TextStyle(fontSize: 12)),
//   //                 const SizedBox(height: 4),
//   //                 Text("₹${order.totalAmount.toString()}",
//   //                     style: const TextStyle(
//   //                         fontWeight: FontWeight.bold, fontSize: 15)),
//   //               ],
//   //             ),
//   //           ),
//   //           if (showReorder)
//   //             Container(
//   //               height: 100,
//   //               alignment: Alignment.bottomCenter,
//   //               child: ElevatedButton(
//   //                 onPressed: () {},
//   //                 style: ElevatedButton.styleFrom(
//   //                   maximumSize: Size(100, 60),
//   //                   backgroundColor: AppColors.primary,
//   //                   padding:
//   //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(8),
//   //                   ),
//   //                 ),
//   //                 child: const Text("Re-order",style: TextStyle(color: Colors.white),),
//   //               ),
//   //             ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   // List<OrderModel> filterOrders(List<OrderModel> orders, String type) {
//   //   if (type == "Active") {
//   //     return orders.where((o) =>
//   //     o.status == "pending" ||
//   //         o.status == "confirmed" ||
//   //         o.status == "preparing" ||
//   //         o.status == "ready" ||
//   //         o.status == "picked_up" ||
//   //         o.status == "out_for_delivery"
//   //     ).toList();
//   //   }
//   //
//   //   if (type == "Completed") {
//   //     return orders.where((o) => o.status == "delivered").toList();
//   //   }
//   //
//   //   if (type == "Cancelled") {
//   //     return orders.where((o) =>
//   //     o.status == "cancelled" ||
//   //         o.status == "rejected" ||
//   //         o.status == "refunded"
//   //     ).toList();
//   //   }
//   //
//   //   return [];
//   // }
//   List<Order> filterOrders(List<Order> orders, String type) {
//     if (type == "Placed") {
//       return orders.where((o) =>
//       o.status == "pending" ||
//           o.status == "confirmed" ||
//           o.status == "preparing" ||
//           o.status == "ready" ||
//           o.status == "picked_up" ||
//           o.status == "out_for_delivery"
//       ).toList();
//     }
//
//     if (type == "Delivered") {
//       return orders.where((o) => o.status == "delivered").toList();
//     }
//
//     if (type == "Cancelled") {
//       return orders.where((o) =>
//       o.status == "cancelled" ||
//           o.status == "rejected" ||
//           o.status == "refunded"
//       ).toList();
//     }
//
//     return [];
//   }
//
//   Future<List<OrderModel>> _getOrders() async {
//     String userId = await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? "");
//     print("getting oreder");
//     final data = await orderController.getUsersOrder(userId: userId);
//     print('data onscreen :- ${data.length}');
//     return data;
//   }
//   Widget orderCardWidget({
//     required OrderModel order,
//     VoidCallback? onReorder,
//   }) {
//     return InkWell(
//       onTap: () => Get.to(() => ViewOrderScreen(order: order)),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Product Image
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 height: 90,
//                 width: 90,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEBEBEB),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     order.items[0].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       color: Colors.grey[300],
//                       child: const Icon(
//                         Icons.broken_image,
//                         color: Colors.red,
//                         size: 40,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//
//               // Order Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Status with Icon
//                     Row(
//                       children: [
//                         Icon(
//                           _getStatusIcon(order.status),
//                           color: _getStatusColor(order.status),
//                           size: 18,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           order.status,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: _getStatusColor(order.status),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//
//                     // Date
//                     Text(
//                       order.createdAt.toString(),
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // Amount
//                     Text(
//                       "₹${order.totalAmount.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Next Arrow
//               Icon(
//                 Icons.navigate_next_outlined,
//                 color: Colors.grey[400],
//                 size: 24,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return const Color(0xFF00BFA5);
//       case 'cancelled':
//         return const Color(0xFFBDBDBD);
//       case 'pending':
//         return const Color(0xFFFFA726);
//       default:
//         return const Color(0xFF9E9E9E);
//     }
//   }
//
//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return Icons.check_circle;
//       case 'cancelled':
//         return Icons.cancel;
//       case 'pending':
//         return Icons.schedule;
//       default:
//         return Icons.info;
//     }
//   }
// }
//
//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/view/chekout_screen.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/orders/view/reorder_screen.dart';
import 'package:newdow_customer/features/orders/view/view_order_screen.dart';
import 'package:newdow_customer/features/profile/view/widgets/orderList_shimmer_widget.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/dateTime.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import '../../cart/model/models/cartModel.dart';
import '../model/models/orderModel.dart';

class MyOrdersScreen extends StatefulWidget {
  bool? isFormBottamNav;
  MyOrdersScreen({super.key, this.isFormBottamNav});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final orderController = Get.find<OrderController>();
  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "My Orders", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: FutureBuilder<List<OrderModel>>(
                future: _ordersFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 🔹 Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return OrderlistShimmerWidget();
                  }

                  // 🔹 Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Failed to load orders"),
                      ),
                    );
                  }

                  // 🔹 No orders
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Orders not available"),
                      ),
                    );
                  }

                  // 🔹 Success - Show all orders
                  return _buildAllOrders(snapshot.data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAllOrders(List<OrderModel> allOrders) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: allOrders.length,
          separatorBuilder: (context, index) => SizedBox(),
          itemBuilder: (context, index) {
            return _orderCardWidget(order: allOrders[index]);
          },
        ),
      ),
    );
  }

  // Widget _orderCardWidget({required OrderModel order}) {
  //   String orderStatusType = _getOrderStatusType(order.status);
  //
  //   return InkWell(
  //     onTap: () => Get.to(() => ViewOrderScreen(order: order)),
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 8,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Row(
  //           children: [
  //             // Product Image
  //             Container(
  //               padding: const EdgeInsets.all(8),
  //               height: 90,
  //               width: 90,
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFEBEBEB),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),
  //                 child: Image.network(
  //                   order.items[0].image[0]
  //                       .replaceAll(RegExp(r'[\[\]]'), ''),
  //                   fit: BoxFit.cover,
  //                   errorBuilder: (_, __, ___) => Container(
  //                     color: Colors.grey[300],
  //                     child: const Icon(
  //                       Icons.broken_image,
  //                       color: Colors.red,
  //                       size: 40,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 16),
  //             // Order Details
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Order Status Type (Placed, Delivered, Cancelled)
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         _getStatusIcon(orderStatusType),
  //                         color: _getStatusColor(orderStatusType),
  //                         size: 18,
  //                       ),
  //                       const SizedBox(width: 6),
  //                       Expanded(
  //                         child: Text(
  //                           orderStatusType,
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 14,
  //                             color: _getStatusColor(orderStatusType),
  //                           ),
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 6),
  //                   // Date
  //                   Text(
  //                     order.createdAt.toString(),
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   // Amount
  //                   Text(
  //                     "₹${order.totalAmount.toStringAsFixed(2)}",
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16,
  //                       color: Colors.black87,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // Next Arrow
  //             Icon(
  //               Icons.navigate_next_outlined,
  //               color: Colors.grey[400],
  //               size: 24,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _orderCardWidget({required OrderModel order}) {
    String orderStatusType = _getOrderStatusType(order.status);


    // 2nd Line: Total quantity
    int totalQty = order.items.fold(0, (sum, item) => sum + item.quantity);

    // Order type
    String orderType = order.orderType.capitalize!;
    return InkWell(
      onTap: () => Get.to(() => ViewOrderScreen(order: order)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Status with Icon, Amount, and Arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Order Status Type (Placed, Delivered, Cancelled)
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(orderStatusType),
                        color: _getStatusColor(orderStatusType),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        orderStatusType,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Amount and Arrow
                  Row(
                    spacing: 4,
                    children: [
                      Text(
                        "₹${order.totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.grey[400]!,
                        ),),
                        child: Icon(
                          Icons.navigate_next_outlined,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Date
              Text(
                "Placed at ${DateTimeUtils.formatDateTime(order.createdAt)}",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary
                ),
              ),
              const SizedBox(height: 12),
              // Product Image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBEBEB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            order.items[0].image[0]
                                .replaceAll(RegExp(r'[\[\]]'), ''),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 0.02.toWidthPercent(),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$totalQty pcs", style: TextStyle(fontSize: 12)),
                          Text("${order.items.length} Products", style: TextStyle(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                  if(orderStatusType == "Order Delivered" || orderStatusType == "Order Cancelled")
                  Container(
                    height: 100,
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        List <CartItem> cartItems = order.items.map((item) {
                          return CartItem(
                            id: item.id,
                            name: item.name,
                            quantity: item.quantity,
                            unitPrice: item.price,
                            discountPercent: 0,
                            lineTotal: item.price * item.quantity,
                            prescriptionUrl: ""
                          );
                        }).toList();
                        Get.to(() => ReorderScreen(order: order));
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(100, 60),
                        backgroundColor: AppColors.primary,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Re-order",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Filter order and return only the status type
  String _getOrderStatusType(String status) {
    if (status == "pending" ||
        status == "confirmed" ||
        status == "preparing" ||
        status == "ready" ||
        status == "picked_up" ||
        status == "out_for_delivery") {
      return "Order Placed";
    }

    if (status == "delivered") {
      return "Order Delivered";
    }

    if (status == "cancelled" ||
        status == "rejected" ||
        status == "refunded") {
      return "Order Cancelled";
    }

    return status;
  }

  Future<List<OrderModel>> _getOrders() async {
    String userId =
    await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? "");
    print("getting order");
    final data = await orderController.getUsersOrder(userId: userId);
    print('data onscreen :- ${data.length}');
    return data;
  }

  Color _getStatusColor(String statusType) {
    switch (statusType) {
      case 'Order Delivered':
        return AppColors.primary;
      case 'Order Cancelled':
        return const Color(0xFFD32F2F);
      case 'Order Placed':
        return const Color(0xFFFFA726);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData _getStatusIcon(String statusType) {
    switch (statusType) {
      case 'Order Delivered':
        return Icons.check_circle;
      case 'Order Cancelled':
        return Icons.cancel;
      case 'Order Placed':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

}