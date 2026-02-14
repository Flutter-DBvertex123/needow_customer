// import 'dart:math';
//
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/cart/model/models/addToCartModel.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
// import 'package:newdow_customer/features/orders/model/services/order_services.dart';
// import 'package:newdow_customer/utils/constants.dart';
//
// class OrderController extends GetxController {
//
//   Future<void> createOrder(OrderModel order) async {
//     await Get.find<OrderService>().createOrder(order);
//   }
//   List<OrderModel> checkoutOrder(List<CartModel> carts,double totalAmount)  {
//
//    List<OrderModel> orders = carts.map((cart) {
//      final item = getItems(cart.items);
//     return OrderModel(
//        orderNumber: generateOrderId(),
//        orderType: item?.product?.productType,
//        user: cart?.user.id,
//        restaurant: '',
//        items: [
//          OrderItem(
//            item: item?.product?.id,
//            itemModel: item?.product?.productType,
//            name: item?.product?.name,
//            price: item?.product!.price.toDouble(),
//            quantity: item?.quantity,
//            image: item?.product?.imageUrl.toString() ?? "",
//            variant: item?.product?.unit,
//            notes: "Extra spicy preparation",
//          ),
//        ],
//        subtotal: cart.cartTotal.toDouble(),
//        tax: 20,
//        deliveryFee: 50,
//        discount: cart.cartTotal.toDouble(),
//        totalAmount: totalAmount ,
//        status: "pending",
//        paymentStatus: "pending",
//        paymentMethod: "Credit Card",
//        paymentId: "pi_1234567890",
//        deliveryAddress: "64f0c2e2b8e4e2a1b8e4e2a4",
//        deliveryAgent: "64f0c2e2b8e4e2a1b8e4e2a6",
//        customerNotes: "Please ring the doorbell",
//        restaurantNotes: "Extra spicy preparation",
//        coupon: "64f0c2e2b8e4e2a1b8e4e2a7",
//        isScheduled: false,
//        scheduledFor: DateTime.parse("2024-12-15T10:30:00.000Z"),
//      );
//    }).toList();
//    return orders;
//
//   }
//
//   CartItem? getItems(List<CartItem> cartItems) {
//     if (cartItems.isNotEmpty) {
//       return cartItems.first;
//     }
//     return null;
//   }
//
//   String generateOrderId() {
//     final now = DateTime.now();
//     final timestamp =
//         "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
//     const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     final random = Random();
//     final randomStr = String.fromCharCodes(
//       Iterable.generate(3, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
//     );
//
//     return "ORD$timestamp$randomStr";
//   }
//
//
// }

import 'dart:math';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/models/addToCartModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/orders/model/models/orderModel.dart';
import 'package:newdow_customer/features/orders/model/models/orderTrackingModel.dart';
import 'package:newdow_customer/features/orders/model/services/order_services.dart';
import 'package:newdow_customer/utils/constants.dart';

import '../../cart/model/models/cartCheckOutModel.dart';

class OrderController extends GetxController {


  List<OrderModel> userOrders = <OrderModel>[].obs;
  /// Create a single order (API call)
  Future<Map<String, dynamic>> createOrder(CreateOrderModel order) async {
    final data = await Get.find<OrderService>().createOrder(order);
    if(data["success"]){
      print("created Order ${data["data"]}");
      return {"success": true, "data": data["data"]};
    }else{
      return {"success": false, "data": data["message"]};
    }
  }

