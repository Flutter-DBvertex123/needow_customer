import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/profile/controller/wallet_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:newdow_customer/features/orders/model/models/createOrderModel.dart';
import 'package:newdow_customer/utils/constants.dart';
import '../../../widgets/appbutton.dart';
import '../../address/controller/addressController.dart';
import '../../cart/controller/checkout_controller.dart';
import '../../cart/view/payment_success_screen.dart';
import '../../orders/controllers/orderController.dart';
import '../../payment/paymentServices/makePaymentService.dart';

import '../../../widgets/snackBar.dart';
import '../model/services/paymentService.dart';

class PaymentMethodsController extends GetxController {
  // Controllers
  final OrderController orderController = Get.find<OrderController>();
  final AddressController addressController = Get.find<AddressController>();
  final CheckoutController checkoutController = Get.find<CheckoutController>();

  // Services
  late RazorpayService _razorpayService;
  final PaymentService _paymentService = PaymentServiceImpl();

  // Observable variables
  RxString selectedPaymentMethod = RxString("Cash");
  RxBool isProcessing = RxBool(false);
  RxBool isVerifying = RxBool(false);

  // Variables to hold order and amount
  CreateOrderModel? _order;
  double? _totalAmount;

  @override
  void onInit() {
    super.onInit();
    _razorpayService = RazorpayService(keyId: keyId, keySecret: secretId);
    // _setupAddressIfNeeded();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupAddressIfNeeded();   // ✔ Safe
    });
  }

  /// Setup default address if available
  void _setupAddressIfNeeded() {
    if (addressController.defaultAddress.value != null) {
      checkoutController.selectedAddress.value =
          addressController.defaultAddress.value;
    }
  }

  /// Initialize payment screen with order and amount
  void initializePayment(CreateOrderModel? order, double? totalAmount) {
    _order = order;
    _totalAmount = totalAmount;
  }

  /// Check if payment data is valid
  bool get hasValidData => _order != null && _totalAmount != null;

  /// Get total amount for display
  double? get totalAmount => _totalAmount;

  /// Get order for payment processing
  CreateOrderModel? get order => _order;

  /// Process payment based on selected method
  Future<void> processPayment(BuildContext context) async {
    if (!_validatePayment(context)) return;

    isProcessing.value = true;

    try {
      Get.find<LoadingController>().isLoading.value = true;

      switch (selectedPaymentMethod.value) {
        case "Cash":
          await _processCashPayment(context);
          break;
        case "Wallet":
          await _processWalletPayment(context);
          break;
        case "Razorpay":
          await _processRazorpayPayment(context);
          return; // Return early for Razorpay
        default:
          AppSnackBar.showError(context, message: "Invalid payment method");
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Payment failed: ${e.toString()}");
      print("Payment Error: $e");
    } finally {
      if (selectedPaymentMethod.value != "Razorpay") {
        Get.find<LoadingController>().isLoading.value = false;
        isProcessing.value = false;
      }
    }
  }

  /// Validate payment details
  bool _validatePayment(BuildContext context) {
    if (_order == null || _totalAmount == null) {
      AppSnackBar.showError(context, message: "Order details are missing");
      return false;
    }
    if (selectedPaymentMethod.value.isEmpty) {
      AppSnackBar.showError(context, message: "Please select a payment method");
      return false;
    }
    return true;
  }

  /// Process Cash Payment
  Future<void> _processCashPayment(BuildContext context) async {
    try {
      print("[PaymentMethodsController] Processing Cash Payment");

      _order!.paymentMethod = "Cash";
      _order!.paymentStatus = "pending";
      _order!.paymentId = "CASH_${DateTime.now().millisecondsSinceEpoch}";

      await _createOrder(context, _order!);
    } catch (e) {
      AppSnackBar.showError(context, message: "Cash payment error: $e");
      rethrow;
    }
  }

  /// Process Wallet Payment
  Future<void> _processWalletPayment(BuildContext context) async {
    try {
      print("[PaymentMethodsController] Processing Wallet Payment");

      // Check wallet balance - Uncomment when wallet controller is ready

       await Get.find<WalletController>().fetchWalletData(refresh: true);
       final walletBalance = await Get.find<WalletController>().currentBalance;
       print("Wallet balance $walletBalance");
      if (walletBalance < _totalAmount!) {
        print("Sufficient wallet balance not available");
        // final response = await Get.find<WalletController>().withdrawMoneyForOrderPayment(userId: order?.user ?? "", amount: _totalAmount!, description: "Order Payment");
        // if(response){
        //   AppSnackBar.showSuccess(context, message: "Order created successfully using wallet withdrawal");
        //   _order!.paymentMethod = "Wallet";
        //   _order!.paymentStatus = "paid";
        //   _order!.paymentId = "WALLET_${DateTime.now().millisecondsSinceEpoch}";
        //   await _createOrder(context, _order!);
        //   Get.find<LoadingController>().isLoading.value = false;
        //   return;
        }if(walletBalance > _totalAmount!){
        final response = await Get.find<WalletController>().withdrawMoneyForOrderPayment(userId: order?.user ?? "", amount: _totalAmount!, description: "Order Payment");
        if(response) {

          _order!.paymentMethod = "Wallet";
          _order!.paymentStatus = "paid";
          _order!.paymentId = "WALLET_${DateTime
              .now()
              .millisecondsSinceEpoch}";
          await _createOrder(context, _order!);
          Get
              .find<LoadingController>()
              .isLoading
              .value = false;
          AppSnackBar.showSuccess(context,
              message: "Order created successfully using wallet withdrawal");
          return;
        }
        AppSnackBar.showError(context, message: "Payment via wallet failed");
        return;
      }

      // Deduct from wallet
      // final deductResult = await walletController.deductFromWallet(_totalAmount!);
      // if (!deductResult) {
      //   AppSnackBar.showError(context, message: "Wallet deduction failed");
      //   return;
      // }

      //await _createOrder(context, _order!);
    } catch (e) {
      AppSnackBar.showError(context, message: "Wallet payment error: $e");
      rethrow;
    }
  }

  /// Process Razorpay Payment
  Future<void> _processRazorpayPayment(BuildContext context) async {
    try {
      if((_totalAmount == null || _order?.orderNumber == null) || (_totalAmount! < 0.0 || _order!.orderNumber!.isEmpty)){
        AppSnackBar.showError(context, message: "Razorpay Order creation failed error");
        Get.find<LoadingController>().isLoading.value = false;
        isProcessing.value = false;
        return;
      }
      final response = await createRezorpayOrder(_totalAmount!, _order!.orderNumber!);
      if (response != null && response['statusCode'] == 200) {
        final data = response['data'];

        // Extract response data
        String razorpayOrderId = data['razorpayOrderId'];
        int amount = data['amount'];
        String currency = data['currency'];
        String keyId = data['key_id'];

        print("[PaymentMethodsController] Initiating Razorpay Payment");
        _initiateRazorpayPayment(context,keyId, _order!, _totalAmount!,razorpayOrderId);
      }

    } catch (e) {
      AppSnackBar.showError(context, message: "Razorpay payment error: $e");
      Get.find<LoadingController>().isLoading.value = false;
      isProcessing.value = false;
      rethrow;
    }
  }

  /// Initiate Razorpay Payment
  void _initiateRazorpayPayment(
      BuildContext context,
      String key,
      CreateOrderModel order,
      double totalPrice,
      String orderId
      ) {
    _razorpayService.startPayment(
      context: context,
      amount: totalPrice,
      key:key,
      orderId: orderId,
      description: 'Order Payment',
      email: 'needowuser@example.com',
      phoneNumber: '9876543210',



      onSuccess: (PaymentSuccessResponse response) async {
        print("[PaymentMethodsController] Razorpay payment success");
        print("Payment ID: ${response.paymentId}");
        print("Order ID: ${response.orderId}");
        print("Signature ${response.signature}");
        final verificationResult = await Get.find<PaymentService>().verifyRazorpayPayment(razorpayOrderId: response.orderId ?? '', razorpayPaymentId: response.paymentId ?? "", razorpaySignature:  response.signature ?? "", orderId: orderId, userId: order.user! ?? "", amount: totalPrice);
        // await _verifyAndCreateOrder(
        //   context,
        //   order,
        //   response.paymentId ?? "",
        //   response.orderId ?? "",
        //   response.signature ?? "",
        // );
        print("status code of payment verfication ${verificationResult.statusCode}");
        if(verificationResult.statusCode == 200){
          await _createOrder(context, order);
        }else{
          print("Payment verification failed");
        }

      },
      onFailure: (PaymentFailureResponse response) {
        print("[PaymentMethodsController] Razorpay payment failed: ${response.message}");
        Get.find<LoadingController>().isLoading.value = false;
        isProcessing.value = false;
        AppSnackBar.showError(
          context,
          message: 'Payment Failed: ${response.message}',
        );
      },
    );
  }

  /// Verify Payment with Backend and Create Order
  Future<void> _verifyAndCreateOrder(
      BuildContext context,
      CreateOrderModel order,
      String paymentId,
      String orderId,
      String signature,
      ) async {
    try {
      isVerifying.value = true;
      print("[PaymentMethodsController] Verifying Razorpay payment with backend...");

      // Call payment service to verify payment
      final verificationResponse =
      await _paymentService.verifyRazorpayPayment(
        razorpayOrderId: orderId,
        razorpayPaymentId: paymentId,
        razorpaySignature: signature,
        orderId:  "",
        userId: order.user ?? "",
        amount: _totalAmount!,
      );

      print("[PaymentMethodsController] Verification Response: $verificationResponse");

      if (verificationResponse.success) {
        print("[PaymentMethodsController] Payment verified successfully");

        // Update order with payment details
        order.paymentId = paymentId;
        order.paymentMethod = "Razorpay";
        order.paymentStatus = "paid";

        // Create order in your system
        await _createOrder(context, order);
      } else {
        print("[PaymentMethodsController] Verification failed: ${verificationResponse.message}");
        AppSnackBar.showError(
          context,
          message: "Payment verification failed: ${verificationResponse.message}",
        );
      }
    } catch (e) {
      print("[PaymentMethodsController] Verification error: $e");
      AppSnackBar.showError(context, message: "Verification error: $e");
    } finally {
      isVerifying.value = false;
      Get.find<LoadingController>().isLoading.value = false;
      isProcessing.value = false;
    }
  }

  /// Create Order in your system
  Future<void> _createOrder(
      BuildContext context,
      CreateOrderModel order,
      ) async {
    try {
      print("[PaymentMethodsController] Creating order in system...");

      final orderData = await orderController.createOrder(order);

      if (orderData['success']) {
        AppSnackBar.showSuccess(
          context,
          message: 'Order placed successfully!',
        );

        String orderId = orderData["data"];
        print("[PaymentMethodsController] Order created successfully: $orderId");
        Get.find<LoadingController>().isLoading.value = false;
        // Navigate to success screen
       // orderData.map((e) => e.)
        Get.off(() => PaymentSuccessScreen(orderId: orderId));
      } else {
        print("[PaymentMethodsController] Order creation failed");
        AppSnackBar.showError(context, message: "Order creation failed!");
      }
    } catch (e) {
      print("[PaymentMethodsController] Order creation error: $e");
      AppSnackBar.showError(context, message: "Error: ${e.toString()}");
    }
  }

  /// Update selected payment method
  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    print("[PaymentMethodsController] Payment method changed to: $method");
  }

  Future<Map<String,dynamic>?> createRezorpayOrder(double amount, String orderNumber) async {
    print("creating r order");
    final response =  await Get.find<PaymentService>().createRazorpayOrder(amount: amount, receipt: orderNumber);
    return response;
  }

  /// Dispose Razorpay service
  @override
  void onClose() {
    _razorpayService.dispose();
    super.onClose();
  }
}