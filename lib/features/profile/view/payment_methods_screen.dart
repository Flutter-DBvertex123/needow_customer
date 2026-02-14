// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/snackBar.dart';
//
// class PaymentMethodsScreen extends StatefulWidget {
//   CreateOrderModel? order;
//   double? totalAmount;
//   PaymentMethodsScreen({super.key,this.order,this.totalAmount});
//
//   @override
//   State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
// }
//
// class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
//   String selectedMethod = "Cash";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Appbutton(
//             buttonText: "Make Payment",
//             /* onTap: () async {
//               Get.find<LoadingController>().isLoading.value = true;
//               String userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "");
//               print("before creating order :- ${userId}");
//               final order = await orderCon.checkoutOrder(widget.cartItems, cartCon.grandTotal,checkoutCon,userId);
//               _initiatePayment(order, cartCon.grandTotal);
//               Get.find<LoadingController>().isLoading.value = false;
//             },*/
//             onTap: () async {
//               Get.find<LoadingController>().isLoading.value = true;
//               Get.find<LoadingController>().isLoading.value = false;
//             },
//           ),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           slivers: [
//             DefaultAppBar(titleText: "Payment Methods",isFormBottamNav: false,),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 2,left: 16,right: 16,bottom: 16),
//                 child: Container(
//                   height: 0.7.toHeightPercent(),
//                   child: ListView(
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       // Cash Section
//                       const Text("Cash", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                       const SizedBox(height: 8),
//                       PaymentOptionTile(
//                         icon: Icons.attach_money,
//                         title: "Cash",
//                         isSelected: selectedMethod == "Cash",
//                         onTap: () => setState(() => selectedMethod = "Cash"),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Wallet Section
//                       const Text("Wallet", style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       PaymentOptionTile(
//                         icon: Icons.account_balance_wallet,
//                         title: "Wallet",
//                         isSelected: selectedMethod == "Wallet",
//                         onTap: () => setState(() => selectedMethod = "Wallet"),
//                       ),
//                       const SizedBox(height: 16),
//
//                       const Text("Razorpay", style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       PaymentOptionTile(
//                         icon: Icons.account_balance_wallet,
//                         title: "Razorpay",
//                         isSelected: selectedMethod == "Razorpay",
//                         onTap: () => setState(() => selectedMethod = "Razorpay"),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Credit & Debit Card Section
//                       // const Text("Credit & Debit Card",
//                       //     style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       // Card(
//                       //   color: AppColors.secondary,
//                       //   shape: RoundedRectangleBorder(
//                       //     borderRadius: BorderRadius.circular(12),
//                       //     side: BorderSide(color: Colors.grey.shade300),
//                       //   ),
//                       //   child: ListTile(
//                       //     leading: const Icon(Icons.credit_card, color: Colors.green),
//                       //     title: const Text("Add Card"),
//                       //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       //     onTap: () {
//                       //       // Add card flow
//                       //     },
//                       //   ),
//                       // ),
//                       // const SizedBox(height: 16),
//                       //
//                       // // More Payment Options
//                       // const Text("More Payment Options",
//                       //     style: TextStyle(fontWeight: FontWeight.bold)),
//                       // const SizedBox(height: 8),
//                       // _buildOtherPaymentOptionsTile(paypal, "Paypal",  selectedMethod == "Paypal", () => setState(() => selectedMethod = "Paypal"),),
//                       // _buildOtherPaymentOptionsTile(apple_pay, "apple_pay",  selectedMethod == "Apple Pay", () => setState(() => selectedMethod = "Apple Pay"),),
//                       // _buildOtherPaymentOptionsTile(google_pay, "Google Pay",  selectedMethod == "Google Pay", () => setState(() => selectedMethod = "Google Pay"),)
//                       //   // PayPal icon replacement
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//
//         ),
//       ),
//     );
//   }
//   Widget _buildOtherPaymentOptionsTile(String icon,String title, bool isSelected,VoidCallback onTap) {
//     return Container(
//       child: ListTile(
//         leading: SvgPicture.asset(icon),
//         title: Text(title),
//         trailing: Icon(
//           isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
//           color: isSelected ? AppColors.primary : Colors.grey,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
//
// class PaymentOptionTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const PaymentOptionTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.secondary,
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.green),
//         title: Text(title),
//         trailing: Icon(
//           isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
//           color: isSelected ? Colors.green : Colors.grey,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
/*
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../utils/constants.dart' as orderCon;
import '../../../widgets/appbutton.dart';
import '../../../widgets/snackBar.dart';
import '../../address/controller/addressController.dart';
import '../../cart/controller/checkout_controller.dart';
import '../../cart/view/payment_success_screen.dart';
import '../../orders/controllers/orderController.dart';
import '../../payment/paymentServices/makePaymentService.dart';

class PaymentMethodsScreen extends StatefulWidget {
  CreateOrderModel? order;
  double? totalAmount;
  PaymentMethodsScreen({super.key, this.order, this.totalAmount});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selectedMethod = "Cash";
  bool isProcessing = false;

  final orderCon = Get.find<OrderController>();
  final addressCon = Get.find<AddressController>();
  final checkoutCon = Get.find<CheckoutController>();
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService(keyId: keyId, keySecret: secretId);
    if (addressCon.defaultAddress.value != null) {
      checkoutCon.selectedAddress.value = addressCon.defaultAddress.value;
    }
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  void _initiateRazorpayPayment(CreateOrderModel order, double totalPrice) {
    _razorpayService.startPayment(
      context: context,
      amount: totalPrice,
      description: 'Order Payment',
      email: 'needowuser@example.com',
      phoneNumber: '9876543210',
      onSuccess: (PaymentSuccessResponse response) async {
        order.paymentId = response.paymentId;
        order.paymentMethod = "Razorpay";
        order.paymentStatus = "paid";

        await _createOrder(order);
      },
      onFailure: (PaymentFailureResponse response) {
        AppSnackBar.showError(
          context,
          message: 'Payment Failed: ${response.message}',
        );
        Get.find<LoadingController>().isLoading.value = false;
      },
    );
  }

  Future<void> _createOrder(CreateOrderModel order) async {
    try {
      final orderData = await orderCon.createOrder(order);
      if (orderData['success']) {
        AppSnackBar.showSuccess(context, message: 'Order placed successfully!');
        String orderId = orderData["data"];
        print("OrderId: $orderId");
        Get.off(() => PaymentSuccessScreen(orderId: orderId));
      } else {
        AppSnackBar.showError(context, message: "Order creation failed!");
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Error: ${e.toString()}");
    } finally {
      Get.find<LoadingController>().isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasValidData = widget.order != null && widget.totalAmount != null;

    return Scaffold(
      bottomNavigationBar: hasValidData
          ? SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Appbutton(
            buttonText: "Make Payment",
            onTap: isProcessing
                ? () {}
                : () => _processPayment(),
          ),
        ),
      )
          : null,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            DefaultAppBar(
              titleText: "Payment Methods",
              isFormBottamNav: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, left: 16, right: 16, bottom: 16),
                child: Container(
                  height: 0.7.toHeightPercent(),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (!hasValidData)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange.shade300),
                          ),
                          child: const Text(
                            "Order details are missing. Please go back and try again.",
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Cash Section
                      const Text(
                        "Cash",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      PaymentOptionTile(
                        icon: Icons.attach_money,
                        title: "Cash",
                        isSelected: selectedMethod == "Cash",
                        onTap: () => setState(() => selectedMethod = "Cash"),
                      ),
                      const SizedBox(height: 16),
                      // Wallet Section
                      const Text(
                        "Wallet",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      PaymentOptionTile(
                        icon: Icons.account_balance_wallet,
                        title: "Wallet",
                        isSelected: selectedMethod == "Wallet",
                        onTap: () => setState(() => selectedMethod = "Wallet"),
                      ),
                      const SizedBox(height: 16),
                      // Razorpay Section
                      const Text(
                        "Razorpay",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      PaymentOptionTile(
                        icon: Icons.account_balance_wallet,
                        title: "Razorpay",
                        isSelected: selectedMethod == "Razorpay",
                        onTap: () => setState(() => selectedMethod = "Razorpay"),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (!_validatePayment()) return;

    setState(() => isProcessing = true);
    Get.find<LoadingController>().isLoading.value = true;

    try {
      print("Processing Payment - Method: $selectedMethod");

      switch (selectedMethod) {
        case "Cash":
          await _processCashPayment();
          break;
        case "Wallet":
          await _processWalletPayment();
          break;
        case "Razorpay":
          _initiateRazorpayPayment(widget.order!, widget.totalAmount!);
          return;
        default:
          AppSnackBar.showError(context, message: "Invalid payment method");
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Payment failed: ${e.toString()}");
      print("Payment Error: $e");
    } finally {
      if (selectedMethod != "Razorpay") {
        Get.find<LoadingController>().isLoading.value = false;
        setState(() => isProcessing = false);
      }
    }
  }

  bool _validatePayment() {
    if (widget.order == null || widget.totalAmount == null) {
      AppSnackBar.showError(context, message: "Order details are missing");
      return false;
    }
    if (selectedMethod.isEmpty) {
      AppSnackBar.showError(context, message: "Please select a payment method");
      return false;
    }
    return true;
  }

  Future<void> _processCashPayment() async {
    try {
      // For Cash payment, directly create order without payment gateway
      widget.order!.paymentMethod = "Cash";
      widget.order!.paymentStatus = "paid";
      widget.order!.paymentId = "CASH_${DateTime.now().millisecondsSinceEpoch}";

      await _createOrder(widget.order!);
    } catch (e) {
      AppSnackBar.showError(context, message: "Cash payment error: $e");
      rethrow;
    }
  }

  Future<void> _processWalletPayment() async {
    try {
      // Check wallet balance first
      // Assuming you have a wallet controller
      // final walletBalance = await walletController.getBalance();

      // if (walletBalance < widget.totalAmount!) {
      //   AppSnackBar.showError(context, message: "Insufficient wallet balance");
      //   return;
      // }

      // Deduct from wallet
      // final deductResult = await walletController.deductFromWallet(widget.totalAmount!);

      // if (deductResult) {
      widget.order!.paymentMethod = "Wallet";
      widget.order!.paymentId = "WALLET_${DateTime.now().millisecondsSinceEpoch}";

      await _createOrder(widget.order!);
      // } else {
      //   AppSnackBar.showError(context, message: "Wallet deduction failed");
      // }
    } catch (e) {
      AppSnackBar.showError(context, message: "Wallet payment error: $e");
      rethrow;
    }
  }
}

class PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? AppColors.primary : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/features/profile/controller/wallet_controller.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import '../../payment/controller/paymentController.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final CreateOrderModel? order;
  final double? totalAmount;

  const PaymentMethodsScreen({
    super.key,
    this.order,
    this.totalAmount,
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late PaymentMethodsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PaymentMethodsController());
    controller.initializePayment(widget.order, widget.totalAmount);
  }

  @override
  void dispose() {
    Get.find<PaymentMethodsController>().dispose();
    Get.delete<PaymentMethodsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: controller.hasValidData
          ? _buildBottomPaymentButton(context)
          : const SizedBox.shrink(),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
             DefaultAppBar(
              titleText: "Payment Methods",
              isFormBottamNav: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 2,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Container(
                  height: 0.7.toHeightPercent(),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (!controller.hasValidData)
                        _buildMissingDataWarning(),
                      const SizedBox(height: 16),
                      _buildPaymentSection(
                        title: "Cash",
                        method: "Cash",
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: 16),
                      _buildPaymentSection(
                        title: "Wallet",
                        method: "Wallet",
                        icon: Icons.account_balance_wallet,
                      ),
                      const SizedBox(height: 16),
                      _buildPaymentSection(
                        title: "Razorpay",
                        method: "Razorpay",
                        icon: Icons.account_balance_wallet,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build missing data warning widget
  Widget _buildMissingDataWarning() {
    return Container(
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.orange.shade50,
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(color: Colors.orange.shade300),
      // ),
      // child: const Text(
      //   "Order details are missing. Please go back and try again.",
      //   style: TextStyle(
      //     color: Colors.orange,
      //     fontWeight: FontWeight.w500,
      //   ),
      // ),
    );
  }

  /// Build payment method section with title and tile
  Widget _buildPaymentSection({
    required String title,
    required String method,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
              () => _PaymentTile(
            icon: icon,
            title: title,
            isSelected: controller.selectedPaymentMethod.value == method,
            //onTap: () => controller.updatePaymentMethod(method),
                onTap: () {

                    controller.updatePaymentMethod(method);
                 
                },

              ),
        ),
      ],
    );
  }

  /// Build bottom payment button
  Widget _buildBottomPaymentButton(BuildContext context) {
    return Obx(
          () => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Appbutton(
            buttonText: controller.isProcessing.value
                ? "Processing..."
                : "Make Payment",
            onTap: controller.isProcessing.value
                ? () {}
                : () => controller.processPayment(context),
          ),
        ),
      ),
    );
  }
}

/// Reusable Payment Option Tile Widget
class _PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        //subtitle: title == "Wallet"? Text("Balance ${Get.find<WalletController>().currentBalance.value.toString()}") : null,
        trailing: title == "Wallet" ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(("Balance \₹${Get.find<WalletController>().currentBalance.value.toStringAsFixed(2)}")),
            SizedBox(width: 10,),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ],
        ): Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? AppColors.primary : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}