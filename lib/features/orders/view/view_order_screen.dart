//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/view/track_order_screen.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../model/models/orderModel.dart';
//
//
// class ViewOrderScreen extends StatefulWidget {
//   OrderModel order;
//    ViewOrderScreen({super.key,required this.order});
//
//   @override
//   State<ViewOrderScreen> createState() => _ViewOrderScreenState();
// }
//
// class _ViewOrderScreenState extends State<ViewOrderScreen> {
//   List<int> quantities = [1, 1, 1, 1];
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
//           height: 0.18.toHeightPercent(),
//
//           child: Column(
//             children: [
//               SizedBox(height: 8,),
//               Appbutton(buttonText: "Track Order", onTap: () => Get.to(TrackOrderScreen(order: widget.order,)), isLoading: false),
//               SizedBox(height: 8,),
//               Appbutton(buttonText: "Continue Shopping", onTap: (){
//                 //Get.to();
//               }, isLoading: false),
//             ],
//           ),
//         ),
//       ),
//
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back, color: Colors.black),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       //   title: const Text(
//       //     "My Cart",
//       //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       //   ),
//       // ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           slivers: [
//             DefaultAppBar(titleText: "Order Summary",isFormBottamNav: false,),
//             SliverToBoxAdapter(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: (0.8).toHeightPercent(),
//                     width: 1.toHeightPercent(),
//                     child: ListView.separated(
//                       padding: const EdgeInsets.all(12),
//                       itemCount: widget.order.items.length,
//                       separatorBuilder: (context,index){
//                         return Divider(
//                           height: 2,color: AppColors.primary.withValues(alpha: 0.5),
//                         );
//                       },
//                       itemBuilder: (context, index) {
//                         if(index == quantities.length-1){
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Total",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                                 Text("\₹${widget.order.totalAmount}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                               ],
//                             ),
//                           );
//                         }
//                         else if(index == quantities.length-2) {
//                           return Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               children: [
//                                 summaryRow("Order Date", "${widget.order.createdAt.year.toString()}:${widget.order.createdAt.month.toString()}:${widget.order.createdAt.day.toString()}"),
//                                 summaryRow("Order Id", widget.order.orderNumber),
//                                 summaryRow("Delivery fee", "\₹${widget.order.deliveryFee.toString()}"),
//                                 summaryRow("Subtotal", "\₹${widget.order.subtotal.toString()}"),
//
//                               ],
//                             ),
//                           );
//                         }
//                         return Card(
//                           elevation: 0,
//                           margin: const EdgeInsets.symmetric(vertical: 6),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     widget.order.items[index].image[0].replaceAll(RegExp(r'[\[\]]'), ''),
//                                     height: 60,
//                                     width: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(widget.order.items[index].name,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold, fontSize: 15)),
//                                     const SizedBox(height: 4),
//                                      Text(widget.order.items[index].itemModel, style: TextStyle(color: Colors.grey)),
//                                     const SizedBox(height: 2),
//                                      Text(widget.order.items[index].quantity.toString(), style: TextStyle(fontSize: 15)),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//                   // Order Summary
//                 ],
//               ),
//             )
//           ],
//
//         ),
//       ),
//     );
//   }
//
//   Widget summaryRow(String title, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style:
//             TextStyle(fontSize: 15),
//           ),
//           Text(
//             value,
//             style:
//             TextStyle(fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/orders/view/track_order_screen.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../model/models/orderModel.dart';

class ViewOrderScreen extends StatefulWidget {
  final OrderModel order;
  const ViewOrderScreen({super.key, required this.order});

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    String orderDate = DateFormat('dd MMM, yyyy • hh:mm a')
        .format(widget.order.createdAt.toLocal());

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Appbutton(
                buttonText: "Track Order",
                onTap: () => Get.to(TrackOrderScreen(order: widget.order)),

              ),
              SizedBox(height: 8),
              Appbutton(
                buttonText: "Continue Shopping",
                onTap: () => Get.back(),

              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: CustomScrollView(
          // Scroll ON
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultAppBar(titleText: "Order Summary", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Remove fixed height
                  ListView.separated(
                    shrinkWrap: true, // Important
                    physics: NeverScrollableScrollPhysics(), // Inner scroll off
                    padding: const EdgeInsets.all(10),
                    itemCount: widget.order.items.length + 2,
                    separatorBuilder: (context, index) => Divider(
                      height: 2,
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                    itemBuilder: (context, index) {
                      if (index == widget.order.items.length + 1) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        //  padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text("₹${widget.order.totalAmount.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, /*color: AppColors.primary*/)),
                            ],
                          ),
                        );
                      }

                      if (index == widget.order.items.length) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          //padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              summaryRow("Order Date", orderDate),
                              summaryRow("Order Id", widget.order.orderNumber),
                              //summaryRow("TrackingId", widget.order.id),
                              summaryRow("Platform fee", "₹${widget.order.tax.toStringAsFixed(2)}"),
                              summaryRow("Delivery fee", "₹${widget.order.deliveryFee.toStringAsFixed(2)}"),
                              summaryRow("Subtotal", "₹${widget.order.subtotal.toStringAsFixed(2)}"),

                            ],
                          ),
                        );
                      }

                      final item = widget.order.items[index];
                      return Card(
                        elevation: 0,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                height: 0.12.toHeightPercent(),
                                width: 0.25.toWidthPercent(),
                                decoration: BoxDecoration(
                                  //color: Color(0xFFEBEBEB),
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:Image.network(
                                    item.image.isNotEmpty ? item.image.first : 'https://via.placeholder.com/60',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.broken_image, color: Colors.red),
                                    ),
                                  ),
                                  ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 4),
                                    Text(item.itemModel, style: TextStyle(color: Colors.grey)),
                                    SizedBox(height: 2),
                                    Text("Qty: ${item.quantity}", style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                              //Text("₹${item.price * item.quantity}", style: TextStyle(fontWeight: FontWeight.w600)),
                              //Text("₹${item.price * item.quantity}", style: TextStyle(fontWeight: FontWeight.w600)),
                              //Text("₹${item.price}", style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("₹${item.price}", style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20), // Extra space before buttons
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14,color: AppColors.textSecondary)),
          Text(value, style: TextStyle(fontSize: 14, /*fontWeight: isBold ? FontWeight.w200 : FontWeight.w500*/color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}