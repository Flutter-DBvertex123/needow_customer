// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/controllers/orderController.dart';
// import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
// import 'package:newdow_customer/features/orders/view/leave_review_screen.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../../../widgets/appbutton.dart';
//
// class TrackOrderScreen extends StatelessWidget {
//   OrderModel order;
//   TrackOrderScreen({Key? key,required this.order}) : super(key: key);
//   final orderTrackingCon = Get.find<OrderController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           alignment: Alignment.center,
//           height: 0.1.toHeightPercent(),
//
//           child: Appbutton(buttonText: "Continue Shopping", onTap: () => Get.to(LeaveReviewScreen()), isLoading: false),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           slivers: [
//             DefaultAppBar(titleText: "Track Order",isFormBottamNav: false,),
//             FutureBuilder(
//               future: orderTrackingCon.getTrackingData(order.id),
//               builder: (context, asyncSnapshot) {
//                 return SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Content
//                         SizedBox(
//                           height: 0.72.toHeightPercent(),
//                           width: 1.toWidthPercent(),
//                           child: ListView.separated(
//                             itemBuilder: (context, index) {
//                               final itemCount = order.items.length;
//
//                               // 🧾 1️⃣ Order Status Section
//                               if (index == itemCount) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: const BoxDecoration(color: Colors.white),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Status',
//                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                       ),
//                                       const SizedBox(height: 24),
//
//                                       _buildStatusItem('Order Placed', '10:00 AM', Icons.receipt_long, false, false),
//                                       _buildStatusItem('In Progress', '10:05 AM', Icons.inventory_2_outlined, false, false),
//                                       _buildStatusItem('Picked Up', 'Expected on 10:45 AM', Icons.local_shipping_outlined, false, false),
//                                       _buildStatusItem('Delivered', '10:48 AM', Icons.check_circle_outline, false, true),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 📦 2️⃣ Order Details Section
//                               else if (index == itemCount + 1) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Details',
//                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                       ),
//                                       const SizedBox(height: 16),
//                                       _buildDetailRow('Expected Delivery Time', '10:50 AM'),
//                                       const SizedBox(height: 12),
//                                       _buildDetailRow('Tracking ID', '356144228732'),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 👤 3️⃣ Delivery Partner Section
//                               else if (index == itemCount + 2) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: const BoxDecoration(color: Colors.white),
//                                   child: Row(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 28,
//                                         backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=33'),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             const Text(
//                                               'Michael Smith',
//                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             const Text('Delivery Partner',
//                                                 style: TextStyle(fontSize: 14, color: Colors.grey)),
//                                             const SizedBox(height: 4),
//                                             Row(
//                                               children: const [
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star_half, color: Colors.amber, size: 16),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.phone, color: Colors.white, size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.chat_bubble, color: Colors.white, size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 🛒 Otherwise, return order items
//                               else {
//                                 return orderItem(order,index);
//                               }
//                             },
//                             separatorBuilder: (context, index) => Divider(
//                               height: 2,
//                               color: AppColors.primary.withValues(alpha: 0.5),
//                             ),
//                             itemCount: order.items.length + 3,
//                           )
//
//                           /*ListView.separated(
//                               itemBuilder: (context,index){
//                               if(index == 8-3){
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Status',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 24),
//
//                                       // Status Timeline
//                                       _buildStatusItem(
//                                         'Order Placed',
//                                         '10:00 AM',
//                                         Icons.receipt_long,
//                                         false,
//                                         false,
//                                       ),
//                                       _buildStatusItem(
//                                         'In Progress',
//                                         '10:05 AM',
//                                         Icons.inventory_2_outlined,
//                                         false,
//                                         false,
//                                       ),
//                                       _buildStatusItem(
//                                         'Picked Up',
//                                         'Expected on 10:45 AM',
//                                         Icons.local_shipping_outlined,
//                                         false,
//                                         false,
//                                       ),
//                                       _buildStatusItem(
//                                         'Delivered',
//                                         '10:48 AM',
//                                         Icons.check_circle_outline,
//                                         false,
//                                         true,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }if(index == 8-2){
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Details',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16),
//                                       _buildDetailRow('Expected Delivery Time', '10:50 AM'),
//                                       const SizedBox(height: 12),
//                                       _buildDetailRow('Tracking ID', '356144228732'),
//                                     ],
//                                   ),
//                                 );
//                               }if(8-1 == index){
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                        CircleAvatar(
//                                         radius: 28,
//                                         backgroundImage: NetworkImage(
//                                           'https://i.pravatar.cc/150?img=33',
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Michael Smith',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             SizedBox(height: 4),
//                                             Text(
//                                               'Delivery Partner',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                             SizedBox(height: 4),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star, color: Colors.amber, size: 16),
//                                                 Icon(Icons.star_half, color: Colors.amber, size: 16),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.phone, color: Colors.white, size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.chat_bubble, color: Colors.white, size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }else{
//                                 return orderItem(index);
//                               }
//
//                               }, separatorBuilder: (context,index){
//                                 return Divider(height: 2,color: AppColors.primary.withValues(alpha: 0.5),);
//                           },
//                               itemCount: order.items.length+3
//                           ),*/
//                         ),
//                         // Product Card
//                         const SizedBox(height: 12),
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             )
//           ],
//
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }
//
//   /*Widget _buildStatusItem(
//       String title,
//       String time,
//       IconData icon,
//       bool isCompleted,
//       bool isLast,
//       ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 isCompleted ? Icons.check : icon,
//                 color: isCompleted ? Colors.white : AppColors.secondary,
//                 size: 16,
//               ),
//             ),
//             if (!isLast)
//               Container(
//                 width: 2,
//                 height: 50,
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//               ),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: isCompleted ? Colors.black : Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   time,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (isCompleted && !isLast)
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.primary,
//               size: 18,
//             ),
//           ),
//       ],
//     );
//   }*/
//   Widget _buildStatusItem(
//       String title,
//       String time,
//       IconData icon,
//       bool isCompleted,
//       bool isLast,
//       ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 isCompleted ? Icons.check : icon,
//                 color: isCompleted ? Colors.white : AppColors.secondary,
//                 size: 16,
//               ),
//             ),
//             if (!isLast)
//               Container(
//                 width: 2,
//                 height: 50,
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//               ),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 time,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (isCompleted && !isLast)
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.primary,
//               size: 18,
//             ),
//           ),
//       ],
//     );
//   }
//   Widget orderItem(OrderModel order,int index) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.black.withOpacity(0.05),
//         //     blurRadius: 10,
//         //     offset: const Offset(0, 2),
//         //   ),
//         // ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               order.items[index].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   order.items[index].name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   order.items[index].itemModel,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                  Text(
//                   '${order.items[index].quantity}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/controllers/orderController.dart';
// import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
// import 'package:newdow_customer/features/orders/view/leave_review_screen.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../../../widgets/appbutton.dart';
//
// class TrackOrderScreen extends StatelessWidget {
//   OrderModel order;
//   TrackOrderScreen({Key? key, required this.order}) : super(key: key);
//   final orderTrackingCon = Get.find<OrderController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           alignment: Alignment.center,
//           height: 0.1.toHeightPercent(),
//           child: Appbutton(
//               buttonText: "Continue Shopping",
//               onTap: () => Get.to(LeaveReviewScreen()),
//               isLoading: false),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           slivers: [
//             DefaultAppBar(
//               titleText: "Track Order",
//               isFormBottamNav: false,
//             ),
//             FutureBuilder(
//               future: orderTrackingCon.getTrackingData(order.id),
//               builder: (context, asyncSnapshot) {
//                 if (asyncSnapshot.connectionState == ConnectionState.waiting) {
//                   return SliverToBoxAdapter(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                     ),
//                   );
//                 }
//
//                 if (asyncSnapshot.hasError) {
//                   return SliverToBoxAdapter(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('Error: ${asyncSnapshot.error}'),
//                       ),
//                     ),
//                   );
//                 }
//
//                 final trackingData = asyncSnapshot.data;
//
//                 return SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Content
//                         SizedBox(
//                           height: 0.72.toHeightPercent(),
//                           width: 1.toWidthPercent(),
//                           child: ListView.separated(
//                             itemBuilder: (context, index) {
//                               final itemCount = order.items.length;
//
//                               // 🧾 1️⃣ Order Status Section
//                               if (index == itemCount) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration:
//                                   const BoxDecoration(color: Colors.white),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Status',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       const SizedBox(height: 24),
//                                       // Build timeline from trackingData
//                                       if (trackingData != null &&
//                                           trackingData.data.timeline
//                                               .isNotEmpty)
//                                         ...List.generate(
//                                           trackingData.data.timeline.length,
//                                               (timelineIndex) {
//                                             final timelineEvent = trackingData
//                                                 .data.timeline[timelineIndex];
//                                             final isLast = timelineIndex ==
//                                                 trackingData.data.timeline
//                                                     .length -
//                                                     1;
//                                             final isCompleted = true;
//                                             final icon = _getIconForStatus(
//                                                 timelineEvent.status);
//
//                                             return _buildStatusItem(
//                                               timelineEvent.note,
//                                               _formatDate(
//                                                   timelineEvent.timestamp),
//                                               icon,
//                                               isCompleted,
//                                               isLast,
//                                             );
//                                           },
//                                         )
//                                       else
//                                         _buildStatusItem('Order Placed',
//                                             '10:00 AM', Icons.receipt_long,
//                                             false, false),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 📦 2️⃣ Order Details Section
//                               else if (index == itemCount + 1) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Order Details',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       const SizedBox(height: 16),
//                                       _buildDetailRow(
//                                         'Expected Delivery Time',
//                                         trackingData != null
//                                             ? _formatDate(trackingData
//                                             .data.estimatedDeliveryTime)
//                                             : '10:50 AM',
//                                       ),
//                                       const SizedBox(height: 12),
//                                       _buildDetailRow(
//                                         'Tracking ID',
//                                         order.id ?? '356144228732',
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 👤 3️⃣ Delivery Partner Section
//                               else if (index == itemCount + 2) {
//                                 final deliveryAgent =
//                                     trackingData?.data.deliveryAgent;
//
//                                 return Container(
//                                   padding: const EdgeInsets.all(16),
//                                   decoration:
//                                   const BoxDecoration(color: Colors.white),
//                                   child: deliveryAgent != null
//                                       ? Row(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 28,
//                                         backgroundImage: NetworkImage(
//                                             'https://i.pravatar.cc/150?img=33'),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               deliveryAgent.name,
//                                               style: const TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight:
//                                                   FontWeight.w600),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             const Text(
//                                                 'Delivery Partner',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.grey)),
//                                             const SizedBox(height: 4),
//                                             Row(
//                                               children: const [
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star_half,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.phone,
//                                               color: Colors.white,
//                                               size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(
//                                               Icons.chat_bubble,
//                                               color: Colors.white,
//                                               size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                       : Row(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 28,
//                                         backgroundImage: NetworkImage(
//                                             'https://i.pravatar.cc/150?img=33'),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             const Text(
//                                               'Michael Smith',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight:
//                                                   FontWeight.w600),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             const Text(
//                                                 'Delivery Partner',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.grey)),
//                                             const SizedBox(height: 4),
//                                             Row(
//                                               children: const [
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                                 Icon(Icons.star_half,
//                                                     color: Colors.amber,
//                                                     size: 16),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(Icons.phone,
//                                               color: Colors.white,
//                                               size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: IconButton(
//                                           icon: const Icon(
//                                               Icons.chat_bubble,
//                                               color: Colors.white,
//                                               size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//
//                               // 🛒 Otherwise, return order items
//                               else {
//                                 return orderItem(order, index);
//                               }
//                             },
//                             separatorBuilder: (context, index) => Divider(
//                               height: 2,
//                               color: AppColors.primary.withValues(alpha: 0.5),
//                             ),
//                             itemCount: order.items.length + 3,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatusItem(
//       String title,
//       String time,
//       IconData icon,
//       bool isCompleted,
//       bool isLast,
//       ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 isCompleted ? Icons.check : icon,
//                 color: isCompleted ? Colors.white : AppColors.secondary,
//                 size: 16,
//               ),
//             ),
//             if (!isLast)
//               Container(
//                 width: 2,
//                 height: 50,
//                 color: isCompleted ? AppColors.primary : AppColors.secondary,
//               ),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 time,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (isCompleted && !isLast)
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.primary,
//               size: 18,
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget orderItem(OrderModel order, int index) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               order.items[index].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   order.items[index].name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   order.items[index].itemModel,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${order.items[index].quantity}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Format date from ISO string to readable format
//   String _formatDate(String dateString) {
//     try {
//       final dateTime = DateTime.parse(dateString);
//       return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
//     } catch (e) {
//       return dateString;
//     }
//   }
//
//   /// Get icon based on status
//   IconData _getIconForStatus(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Icons.receipt_long;
//       case 'confirmed':
//         return Icons.inventory_2_outlined;
//       case 'picked up':
//       case 'pickedup':
//         return Icons.local_shipping_outlined;
//       case 'delivered':
//         return Icons.check_circle_outline;
//       default:
//         return Icons.receipt_long;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
import 'package:newdow_customer/features/orders/model/models/orderTrackingModel.dart';
import 'package:newdow_customer/features/orders/view/leave_review_screen.dart';
import 'package:newdow_customer/features/orders/view/widget/orderCancelDialog.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/navbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackOrderScreen extends StatelessWidget {
  final OrderModel order;
  final orderTrackingCon = Get.find<OrderController>();

  TrackOrderScreen({super.key, required this.order});
  final controller = Get.find<LoadingController>();
  final finalStatuses = ['delivered', 'cancelled', 'rejected', 'refunded'];
  @override
  Widget build(BuildContext context) {
debugPrint("Order Status: ${order.status}");
    return Scaffold(

      bottomNavigationBar: SafeArea(
        child: _buildBottomBar(context),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
             DefaultAppBar(
              titleText: "Track Order",
              isFormBottamNav: false,
            ),
            FutureBuilder(
              future: orderTrackingCon.getTrackingData(order.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoading();
                }

                if (snapshot.hasError) {
                  return _buildError(snapshot.error);
                }

                final trackingData = snapshot.data;
                return _buildTrackingBody(trackingData);
              },
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------
  // 🧩 UI BUILDERS
  // -----------------------------

/*  Widget _buildBottomBar(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: Color(0xFFF9F9F9),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, -2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    alignment: Alignment.center,
    height: (finalStatuses.contains(order.status)) ? 0.09.toHeightPercent() :0.18.toHeightPercent(),
    child: Column(
      children: [
        Appbutton(
          buttonText: "Continue Shopping",
          onTap: () => Get.to(() => LeaveReviewScreen(order: order,)),
        ),
        (finalStatuses.contains(order.status)) ? SizedBox.shrink():SizedBox(height: 16,),

          ((finalStatuses.contains(order.status)) && order.status != "pending" )? SizedBox.shrink() : Obx(() => InkWell(
              onTap:  ()  {
                showOrderCancelDialog(
                  context,
                  orderId: order!.id,
                  onCancelOrder: () async {
                    final response =   orderTrackingCon.updateOrderStatus(order.id!, 'cancelled','cancelled by user');
                    await response ? AppSnackBar.showSuccess(context,message:  'Order cancelled successfully')
                        : AppSnackBar.showError(context, message: 'Failed to cancel order');
                  },
                  onSkip: () {
                    Navigator.of(context).pop();
                  },
                );

                // final response =  await orderTrackingCon.updateOrderStatus(order.id!, 'cancelled','cancelled by user');
                // response ? AppSnackBar.showSuccess(context,message:  'Order cancelled successfully')
                //    : AppSnackBar.showError(context, message: 'Failed to cancel order');

              },
              child: Container(
                height: 58,
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 0.8.toWidthPercent(),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(27),
                ),
                child: controller.isLoading?.value ?? false
                    ? CircularProgressIndicator(color: Colors.white)
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cancel Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

      ],
    ),
  );*/
  Widget _buildBottomBar(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: Color(0xFFF9F9F9),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, -2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    alignment: Alignment.center,
    height: (order.status.toLowerCase() == 'pending') ? 0.18.toHeightPercent() : 0.09.toHeightPercent(), // ✅ Changed condition
    child: Column(
      children: [
        Appbutton(
          buttonText: "Continue Shopping",
          onTap: () => (finalStatuses == order.status) ? Get.to(() => LeaveReviewScreen(order: order,)) : Get.offAll(() => CustomBottomNav(currentIndex: 0))
        ),

        // ✅ Only show spacing and button if status is pending
        if (order.status.toLowerCase() == 'pending') ...[
          SizedBox(height: 16,),
          Obx(() => InkWell(
            onTap: () {
              showOrderCancelDialog(
                context,
                orderId: order!.id,
                onCancelOrder: () async {
                  final response = orderTrackingCon.updateOrderStatus(
                      order.id!, 'cancelled', 'cancelled by user');
                  await response
                      ? AppSnackBar.showSuccess(context, message: 'Order cancelled successfully')
                      : AppSnackBar.showError(context, message: 'Failed to cancel order');
                },
                onSkip: () {
                  Navigator.of(context).pop();
                },
              );
            },
            child: Container(
              height: 58,
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minWidth: 0.8.toWidthPercent(),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(27),
              ),
              child: controller.isLoading?.value ?? false
                  ? CircularProgressIndicator(color: Colors.white)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cancel Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
        ],
      ],
    ),
  );
  Widget _buildLoading() => const SliverToBoxAdapter(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    ),
  );

  Widget _buildError(Object? error) => SliverToBoxAdapter(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Error: $error'),
      ),
    ),
  );

  Widget _buildTrackingBody(OrderTrackingModel? trackingData) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: (finalStatuses.contains(order.status))? 0.76.toHeightPercent(): 0.68.toHeightPercent(),
        width: 1.toWidthPercent(),
        child: ListView.separated(
          itemCount: order.items.length + 3,
          separatorBuilder: (context, index) => Divider(
            height: 2,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          itemBuilder: (context, index) {
            final itemCount = order.items.length;

            if (index == itemCount+ 1) return _buildOrderStatus(trackingData);
            if (index == itemCount ) return _buildOrderDetails(trackingData);
            if (index == itemCount + 2) return _buildDeliveryPartner(trackingData);

            return _buildOrderItem(index);
          },
        ),
      ),
    ),
  );

  // -----------------------------
  // 🧾 SECTIONS
  // -----------------------------

  Widget _buildOrderStatus(OrderTrackingModel? trackingData) => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Status',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 24),
        if (trackingData != null && trackingData.data.timeline.isNotEmpty)
          ..._buildAllMilestones(trackingData.data.timeline)
        else
          _buildStatusItem(
            'Order Created',
            '10:00 AM',
            Icons.receipt_long,
            false,
            false,
            'pending',
          ),
      ],
    ),
  );

  Widget _buildOrderDetails(OrderTrackingModel? trackingData) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        // _buildDetailRow(
        //   'Expected Delivery Time',
        //   trackingData != null
        //       ? _formatDate(trackingData.data.estimatedDeliveryTime)
        //       : '10:50 AM',
        // ),
        const SizedBox(height: 12),
        _buildDetailRow('Order ID', order.orderNumber ?? 'N/A'),
        _buildDetailRow('Delivery Charges', "₹${order.deliveryFee.toStringAsFixed(2)}" ?? 'N/A'),
        _buildDetailRow('Platform fee', "₹${order.tax.toStringAsFixed(2)}" ?? 'N/A'),
        _buildDetailRow('Subtotal', "₹${order.subtotal.toStringAsFixed(2)}" ?? 'N/A'),
      ],
    ),
  );

  Widget _buildDeliveryPartner(OrderTrackingModel? trackingData) {
    final deliveryAgent = trackingData?.data.deliveryAgent;
    if (deliveryAgent == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=33'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deliveryAgent.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('Delivery Partner',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    4,
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                  )..add(const Icon(Icons.star_half, color: Colors.amber, size: 16)),
                ),
              ],
            ),
          ),
          ..._buildPartnerActions(deliveryAgent),
        ],
      ),
    );
  }

  List<Widget> _buildPartnerActions(DeliveryAgent deliveryAgent) => [
    _circleIcon(Icons.phone,deliveryAgent),
    const SizedBox(width: 8),
    _SMSIcon(Icons.chat_bubble,deliveryAgent),
  ];

  Widget _circleIcon(IconData icon,DeliveryAgent agent) => Container(
    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
    child: IconButton(
      icon: Icon(icon, color: Colors.white, size: 20),
      onPressed: () => openDialer(agent.phone)
    ),
  );Widget _SMSIcon(IconData icon,DeliveryAgent agent) => Container(
    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
    child: IconButton(
      icon: Icon(icon, color: Colors.white, size: 20),
      onPressed: () => openSmsApp(agent.phone,),
    ),
  );

  Widget _buildOrderItem(int index) => Container(
    padding: const EdgeInsets.all(12),
    color: Colors.white,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            order.items[index].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.items[index].name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(order.items[index].itemModel,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text('${order.items[index].quantity}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildDetailRow(String label, String value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      Text(value,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
    ],
  );

  // -----------------------------
  // 🧠 LOGIC
  // -----------------------------

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
      final ampm = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '${hour}:${dateTime.minute.toString().padLeft(2, '0')} $ampm';
    } catch (_) {
      return dateString;
    }
  }

  IconData _getIconForStatus(String status) {
    final s = status.toLowerCase().replaceAll('_', '');
    switch (s) {
      case 'pending':
        return Icons.receipt_long;
      case 'confirmed':
      case 'preparing':
      case 'ready':
        return Icons.inventory_2_outlined;
      case 'pickedup':
      case 'outfordelivery':
        return Icons.local_shipping_outlined;
      case 'delivered':
        return Icons.check_circle_outline;
      case 'cancelled':
        return Icons.cancel_outlined;
      case 'rejected':
        return Icons.highlight_off;
      case 'refunded':
        return Icons.assignment_return_outlined;
      default:
        return Icons.receipt_long;
    }
  }

  List<Widget> _buildAllMilestones(List<TimelineEvent> timeline) {
    final milestones = [
      {'statuses': ['pending'], 'label': 'Order Created', 'icon': Icons.receipt_long},
      {
        'statuses': ['confirmed', 'preparing', 'ready'],
        'label': 'In Progress',
        'icon': Icons.inventory_2_outlined
      },
      {
        'statuses': ['picked_up', 'out_for_delivery'],
        'label': 'Picked Up',
        'icon': Icons.local_shipping_outlined
      },
      {
        'statuses': ['delivered', 'cancelled', 'rejected', 'refunded'],
        'label': 'Delivered',
        'icon': Icons.check_circle_outline
      },
    ];

    final widgets = <Widget>[];

    for (var i = 0; i < milestones.length; i++) {
      final m = milestones[i];
      final label = m['label'] as String;
      final icon = m['icon'] as IconData;
      final statuses = (m['statuses'] as List<String>)
          .map((e) => e.toLowerCase().replaceAll('_', ''))
          .toList();

      final event = timeline.firstWhereOrNull(
            (e) => statuses.contains(e.status.toLowerCase().replaceAll('_', '')),
      );

      final isCompleted = event != null;
      final time = isCompleted ? _formatDate(event!.timestamp) : '-';
      final note = event?.note ?? '';
      final status = event?.status ?? '';
      final isFinal = statuses.any((s) =>
          ['delivered', 'cancelled', 'rejected', 'refunded'].contains(s));

      widgets.add(
        _buildStatusItem(
          note.isNotEmpty ? note : label,
          time,
          icon,
          isCompleted,
          i == milestones.length - 1 || (isFinal && isCompleted),
          status,
        ),
      );
    }

    return widgets;
  }

  Widget _buildStatusItem(String title, String time, IconData icon,
      bool isCompleted, bool isLast, String status) {
    final s = status.toLowerCase().replaceAll('_', '');
    final isError = ['cancelled', 'rejected', 'refunded'].contains(s);

    final circleColor = isError
        ? Colors.red
        : (isCompleted ? AppColors.primary : Colors.grey[300]!);
    final lineColor = circleColor;
    final textColor = isError
        ? Colors.red
        : (isCompleted ? AppColors.textPrimary : Colors.grey);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            if (!isLast)
              Container(width: 2, height: 50, color: lineColor),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColor)),
              const SizedBox(height: 4),
              Text(time, style: TextStyle(fontSize: 13, color: textColor)),
            ],
          ),
        ),
        Icon(icon, color: isCompleted ? AppColors.primary : Colors.grey, size: 20),
      ],
    );
  }
  Future<void> openDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not open dialer';
    }
  }

  Future<void> openSmsApp(String phoneNumber, {String? message}) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null
          ? {'body': message}
          : null,
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not open SMS app';
    }
  }

  /// Cnacel Order Dialog
  void showOrderCancelDialog(
      BuildContext context, {
        required String orderId,
        required VoidCallback onCancelOrder,
        VoidCallback? onSkip,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OrderCancelDialog(
          orderId: orderId,
          onCancelOrder: onCancelOrder,
          onSkip: onSkip ?? () {},
        );
      },
    );
  }
}
