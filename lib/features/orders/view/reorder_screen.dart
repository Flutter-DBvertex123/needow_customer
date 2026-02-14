import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
import 'package:newdow_customer/features/orders/view/track_order_screen.dart';
import 'package:newdow_customer/features/profile/view/payment_methods_screen.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';

import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../model/models/createOrderModel.dart';

class ReorderScreen extends StatefulWidget {
  OrderModel order;
   ReorderScreen({super.key,required this.order});

  @override
  State<ReorderScreen> createState() => _ReorderScreenState();
}

class _ReorderScreenState extends State<ReorderScreen> {

  @override
  void initState() {
    loadOrder();
    // TODO: implement initState
    super.initState();
  }
 Future<void> loadOrder() async {
   widget.order  =  await Get.find<OrderController>().getOrderById(widget.order.id);
 }
  @override
  Widget build(BuildContext context) {
    print("bvjxz${widget.order.restaurant}");
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
          child:

              Appbutton(
                buttonText: "Continue to payment",
                //onTap: () => Get.back(),
                onTap: () async {
                  Get.find<LoadingController>().isLoading.value = true;
                  final createdOrder = await createNewOrder();
                  Get.find<LoadingController>().isLoading.value = false;
                  Get.to(() => PaymentMethodsScreen(order: createdOrder,totalAmount: createdOrder.totalAmount,));
                }
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: CustomScrollView(
          // Scroll ON
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultAppBar(titleText: "Checkout", isFormBottamNav: false),
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
                              //summaryRow("Order Date", orderDate),
                              //summaryRow("Order Id", order.orderNumber),
                              //summaryRow("TrackingId", order.id),

                              //summaryRow("Subtotal", "₹${order.subtotal.toStringAsFixed(2)}"),
                              summaryRow("Subtotal", "₹${widget.order.subtotal.toStringAsFixed(2)}"),
                              summaryRow("Delivery fee", "₹${widget.order.deliveryFee.toStringAsFixed(2)}"),
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

  Widget _buildSelectedAddress() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text("xyz",
                  // "${addressCtrl.selectedDeliveryAddress.value?.street}, "
                  //     "${addressCtrl.selectedDeliveryAddress.value?.city}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                // if (!cartCon.isCalculating.value) {
                //   addressCtrl.selectedDeliveryAddress.value = null;
                // }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child:  Text(
                "Change",
                style: TextStyle(
                  fontSize: 12,
                  //color: cartCon.isCalculating.value ? Colors.grey : null,
                ),
              )
          ),
        ],
      ),
    );
  }

  Future<CreateOrderModel> createNewOrder() async {
    print("delivery adderesssss${widget.order.restaurant ?? "restaurent not found"}",);
    List<OrderItem> allItems = [];
    for (var item in widget.order.items) {
      allItems.add(
        OrderItem(

          item: item.id,
          //itemModel: /*item.product?.productType*/"Food",
          itemModel: item.itemModel,
          name: item.name,
          //price: item.product?.price?.toDouble(),
          price: item.price.toDouble(),
          quantity: item.quantity,
          image: item.image.first,
          variant: item.variant,
          notes: widget.order.customerNotes.trim() ?? "",
        ),
      );
    }
print(" response of resto: ${widget.order.orderType == "food" ? widget.order.restaurant ?? "" : null}");

    final String restaurantId =
    extractRestaurantId(widget.order.restaurant);

    print("FINAL RESTAURANT ID (safe): $restaurantId");


    // Create ONE order with all items combined
    final newOrder = CreateOrderModel(
      orderNumber: Get.find<OrderController>().generateOrderId(),
      //orderType: "food", // or from first item: allItems.first.itemModel
      orderType: widget.order.orderType,
      user: widget.order.user ,

      restaurant: widget.order.orderType == "food" ? restaurantId ?? "" : null,// fill if needed
      //restaurant: cartItems.first.product?.productType,
      items: allItems,
      //subtotal: carts.fold(0, (sum, cart) => sum + cart.items.first.lineTotal).toDouble(),
      //subtotal: cartItems.fold<num>(0, (sum, item) => sum + item.lineTotal),
      subtotal: widget.order.subtotal,
      tax: widget.order.tax,
      deliveryFee: widget.order.deliveryFee,
      discount: 0, // modify if you apply discount logic
      totalAmount: widget.order.totalAmount,
      status: "pending",
      // paymentStatus: "pending",
      // paymentMethod: "Credit Card",
      //paymentId: "pi_1234567890",
      deliveryAddress: widget.order.deliveryAddress?.id ?? "",
      //deliveryAgent: "64f0c2e2b8e4e2a1b8e4e2a6",
      customerNotes: widget.order.customerNotes,
      restaurantNotes: "",
      //coupon: "64f0c2e2b8e4e2a1b8e4e2a7",
      isScheduled: false,
      //scheduledFor: DateTime.parse("2024-12-15T10:30:00.000Z"),
    );
    return newOrder;

  }
}
String extractRestaurantId(dynamic raw) {
  if (raw == null) return "";

  // CASE 1: Proper ID string
  if (raw is String && !raw.contains("_id")) {
    return raw;
  }

  if (raw is String && raw.contains("_id")) {
    final match = RegExp(r'_id:\s*([a-fA-F0-9]{24})').firstMatch(raw);
    return match?.group(1) ?? "";
  }

  // CASE 3: Real Map
  if (raw is Map<String, dynamic>) {
    return raw['_id']?.toString() ?? "";
  }

  return "";
}

