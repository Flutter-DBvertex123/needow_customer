import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/constants.dart';
import '../model/services/auth_services.dart';


class PhoneAuthController extends GetxController {


  // Text editing controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var verificationId = ''.obs;
  var errorMessage = ''.obs;

  // Phone number validation
  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Phone number cannot be empty";
    } else if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  // OTP validation
  String? validateOtp(String value) {
    if (value.isEmpty) {
      return "OTP cannot be empty";
    } else if (value.length != 4) {
      return "OTP must be 4 digits";
    }
    return null;
  }
  Future<Map<String,dynamic>> sendOtp() async {
    print("Dev :- sendOtp called");
    final data = await Get.find<AuthService>().sendOtp(phoneController.text.toString().trim()).timeout(
        Duration(seconds: 10),
        onTimeout: () {
         return {"success":false};
        });
    //return data['success'];
    return data;
  }
  Future<bool> verifyOtp() async {
    validateOtp(otpController.value.text);
    print("Dev :- sent Otp for verification called");
    final data = await Get.find<AuthService>().verifyOtp(phoneController.text.toString().trim(),otpController.text.toString().trim());
    if(data['success'] == true){
      //AuthStorage.saveUserInPrefs(data['user']);
      final user = await Get.find<ProfileController>().getUser(data['user']);
      print(" ussssssss${data['user']}");
      if(user != null ){
        print(user.email);
        print("user is not null in pref");
        await AuthStorage.saveUserInPrefs(user);
        final con = Get.find<ProfileController>();
       con.savedData.value = await AuthStorage.getUserFromPrefs();
        print(con.savedData.value?.email);
      }
      print("Dev :- Otp verified and saved in prefs ${AuthStorage.getAccessToken()}");
    print("Dev :- Otp verified and saved in prefs ${AuthStorage.getUserFromPrefs()}");
    }

    return data['success'];
  }

  // Send OTP
  // Future<void> sendOtp() async {
  //   final phone = phoneController.text.trim();
  //
  //   final phoneError = validatePhone(phone);
  //   if (phoneError != null) {
  //     Get.snackbar("Error", phoneError, snackPosition: SnackPosition.BOTTOM);
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // Auto-retrieval or instant verification
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         errorMessage.value = e.message ?? "Verification failed";
  //         Get.snackbar("Error", errorMessage.value,
  //             snackPosition: SnackPosition.BOTTOM);
  //       },
  //       codeSent: (String verId, int? resendToken) {
  //         verificationId.value = verId;
  //         isOtpSent.value = true;
  //         Get.snackbar("Success", "OTP sent successfully",
  //             snackPosition: SnackPosition.BOTTOM);
  //       },
  //       codeAutoRetrievalTimeout: (String verId) {
  //         verificationId.value = verId;
  //       },
  //     );
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     Get.snackbar("Error", errorMessage.value,
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Verify OTP
  // Future<void> verifyOtp() async {
  //   final otp = otpController.text.trim();
  //
  //   final otpError = validateOtp(otp);
  //   if (otpError != null) {
  //     Get.snackbar("Error", otpError, snackPosition: SnackPosition.BOTTOM);
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId.value, smsCode: otp);
  //
  //     await _auth.signInWithCredential(credential);
  //     Get.snackbar("Success", "Phone authentication successful",
  //         snackPosition: SnackPosition.BOTTOM);
  //   } on FirebaseAuthException catch (e) {
  //     errorMessage.value = e.message ?? "OTP verification failed";
  //     Get.snackbar("Error", errorMessage.value,
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Clear controllers
  void clearControllers() {
    phoneController.clear();
    otpController.clear();
    isOtpSent.value = false;
    verificationId.value = '';
    errorMessage.value = '';
  }
}
