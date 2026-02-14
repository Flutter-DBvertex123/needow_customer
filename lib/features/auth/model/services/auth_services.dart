import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:newdow_customer/utils/app_services/firebase_notification_service.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/prefs.dart';
import '../models/userModel.dart';
class AuthService {

  //Send Otp to users mobile
  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    print("Dev :- sending otp request");
    Uri uri = Uri.parse(sendOtpApi);
    print("Dev :- API Call $uri $phoneNumber");
    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "phone": phoneNumber,
        }),
      );
      final decodedResponse = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // success
        print("Dev :- Otp Sent successfully");
        print("Dev :- API$sendOtp Response header ${response.headers} body ${response.body}");
        final decodedResponse = jsonDecode(response.body);
        print("Dev:- $decodedResponse");
        return {"success":true,"message": decodedResponse["message"],"data": decodedResponse['otp']};
        //return response;
      } else {
        // failure
        return {"success":false,"message": decodedResponse["message"]};
      }
    } catch (e) {
      throw Exception("Error sending OTP: $e");
    }
  }

  //verify Otp
  Future<Map<String,dynamic>> verifyOtp(String phoneNumber, String otp)async {
    print("Dev :- sending otp request ${fcmToken.value}");

    Uri uri = Uri.parse(verifyOtpApi).replace(
      queryParameters: {
        "phone": phoneNumber,
        "otp": otp,
        "firebase_token": fcmToken.value
      },
    );
    print("Dev :- API Call $uri $otp $phoneNumber");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      print("Dev:- ${response.body}");
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // success
        print("Dev :- Otp verified");
        print("Dev :- API$sendOtp Response header ${response.headers} body ${response.body}");
        await AuthStorage.saveAccessToken(decodedResponse['access_token']);
        //print("Dev :- Access Token saved $accessToken");
        return {"success":true,"message": decodedResponse["message"],"user": decodedResponse['user']["id"]};

        //return response;
      } else {
        // failure
        return {"success":false,"message": decodedResponse["message"]};
      }
    } catch (e) {
      throw Exception("Error sending OTP: $e");
    }
  }

}