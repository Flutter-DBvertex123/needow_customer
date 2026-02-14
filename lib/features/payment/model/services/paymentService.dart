import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/widgets/appbutton.dart';

import '../../../../utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class PaymentService {
  Future<PaymentVerificationResponse> verifyRazorpayPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String orderId,
    required String userId,
    required double amount,
  });

  Future<Map<String, dynamic>?> createRazorpayOrder({
    required double amount,
    String currency = "INR",
    String receipt,
  });
}

class PaymentServiceImpl extends PaymentService {
  Future<PaymentVerificationResponse> verifyRazorpayPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String orderId,
    required String userId,
    required double amount,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/payments/razorpay/verify');

      final requestBody = {
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
        "orderId": orderId,
        "userId": userId,
        "amount": amount,
      };

      print('Razorpay Verification Request:');
      print('URL: $url');
      print('Body: $requestBody');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(
         Duration(seconds: 30),
        onTimeout: () { Get.find<LoadingController>().isLoading.value = false;
           throw TimeoutException('The connection has timed out, Please try again!');},
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body verify payent: ${response.body}');

      return _handleVerificationResponse(response);
    } catch (e) {
      print('Razorpay Verification Error: $e');
      return PaymentVerificationResponse(
        success: false,
        message: 'Error: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  Future<Map<String, dynamic>?> createRazorpayOrder({
    required double amount,
    String currency = "INR",
    String? receipt,
  }) async {
    try {
      // Convert amount to paise (smallest unit)
      //int amountInPaise = (amount * 100).toInt();

      // API endpoint
      final url = Uri.parse("$baseUrl/payments/razorpay/create-order");
      print("djndksjadsjkdjnc");
      print(amount);
      print(currency);
      print(receipt);
      // Request body
      final body = {
        "amount": amount,
        "currency": currency,
        "receipt": receipt ?? "",
      };


      print("Creating Razorpay order...");
      print("URL: $url");
      print("Body: ${jsonEncode(body)}");

      // Make POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Bodyyy: ${jsonDecode(response.body)}");

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("✅ Order created successfully");
        return responseData;
      } else {
        print("❌ Failed to create order: ${response.statusCode}");
        print("Error: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception while creating Razorpay order: $e");
      return null;
    }
  }
}

PaymentVerificationResponse _handleVerificationResponse(http.Response response) {
  try {
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return PaymentVerificationResponse(
        success: true,
        message: jsonResponse['message'] ?? 'Payment verified successfully',
        statusCode: jsonResponse["statusCode"],
        data: jsonResponse['data'],
      );
    } if (response.statusCode == 201) {
      return PaymentVerificationResponse(
        success: true,
        message: jsonResponse['message'] ?? 'Payment verified successfully',
        statusCode: jsonResponse["statusCode"],
        data: jsonResponse['data'],
      );
    }
    else if (response.statusCode == 400) {
      return PaymentVerificationResponse(
        success: false,
        message: jsonResponse['message'] ?? 'Invalid payment details',
        statusCode: response.statusCode,
        error: jsonResponse['error'],
      );
    } else if (response.statusCode == 401) {
      return PaymentVerificationResponse(
        success: false,
        message: 'Unauthorized: Invalid credentials',
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 404) {
      return PaymentVerificationResponse(
        success: false,
        message: 'Order not found',
        statusCode: response.statusCode,
      );
    } else {
      return PaymentVerificationResponse(
        success: false,
        message: 'Payment verification failed',
        statusCode: response.statusCode,
        error: jsonResponse['error'],
      );
    }
  } catch (e) {
    return PaymentVerificationResponse(
      success: false,
      message: 'Failed to parse response: ${e.toString()}',
      statusCode: 500,
    );
  }
}


/// Model for verification response
class PaymentVerificationResponse {
  final bool success;
  final String message;
  final int statusCode;
  final dynamic data;
  final dynamic error;

  PaymentVerificationResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
    this.error,
  });

  @override
  String toString() {
    return 'PaymentVerificationResponse(success: $success, message: $message, statusCode: $statusCode)';
  }


}