  /// Convert cart items into one single order
  // CreateOrderModel checkoutOrder(List<CartModel> carts, double totalAmount, CheckoutController checkoutCon) {
  //   // Flatten all cart items into one list
  //   List<OrderItem> allItems = [];
  //
  //   for (var cart in carts) {
  //     for (var item in cart.items) {
  //       allItems.add(
  //         OrderItem(
  //           item: item.product?.id,
  //           itemModel: "Food",
  //           name: item.product?.name,
  //           price: item.product?.price?.toDouble(),
  //           quantity: item.quantity,
  //           image: item.product?.imageUrl.toString() ?? "",
  //           variant: item.product?.unit,
  //           notes: "Extra spicy preparation",
  //         ),
  //       );
  //     }
  //   }
  CreateOrderModel checkoutOrder(List<CartItem> cartItems, double totalAmount, CheckoutController checkoutCon,String userId,CartGroup checkoutCalculation,String restaurentId) {
    final businessCtrl = Get.find<BusinessController>();
    print("delivery address ${Get.find<AddressController>().selectedDeliveryAddress.value?.id}");
    print("cart items length ${totalAmount}");
    print("user id for create order $userId");
    // Flatten all cart items into one list
    List<OrderItem> allItems = [];
      for (var item in cartItems) {
        allItems.add(
          OrderItem(
            item: item.product?.id,
            //itemModel: /*item.product?.productType*/"Food",
            itemModel: item.product?.productType == "food" ? "Food" : "Product",
            name: item.product?.name,
            //price: item.product?.price?.toDouble(),
            price: item.product?.discountedPrice.toDouble() == 0.toDouble() ? item.product?.price.toDouble() :item.product?.discountedPrice.toDouble(),
            quantity: item.quantity,
            image: item.product?.imageUrl.toString() ?? "",
            variant: item.product?.unit,
            notes: checkoutCon.customerNote.text.trim() ?? "",
            prescriptionUrl: item.prescriptionUrl

          ),
        );
      }


    // Create ONE order with all items combined
    // final order = CreateOrderModel(
    //   orderNumber: generateOrderId(),
    //   orderType: "food", // or from first item: allItems.first.itemModel
    //   user: carts.isNotEmpty ? carts.first.user.id : null,
    //   restaurant: '64f0c2e2b8e4e2a1b8e4e2a5', // fill if needed
    //   items: allItems,
    //   //subtotal: carts.fold(0, (sum, cart) => sum + cart.items.first.lineTotal).toDouble(),
    //   subtotal: carts.fold<num>(0, (sum, cart) => sum + cart.items.first.lineTotal),
    //
    //   tax: 20,
    //   deliveryFee: 50,
    //   discount: 0, // modify if you apply discount logic
    //   totalAmount: totalAmount,
    //   status: "pending",
    //   paymentStatus: "pending",
    //   paymentMethod: "Credit Card",
    //   paymentId: "pi_1234567890",
    //   deliveryAddress: checkoutCon.selectedAddress.value!.id,
    //   deliveryAgent: "64f0c2e2b8e4e2a1b8e4e2a6",
    //   customerNotes: checkoutCon.customerNote.text.trim() ?? "",
    //   restaurantNotes: "Extra spicy preparation",
    //   coupon: "64f0c2e2b8e4e2a1b8e4e2a7",
    //   isScheduled: false,
    //   scheduledFor: DateTime.parse("2024-12-15T10:30:00.000Z"),
    // );
    //
    // return order;
    final order = CreateOrderModel(
      orderNumber: generateOrderId(),
      //orderType: "food", // or from first item: allItems.first.itemModel
      orderType: cartItems.first.product?.productType,
      user: userId ,
      // pickupLocation: cartItems.isNotEmpty &&
      //     cartItems.first.product?.productType != "food"
      //     ? (() {
      //   final bt = businessCtrl.businessTypes.firstWhere(
      //         (bt) => bt.id == cartItems.first.product?.businessType,
      //
      //   );
      //
      //   print("Business :- ${bt}");
      //   print("Business type order :- ${bt.latitude}");
      //   return (bt?.latitude != null && bt?.longitude != null)
      //       ? PickupLocation(
      //     type: "Point",
      //     coordinates: [
      //       bt!.longitude!,
      //       bt.latitude!,
      //     ],
      //   )
      //       : null;
      // })()
      //     : null,
      restaurant: /*(restaurentId.isEmpty || restaurentId == null) ? null : */restaurentId, // fill if needed
      //restaurant: cartItems.first.product?.productType,
      items: allItems,
      //subtotal: carts.fold(0, (sum, cart) => sum + cart.items.first.lineTotal).toDouble(),
      //subtotal: cartItems.fold<num>(0, (sum, item) => sum + item.lineTotal),
      subtotal: checkoutCalculation.subtotal,
      tax: checkoutCalculation.platformCharges.toDouble(),
      deliveryFee: checkoutCalculation.deliveryFee.toDouble(),
      discount: 0, // modify if you apply discount logic
      totalAmount: checkoutCalculation.groupTotal.toDouble(),
      status: "pending",
      // paymentStatus: "pending",
      // paymentMethod: "Credit Card",
      //paymentId: "pi_1234567890",
      deliveryAddress: Get.find<AddressController>().selectedDeliveryAddress.value?.id ?? "",
      //deliveryAgent: "64f0c2e2b8e4e2a1b8e4e2a6",
      customerNotes: checkoutCon.customerNote.text.trim() ?? "",
      restaurantNotes: "",
      //coupon: "64f0c2e2b8e4e2a1b8e4e2a7",
      isScheduled: false,
      //scheduledFor: DateTime.parse("2024-12-15T10:30:00.000Z"),
    );
      return order;
  }

  /// Helper: Generate unique order ID
  String generateOrderId() {
    final now = DateTime.now();
    final timestamp =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    final randomStr = String.fromCharCodes(
      Iterable.generate(3, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );

    return "ORD$timestamp$randomStr";
  }

  Future<List<OrderModel>> getUsersOrder({required String userId,
  int page = 1,
  int limit = 10}) async {
    final data = await Get.find<OrderService>().getUserOrders(userId: userId,limit:limit,page: page);
    print("order data in controller ${data.first.discount}");
    return data;
  }

  Future<OrderModel> getOrderById(String orderId) async {
    final data = await Get.find<OrderService>().getOrderById(orderId);
    return data;
  }

  Future<OrderTrackingModel> getTrackingData(String orderId) async {
    final data = await Get.find<OrderService>().getOrderTracking(orderId);
    print("Data ${data}");
    return data;
  }

  Future<bool> rateDelivery(String deliveryAgentId, String userId, String comment,String orderId,int rating) async {
    print(deliveryAgentId);
    print(userId);
    print(comment);
    print(rating.toString());
    final response = await Get.find<OrderService>().rateDeliveryAgent(deliveryAgentId.replaceAll("/", ""), userId, comment, orderId, rating);
    return response;
  }
 Future<bool> updateOrderStatus(String orderId, String status,String note) async {
   final response =  await Get.find<OrderService>().updateOrderStatus(orderId: orderId, status: status, note: note);
   response["success"] ? print("Order status updated successfully") : print("Failed to update order status");
    return response["success"];

  }

}
