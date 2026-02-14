import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/view/view_order_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../widgets/appbutton.dart';

class PaymentSuccessScreen extends StatelessWidget {
  String orderId;
   PaymentSuccessScreen({super.key,required this.orderId});
  final orderController  = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF9F9F9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            height: 0.1.toHeightPercent(),
            child: Appbutton(buttonText: "View Order", onTap: () async {
              Get.find<LoadingController>().isLoading.value = true;
              final order = await orderController.getOrderById(orderId);
              print("order id from succ${order.id}");
              Get.find<LoadingController>().isLoading.value = false;
              Get.to(ViewOrderScreen(order: order));
            },
            )

        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded,size: 150,color: AppColors.primary,),
            Text("Payment Successful!",style: TextStyle(fontSize: 25,),),
            Text("Thank you for your purchase.",style: TextStyle(fontSize: 15,color: Colors.black.withValues(alpha: 0.5)),)
          ],
        ),
      ),
    );
  }
}
