// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/auth/model/models/userModel.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/features/cart/view/payment_success_screen.dart';
// import 'package:newdow_customer/features/orders/controllers/orderController.dart';
// import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
// import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
// import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
// import 'package:newdow_customer/features/profile/view/manage_address_screen.dart';
// import 'package:newdow_customer/features/profile/view/payment_methods_screen.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/imageHandler.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/snackBar.dart';
// import '../../payment/paymentServices/makePaymentService.dart';
// import '../../profile/model/userModel.dart';
//
//
// class CheckoutScreen extends StatefulWidget {
//   List<CartModel> carts;
//    CheckoutScreen({
//      required this.carts,
//      super.key
//    });
//
//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }
// final addressCon = Get.find<AddressController>();
// final orderCon = Get.find<OrderController>();
// class _CheckoutScreenState extends State<CheckoutScreen> {
//    final checkoutCon  = Get.find<CheckoutController>();
//    late RazorpayService _razorpayService;
//    @override
//    void initState() {
//      super.initState();
//      _razorpayService = Get.find<RazorpayService>();
//    }
//    final cartCon = Get.find<CartController>();
//    void _initiatePayment(OrderModel order,double totalPrice) {
//      _razorpayService.startPayment(
//        context: context,
//        amount: totalPrice, // Amount in rupees
//        description: 'Order Payment',
//        email: 'needowuser@example.com',
//        phoneNumber: '9876543210',
//        onSuccess: (PaymentSuccessResponse response) async {
//         final data = await orderCon.createOrder(order);
//         if(data){
//           AppSnackBar.showSuccess(
//             context,
//             message: 'Order Placed',
//           );
//           Get.to(PaymentSuccessScreen());
//         }else{
//           AppSnackBar.showError(context, message: "Order Failed");
//         }
//
//
//          //Get.to(PaymentSuccessScreen());
//          //print('Payment Success: ${response.paymentId}');
//        },
//        onFailure: (PaymentFailureResponse response) {
//          AppSnackBar.showError(
//            context,
//            message: 'Payment Failed: ${response.message}',
//          );
//          print('Payment Error: ${response.message}');
//        },
//      );
//    }
//
//    @override
//    void dispose() {
//      _razorpayService.dispose();
//      super.dispose();
//    }
//    CartItem? getItems(List<CartItem> cartItems) {
//      if (cartItems.isNotEmpty) {
//        return cartItems.first;
//      }
//      return null;
//    }
//    final profilecon = Get.find<ProfileController>();
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
//             child: Appbutton(buttonText: "Continue to Payment", onTap: () async {
//              final data =  await Get.find<OrderController>().checkoutOrder(widget.carts,cartCon.grandTotal );
//               print("Order Data $data");
//                 //Get.to(PaymentSuccessScreen());
//               _initiatePayment(data,cartCon.grandTotal);
//               //Get.to(PaymentScreen());
//               }, isLoading: false,
//               )
//
//         ),
//       ),
//
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           slivers: [
//             DefaultAppBar(titleText: "Checkout",isFormBottamNav: false,),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//                 child: FutureBuilder<UserModel?>(
//                   future:  AuthStorage.getUserFromPrefs(),
//                   builder: (context, asyncSnapshot) {
//                     if(asyncSnapshot.hasData) {
//                       final user = asyncSnapshot.data!;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           /// Profile section
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.secondary,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               children: [
//                                // Obx(() => SafeNetworkImage(url: profilecon.savedData.value?.photo ?? "")),
//                                 Obx(
//                                   () => CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: NetworkImage(profilecon.savedData.value?.photo ?? ""),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(user.name,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15)),
//                                       SizedBox(height: 4),
//                                       Obx(() =>
//                                          Text(
//                                            "${addressCon.defaultAddress.value!
//                                                .street} ${addressCon.defaultAddress.value!
//                                                .city}",
//                                           style: TextStyle(color: Colors.black54,
//                                               fontSize: 12),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Delivery Address
//                           Row(
//                             children:  [
//                               SvgPicture.asset(location_icon,width: 20,height: 20,),
//                               //Icon(Icons.location_on, color: Colors.green),
//                               SizedBox(width: 8),
//                               Text("Delivery Address",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               Spacer(),
//                                GestureDetector(
//                                 onTap: () => Get.to(ManageAddressScreen()),
//                                 child: Text("Edit Address",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: AppColors.primary,
//                                         fontWeight: FontWeight.w500)),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             height: (0.1 * addressCon.usersAddress.length).toHeightPercent(),
//                             width: 1.toWidthPercent(),
//
//                             child: ListView.separated(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return Obx(() {
//                                     return InkWell(
//                                       onTap: () => checkoutCon.changeAddress(index),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         child: Row(
//                                           children:  [
//                                             Expanded(
//                                                 child: Text(
//                                                     "${addressCon
//                                                         .usersAddress[index]
//                                                         .street} ${addressCon
//                                                         .usersAddress[index]
//                                                         .city} ${addressCon
//                                                         .usersAddress[index]
//                                                         .state}",
//
//                                                     style: TextStyle(
//                                                         color: Colors.black54)
//                                                 )
//                                             ),
//                                             Obx(() => addressCon.usersAddress[index].isDefault ? Icon(Icons.check_circle,
//                                                 color: AppColors.primary) : Icon(Icons.radio_button_unchecked,color: AppColors.primary,),),
//
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     SizedBox(height: 8,),
//                                 itemCount: addressCon.usersAddress.length),
//                               ),
//
//                           const SizedBox(height: 20),
//
//                           /// Additional Instruction
//                           Row(
//                             children: const [
//                               Icon(
//                                   Icons.note_alt_outlined, color: Colors.green),
//                               SizedBox(width: 8),
//                               Text("Additional Instruction",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                               decoration: InputDecoration(
//                               enabledBorder:  OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                   color: Color(0xFFEBEBEB)
//                                 )
//                               ),
//                               hintText: "Type something",
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Color(0xFFEBEBEB).withValues(alpha: 0.5))
//                               ),
//                               contentPadding:
//                               const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 14),
//                             ),
//                             maxLines: 1,
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Order Summary
//                           Row(
//                             children: const [
//                               Icon(Icons.event_note, color: AppColors.primary),
//                               SizedBox(width: 8),
//                               Text("Order Summary",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             height: (0.14 * 3).toHeightPercent(),
//                             width: 1.toWidthPercent(),
//                             child: ListView.separated(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final cart = widget.carts[index];
//                                   final item = getItems(cart.items);
//                                   return Card(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             12)),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                          padding: const EdgeInsets.all(12),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(8),
//                                             child: SafeNetworkImage(
//                                               url: cart.items.isNotEmpty &&
//                                                   item?.product?.imageUrl.isNotEmpty == true
//                                                   ? item!.product!.imageUrl.first
//                                                   : "",
//                                             ),
//                                           ),
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(width: 6,),
//                                             Text( item?.product?.name ??  "", style:TextStyle(fontSize: 15),),
//                                             Text(item?.quantity.toString() ??  "", style: TextStyle(fontSize: 13, color: Colors.black.withValues(alpha: 0.5)),),
//                                             Text("₹${cart.cartTotal.toStringAsFixed(2)}" ?? "", style: TextStyle(fontSize: 15),),
//                                           ],
//                                         )
//                                       ]
//                                        /*ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.asset(
//                                           productImage,
//                                           height: 80,
//                                           width: 80,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )*/
//
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     SizedBox(height: 8,),
//                                 itemCount: widget.carts.length),
//                           )
//                         ],
//                       );
//                     }
//                     if(asyncSnapshot.connectionState == ConnectionState.waiting){
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }else{
//                       return Center(
//                         child: Text("User not found"),
//                       );
//                     }
//                   }
//                 ),
//               ),
//             )
//           ],
//
//         ),
//       ),
//     );
//   }
// }
/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/view/payment_success_screen.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/payment/paymentServices/makePaymentService.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/features/profile/view/manage_address_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../profile/model/userModel.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> carts;

  const CheckoutScreen({
    Key? key,
    required this.carts,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final addressCon = Get.find<AddressController>();
  final orderCon = Get.find<OrderController>();
  final cartCon = Get.find<CartController>();
  final profileCon = Get.find<ProfileController>();
  final checkoutCon = Get.find<CheckoutController>();
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = Get.find<RazorpayService>();
    if (addressCon.defaultAddress.value != null) {
      checkoutCon.selectedAddress.value = addressCon.defaultAddress.value;
    }
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  CartItem? getFirstItem(List<CartItem> cartItems) {
    return cartItems.isNotEmpty ? cartItems.first : null;
  }

  void _initiatePayment(CreateOrderModel order, double totalPrice) {
    _razorpayService.startPayment(
      context: context,
      amount: totalPrice,
      description: 'Order Payment',
      email: 'needowuser@example.com',
      phoneNumber: '9876543210',
      onSuccess: (PaymentSuccessResponse response) async {
        final orderData = await orderCon.createOrder(order);
        if (orderData['success']) {
          AppSnackBar.showSuccess(context, message: 'Order placed successfully!');
          String orderId = orderData["data"];
          print("OrderId $orderId");
          Get.off(() => PaymentSuccessScreen(orderId: orderId));
        } else {
          AppSnackBar.showError(context, message: "Order creation failed!");
        }
      },
      onFailure: (PaymentFailureResponse response) {
        AppSnackBar.showError(
          context,
          message: 'Payment Failed: ${response.message}',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Appbutton(
            buttonText: "Continue to Payment",
            onTap: () async {
              final order = await orderCon.checkoutOrder(widget.carts, cartCon.grandTotal,checkoutCon);
              _initiatePayment(order, cartCon.grandTotal);
            }, isLoading: false,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
             DefaultAppBar(titleText: "Checkout", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: FutureBuilder<UserModel?>(
                  future: AuthStorage.getUserFromPrefs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text("User not found"));
                    }
                    final addresses = addressCon.usersAddress;
                    final user = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Obx(() => CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.secondary,
                                backgroundImage: NetworkImage(
                                  profileCon.savedData.value?.photo ?? "",
                                ),
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15)),
                                    const SizedBox(height: 4),
                                    Obx(() {
                                      final address = addressCon.defaultAddress.value;
                                      if (address == null) return const SizedBox();
                                      return Text(
                                        "${address.street}, ${address.city}",
                                        style: const TextStyle(color: Colors.black54, fontSize: 12),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Delivery Address Section
                        Row(
                          children: [
                            SvgPicture.asset(location_icon, width: 20, height: 20),
                            const SizedBox(width: 8),
                            const Text("Delivery Address",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Get.to(() => ManageAddressScreen()),
                              child: Text("Edit Address",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),


                        // Obx(() {
                        //
                        //   if (addresses.isEmpty) {
                        //     return const Text("No saved addresses found.");
                        //   }
                        //
                        //   return ListView.separated(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: addresses.length,
                        //     separatorBuilder: (_, __) => const SizedBox(height: 8),
                        //     itemBuilder: (context, index) {
                        //       final addr = addresses[index];
                        //       final isSelected =
                        //           checkoutCon.selectedAddress.value?.id == addr.id;
                        //
                        //       return InkWell(
                        //         onTap: () {
                        //           checkoutCon.changeAddress(addr);
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: isSelected
                        //                   ? AppColors.primary
                        //                   : Colors.grey.shade300,
                        //             ),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Text(
                        //                   "${addr.street}, ${addr.city}, ${addr.state}",
                        //                   style: const TextStyle(color: Colors.black54),
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 isSelected
                        //                     ? Icons.check_circle
                        //                     : Icons.radio_button_unchecked,
                        //                 color: AppColors.primary,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }),
                        Obx(() {
                          print("Rebuilding address list with: ${checkoutCon.selectedAddress.value?.id}");
                          final addresses = addressCon.usersAddress;
                          if (addresses.isEmpty) {
                            return const Text("No saved addresses found.");
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addresses.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final addr = addresses[index];
                              final isSelected = checkoutCon.selectedAddress.value?.id == addr.id;

                              return InkWell(
                                onTap: () => checkoutCon.changeAddress(addr),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${addr.street}, ${addr.city}, ${addr.state}",
                                          style: const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Icon(
                                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),


                        const SizedBox(height: 18),

                        // Additional Instruction
                        const Row(
                          children: [
                            Icon(Icons.note_alt_outlined, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text("Additional Instruction",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: checkoutCon.customerNote,
                          decoration: InputDecoration(
                            hintText: "Add Note",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFEBEBEB)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: const Color(0xFFEBEBEB).withValues(alpha: 0.5)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 20),

                        // Order Summary
                        const Row(
                          children: [
                            Icon(Icons.event_note, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text("Order Summary",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.carts.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final cart = widget.carts[index];
                            final item = getFirstItem(cart.items);
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SafeNetworkImage(
                                        url: item?.product?.imageUrl.isNotEmpty == true
                                            ? item!.product!.imageUrl.first
                                            : "",
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item?.product?.name ?? "",
                                          style: const TextStyle(fontSize: 15)),
                                      Text("Qty: ${item?.quantity ?? 0}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black.withOpacity(0.6))),
                                      Text("₹${cart.items.first.lineTotal.toStringAsFixed(2)}",
                                          style: const TextStyle(fontSize: 15)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/auth/model/models/userModel.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/features/cart/view/payment_success_screen.dart';
// import 'package:newdow_customer/features/orders/controllers/orderController.dart';
// import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
// import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
// import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
// import 'package:newdow_customer/features/profile/view/manage_address_screen.dart';
// import 'package:newdow_customer/features/profile/view/payment_methods_screen.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/imageHandler.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/snackBar.dart';
// import '../../payment/paymentServices/makePaymentService.dart';
// import '../../profile/model/userModel.dart';
//
//
// class CheckoutScreen extends StatefulWidget {
//   List<CartModel> carts;
//    CheckoutScreen({
//      required this.carts,
//      super.key
//    });
//
//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }
// final addressCon = Get.find<AddressController>();
// final orderCon = Get.find<OrderController>();
// class _CheckoutScreenState extends State<CheckoutScreen> {
//    final checkoutCon  = Get.find<CheckoutController>();
//    late RazorpayService _razorpayService;
//    @override
//    void initState() {
//      super.initState();
//      _razorpayService = Get.find<RazorpayService>();
//    }
//    final cartCon = Get.find<CartController>();
//    void _initiatePayment(OrderModel order,double totalPrice) {
//      _razorpayService.startPayment(
//        context: context,
//        amount: totalPrice, // Amount in rupees
//        description: 'Order Payment',
//        email: 'needowuser@example.com',
//        phoneNumber: '9876543210',
//        onSuccess: (PaymentSuccessResponse response) async {
//         final data = await orderCon.createOrder(order);
//         if(data){
//           AppSnackBar.showSuccess(
//             context,
//             message: 'Order Placed',
//           );
//           Get.to(PaymentSuccessScreen());
//         }else{
//           AppSnackBar.showError(context, message: "Order Failed");
//         }
//
//
//          //Get.to(PaymentSuccessScreen());
//          //print('Payment Success: ${response.paymentId}');
//        },
//        onFailure: (PaymentFailureResponse response) {
//          AppSnackBar.showError(
//            context,
//            message: 'Payment Failed: ${response.message}',
//          );
//          print('Payment Error: ${response.message}');
//        },
//      );
//    }
//
//    @override
//    void dispose() {
//      _razorpayService.dispose();
//      super.dispose();
//    }
//    CartItem? getItems(List<CartItem> cartItems) {
//      if (cartItems.isNotEmpty) {
//        return cartItems.first;
//      }
//      return null;
//    }
//    final profilecon = Get.find<ProfileController>();
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
//             child: Appbutton(buttonText: "Continue to Payment", onTap: () async {
//              final data =  await Get.find<OrderController>().checkoutOrder(widget.carts,cartCon.grandTotal );
//               print("Order Data $data");
//                 //Get.to(PaymentSuccessScreen());
//               _initiatePayment(data,cartCon.grandTotal);
//               //Get.to(PaymentScreen());
//               }, isLoading: false,
//               )
//
//         ),
//       ),
//
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           slivers: [
//             DefaultAppBar(titleText: "Checkout",isFormBottamNav: false,),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//                 child: FutureBuilder<UserModel?>(
//                   future:  AuthStorage.getUserFromPrefs(),
//                   builder: (context, asyncSnapshot) {
//                     if(asyncSnapshot.hasData) {
//                       final user = asyncSnapshot.data!;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           /// Profile section
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.secondary,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               children: [
//                                // Obx(() => SafeNetworkImage(url: profilecon.savedData.value?.photo ?? "")),
//                                 Obx(
//                                   () => CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: NetworkImage(profilecon.savedData.value?.photo ?? ""),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(user.name,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15)),
//                                       SizedBox(height: 4),
//                                       Obx(() =>
//                                          Text(
//                                            "${addressCon.defaultAddress.value!
//                                                .street} ${addressCon.defaultAddress.value!
//                                                .city}",
//                                           style: TextStyle(color: Colors.black54,
//                                               fontSize: 12),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Delivery Address
//                           Row(
//                             children:  [
//                               SvgPicture.asset(location_icon,width: 20,height: 20,),
//                               //Icon(Icons.location_on, color: Colors.green),
//                               SizedBox(width: 8),
//                               Text("Delivery Address",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               Spacer(),
//                                GestureDetector(
//                                 onTap: () => Get.to(ManageAddressScreen()),
//                                 child: Text("Edit Address",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: AppColors.primary,
//                                         fontWeight: FontWeight.w500)),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             height: (0.1 * addressCon.usersAddress.length).toHeightPercent(),
//                             width: 1.toWidthPercent(),
//
//                             child: ListView.separated(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return Obx(() {
//                                     return InkWell(
//                                       onTap: () => checkoutCon.changeAddress(index),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 16),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         child: Row(
//                                           children:  [
//                                             Expanded(
//                                                 child: Text(
//                                                     "${addressCon
//                                                         .usersAddress[index]
//                                                         .street} ${addressCon
//                                                         .usersAddress[index]
//                                                         .city} ${addressCon
//                                                         .usersAddress[index]
//                                                         .state}",
//
//                                                     style: TextStyle(
//                                                         color: Colors.black54)
//                                                 )
//                                             ),
//                                             Obx(() => addressCon.usersAddress[index].isDefault ? Icon(Icons.check_circle,
//                                                 color: AppColors.primary) : Icon(Icons.radio_button_unchecked,color: AppColors.primary,),),
//
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     SizedBox(height: 8,),
//                                 itemCount: addressCon.usersAddress.length),
//                               ),
//
//                           const SizedBox(height: 20),
//
//                           /// Additional Instruction
//                           Row(
//                             children: const [
//                               Icon(
//                                   Icons.note_alt_outlined, color: Colors.green),
//                               SizedBox(width: 8),
//                               Text("Additional Instruction",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                               decoration: InputDecoration(
//                               enabledBorder:  OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                   color: Color(0xFFEBEBEB)
//                                 )
//                               ),
//                               hintText: "Type something",
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                       color: Color(0xFFEBEBEB).withValues(alpha: 0.5))
//                               ),
//                               contentPadding:
//                               const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 14),
//                             ),
//                             maxLines: 1,
//                           ),
//                           const SizedBox(height: 20),
//
//                           /// Order Summary
//                           Row(
//                             children: const [
//                               Icon(Icons.event_note, color: AppColors.primary),
//                               SizedBox(width: 8),
//                               Text("Order Summary",
//                                   style:
//                                   TextStyle(fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             height: (0.14 * 3).toHeightPercent(),
//                             width: 1.toWidthPercent(),
//                             child: ListView.separated(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final cart = widget.carts[index];
//                                   final item = getItems(cart.items);
//                                   return Card(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             12)),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                          padding: const EdgeInsets.all(12),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(8),
//                                             child: SafeNetworkImage(
//                                               url: cart.items.isNotEmpty &&
//                                                   item?.product?.imageUrl.isNotEmpty == true
//                                                   ? item!.product!.imageUrl.first
//                                                   : "",
//                                             ),
//                                           ),
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(width: 6,),
//                                             Text( item?.product?.name ??  "", style:TextStyle(fontSize: 15),),
//                                             Text(item?.quantity.toString() ??  "", style: TextStyle(fontSize: 13, color: Colors.black.withValues(alpha: 0.5)),),
//                                             Text("₹${cart.cartTotal.toStringAsFixed(2)}" ?? "", style: TextStyle(fontSize: 15),),
//                                           ],
//                                         )
//                                       ]
//                                        /*ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.asset(
//                                           productImage,
//                                           height: 80,
//                                           width: 80,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )*/
//
//                                     ),
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     SizedBox(height: 8,),
//                                 itemCount: widget.carts.length),
//                           )
//                         ],
//                       );
//                     }
//                     if(asyncSnapshot.connectionState == ConnectionState.waiting){
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }else{
//                       return Center(
//                         child: Text("User not found"),
//                       );
//                     }
//                   }
//                 ),
//               ),
//             )
//           ],
//
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/view/payment_success_screen.dart';
import 'package:newdow_customer/features/orders/controllers/orderController.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/payment/paymentServices/makePaymentService.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/features/profile/view/manage_address_screen.dart';
import 'package:newdow_customer/features/profile/view/payment_methods_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../profile/model/userModel.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  CartGroup checkoutCalculation;
  double orderTotal;
  String restaurentId;

   CheckoutScreen({
    Key? key,
    required this.checkoutCalculation,
     required this.orderTotal,
    required this.cartItems,
     required this.restaurentId
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final addressCon = Get.find<AddressController>();
  final orderCon = Get.find<OrderController>();
  final cartCon = Get.find<CartController>();
  final profileCon = Get.find<ProfileController>();
  final checkoutCon = Get.find<CheckoutController>();
  late RazorpayService _razorpayService;

  // @override
  // void initState() {
  //   super.initState();
  //   _razorpayService = RazorpayService(keyId: keyId, keySecret: secretId);
  //   if (addressCon.defaultAddress.value != null) {
  //     checkoutCon.selectedAddress.value = addressCon.defaultAddress.value;
  //   }
  // }

  // @override
  // void dispose() {
  //   _razorpayService.dispose();
  //   super.dispose();
  // }

  CartItem? getFirstItem(List<CartItem> cartItems) {
    return cartItems.isNotEmpty ? cartItems.first : null;
  }

  // void _initiatePayment(CreateOrderModel order, double totalPrice) {
  //   _razorpayService.startPayment(
  //     context: context,
  //     amount: totalPrice,
  //     description: 'Order Payment',
  //     email: 'needowuser@example.com',
  //     phoneNumber: '9876543210',
  //     onSuccess: (PaymentSuccessResponse response) async {
  //       final orderData = await orderCon.createOrder(order);
  //       if (orderData['success']) {
  //         AppSnackBar.showSuccess(context, message: 'Order placed successfully!');
  //         String orderId = orderData["data"];
  //         print("OrderId $orderId");
  //         Get.off(() => PaymentSuccessScreen(orderId: orderId));
  //       } else {
  //         AppSnackBar.showError(context, message: "Order creation failed!");
  //       }
  //     },
  //     onFailure: (PaymentFailureResponse response) {
  //       AppSnackBar.showError(
  //         context,
  //         message: 'Payment Failed: ${response.message}',
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Appbutton(
            buttonText: "Continue to Payment",
           /* onTap: () async {
              Get.find<LoadingController>().isLoading.value = true;
              String userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "");
              print("before creating order :- ${userId}");
              final order = await orderCon.checkoutOrder(widget.cartItems, cartCon.grandTotal,checkoutCon,userId);
              _initiatePayment(order, cartCon.grandTotal);
              Get.find<LoadingController>().isLoading.value = false;
            },*/
            onTap: () async {
              Get.find<LoadingController>().isLoading.value = true;
              String userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "");
              print("before creating order :- ${userId}");
              print("cart total${widget.orderTotal}");
              final order = await orderCon.checkoutOrder(widget.cartItems, widget.orderTotal,checkoutCon,userId,widget.checkoutCalculation,widget.restaurentId);
              Get.find<LoadingController>().isLoading.value = false;
              /*_initiatePayment(order, cartCon.grandTotal);
              Get.find<LoadingController>().isLoading.value = false;*/
              if (order != null) {
                Get.to(() => PaymentMethodsScreen(order: order, totalAmount: order.totalAmount,));
                Get.find<LoadingController>().isLoading.value = false;
              } else {
                AppSnackBar.showError(context, message: "Order creation failed!");
              }
            },
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "Checkout", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: FutureBuilder<UserModel?>(
                  future: AuthStorage.getUserFromPrefs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text("User not found"));
                    }
                    final addresses = addressCon.usersAddress;
                    final user = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Obx(() => CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.background,
                                backgroundImage: NetworkImage(
                                  profileCon.savedData.value?.photo ?? "",
                                ),
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15)),
                                    const SizedBox(height: 4),
                                    Obx(() {
                                      final address = addressCon.defaultAddress.value;
                                      if (address == null) return const SizedBox();
                                      return Text(
                                        "${address.street}, ${address.city}",
                                        style: const TextStyle(color: Colors.black54, fontSize: 12),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),

                        // Delivery Address Section
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(location_icon, width: 20, height: 20),
                        //     const SizedBox(width: 8),
                        //     const Text("Delivery Address",
                        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        //     const Spacer(),
                        //     GestureDetector(
                        //       onTap: () => Get.to(() => ManageAddressScreen(isFromCheckOutScreen: true,)),
                        //       child: Text("Edit Address",
                        //           style: TextStyle(
                        //               fontSize: 14,
                        //               color: AppColors.primary,
                        //               fontWeight: FontWeight.w500)),
                        //     ),
                        //   ],
                        // ),


                        // Obx(() {
                        //
                        //   if (addresses.isEmpty) {
                        //     return const Text("No saved addresses found.");
                        //   }
                        //
                        //   return ListView.separated(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: addresses.length,
                        //     separatorBuilder: (_, __) => const SizedBox(height: 8),
                        //     itemBuilder: (context, index) {
                        //       final addr = addresses[index];
                        //       final isSelected =
                        //           checkoutCon.selectedAddress.value?.id == addr.id;
                        //
                        //       return InkWell(
                        //         onTap: () {
                        //           checkoutCon.changeAddress(addr);
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: isSelected
                        //                   ? AppColors.primary
                        //                   : Colors.grey.shade300,
                        //             ),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Text(
                        //                   "${addr.street}, ${addr.city}, ${addr.state}",
                        //                   style: const TextStyle(color: Colors.black54),
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 isSelected
                        //                     ? Icons.check_circle
                        //                     : Icons.radio_button_unchecked,
                        //                 color: AppColors.primary,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }),
                        // Obx(() {
                        //   print("Rebuilding address list with: ${checkoutCon.selectedAddress.value?.id}");
                        //   final addresses = addressCon.usersAddress;
                        //   if (addresses.isEmpty) {
                        //     return const Text("No saved addresses found.");
                        //   }
                        //
                        //   return ListView.separated(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: addresses.length,
                        //     separatorBuilder: (_, __) => const SizedBox(height: 12),
                        //     itemBuilder: (context, index) {
                        //       final addr = addresses[index];
                        //       final isSelected = checkoutCon.selectedAddress.value?.id == addr.id;
                        //
                        //       return InkWell(
                        //         onTap: () => checkoutCon.changeAddress(addr),
                        //         child: Container(
                        //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: isSelected ? AppColors.primary : Colors.grey.shade300,
                        //             ),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: isSelected ? AppColors.primary.withOpacity(0.05) : null,
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Text(
                        //                   "${addr.street}, ${addr.city}, ${addr.state}",
                        //                   style: const TextStyle(color: Colors.black54),
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        //                 color: AppColors.primary,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }),


                        const SizedBox(height: 18),

                        // Additional Instruction
                        const Row(
                          children: [
                            Icon(Icons.note_alt_outlined, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text("Additional Instruction",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: checkoutCon.customerNote,
                          decoration: InputDecoration(
                            hintText: "Add Note",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFEBEBEB)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: const Color(0xFFEBEBEB).withValues(alpha: 0.5)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 20),

                        // Order Summary
                        const Row(
                          children: [
                            Icon(Icons.event_note, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text("Order Summary",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.cartItems.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final cartItem = widget.cartItems[index];
                            final item = widget.cartItems;
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SafeNetworkImage(
                                        url: cartItem?.product?.imageUrl.isNotEmpty == true
                                            ? cartItem!.product!.imageUrl.first
                                            : "",
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cartItem?.product?.name ?? "",
                                          style: const TextStyle(fontSize: 15)),
                                      Text("Qty: ${cartItem?.quantity ?? 0}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black.withOpacity(0.6))),
                                      Text("₹${cartItem.lineTotal.toStringAsFixed(2)}",
                                          style: const TextStyle(fontSize: 15)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

