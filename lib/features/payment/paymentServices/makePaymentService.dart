// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:flutter/material.dart';
//
// import '../../cart/view/payment_success_screen.dart';
//
// class RazorpayService {
//   late Razorpay _razorpay;
//   final String keyId;
//   final String keySecret;
//
//   RazorpayService({
//     required this.keyId,
//     required this.keySecret,
//   }) {
//    // _razorpay = Razorpay();
//     _setupListeners();
//   }
//
//   void _setupListeners() {
//     _razorpay.clear();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   void startPayment({
//     required BuildContext context,
//     required double amount,
//     required String description,
//     required String email,
//     required String phoneNumber,
//     required Function(PaymentSuccessResponse) onSuccess,
//     required Function(PaymentFailureResponse) onFailure,
//   }) {
//     _razorpay = Razorpay();
//     _setupListeners();
//     var options = {
//       'key': keyId,
//       'amount': (amount * 100).toInt(), // Amount in paisa
//       'name': 'Your Company Name',
//       'description': description,
//       'prefill': {
//         'contact': phoneNumber,
//         'email': email,
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//       _onSuccess = onSuccess;
//       _onFailure = onFailure;
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   late Function(PaymentSuccessResponse) _onSuccess;
//   late Function(PaymentFailureResponse) _onFailure;
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("Payment Success: ${response.paymentId}");
//     _onSuccess(response);
//     _razorpay.clear();
//     //Get.to(PaymentSuccessScreen());
//
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Payment Error: ${response.message}");
//     _onFailure(response);
//     _razorpay.clear();
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print("External Wallet: ${response.walletName}");
//   }
//
//   void dispose() {
//     _razorpay.clear();
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;
  final String keyId;
  final String keySecret;

  RazorpayService({
    required this.keyId,
    required this.keySecret,
  });

  void startPayment({
    required BuildContext context,
    required double amount,
    required key,
    required String description,
    required String email,
    required String orderId,
    required String phoneNumber,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) {
print("order Id : ${orderId}");
    // Create fresh instance for every payment
    _razorpay = Razorpay();

    // Store callbacks
    _onSuccess = onSuccess;
    _onFailure = onFailure;

    // Set fresh listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    var options = {
      'key': key,
      'order_id': orderId,
      'amount': (amount * 100).toInt(),
      'name': 'Needow',
      'description': description,
      'prefill': {
        'contact': phoneNumber,
        'email': email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  late Function(PaymentSuccessResponse) _onSuccess;
  late Function(PaymentFailureResponse) _onFailure;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");
    print("Payment Success: ${response.orderId}");
    print("Payment Success: ${response.signature}");
    _onSuccess(response);
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _onFailure(response);
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
