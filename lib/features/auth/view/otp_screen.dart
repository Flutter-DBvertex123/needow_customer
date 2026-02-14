import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/auth/view/allow_location_screen.dart';
import 'package:newdow_customer/features/auth/view/login_screen.dart';
import 'package:newdow_customer/features/auth/view/splash_screen.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:pinput/pinput.dart';
import '../../../utils/app_services/firebase_notification_service.dart';
import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../../../widgets/navbar.dart';
import '../../address/controller/addressController.dart';
import '../controller/auth_controller.dart';


class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final PhoneAuthController controller = Get.find<PhoneAuthController>();
  DateTime? lastPressed;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();

        // First Back Press
        if (lastPressed == null ||
            now.difference(lastPressed!) > Duration(seconds: 2)) {

          lastPressed = now;

          // Show message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Press back again to exit"),
              duration: Duration(seconds: 1),
            ),
          );

          return false; // do not exit yet
        }

        // Second Back Press → Exit
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 75,

              toolbarHeight: 0.1.toHeightPercent(),
              surfaceTintColor: AppColors.background,

              title: Column(
                children: [
                  Text("Verification Code",style: TextStyle(fontSize: 22),),
                  SizedBox(),
                ],
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 16),
                child: IconButton(
                  onPressed: () => Get.to(LoginScreen()),
                  icon: CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    radius: 30,
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: AppColors.primary,
                      size: 25,
                      weight: 800,
                    ),
                  ),
                ),
              ),


              // Provide a standard title.
              actions: [
                SizedBox(height: 48,width: 48,),
              ],
              centerTitle: true,
              // Pin the app bar when scrolling.
              pinned: true,
              // Display a placeholder widget to visualize the shrinking size.
              // Make the initial height of the SliverAppBar larger than normal.
              collapsedHeight: 0.1.toHeightPercent(),
            ),
            SliverToBoxAdapter(
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 70),
                            const Text(
                              'We have sent the verification code to your Phone Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB6B6B6),
                              ),
                            ),
                            const SizedBox(height: 60),

                            // OTP Input
                            Pinput(
                              separatorBuilder: (index){return SizedBox(width: 22);} ,
                              length: 4,
                              controller: controller.otpController,
                              keyboardType: TextInputType.number,
                              onCompleted: (pin) {
                                //controller.verifyOtp();
                              },
                              defaultPinTheme: PinTheme(
                                width: 65,
                                height: 65,
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffDDDDDD)),
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                              ),focusedPinTheme: PinTheme(

                              width: 70,
                              height: 60,
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff0A9962)),
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white,
                              ),
                            ),
                            ),

                            const SizedBox(height: 20),

                            // Resend text
                            GestureDetector(
                              onTap: () async {
                                controller.otpController.clear();
                               // final isOtpSended =  await controller.sendOtp();
                               // if(isOtpSended){
                               //   AppSnackBar.showSuccess(context, message: "Default Otp 1234");
                               // }
                                final response = await Get.find<PhoneAuthController>().sendOtp();

                                if(response['success']) {
                                  AppSnackBar.showSuccess(context, message: "Your Otp ${response['data']}");
                                  Get.off(() => OtpScreen());
                                  Get.find<LoadingController>().isLoading.value = false;
                                }
                              },
                              child: const Text(
                                "Didn't receive a code ?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff0A9962),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Login button
                            Appbutton(
                              buttonText: "Continue",
                              onTap: ()  async {
                                Get.find<LoadingController>()
                                    .isLoading
                                    .value = true;
                                bool isLoggedIn = await Get.find<PhoneAuthController>().verifyOtp().timeout(Duration(seconds: 30),onTimeout: () => Get.find<LoadingController>().isLoading.value = false);
                                if (isLoggedIn) {
                                  Get.find<PhoneAuthController>().otpController.clear();
                                  final fcmService = Get.find<FCMService>();
                                  if (fcmService.pendingIntent != null) {
                                    // If user came from a notification
                                    Get.offAll(() => SplashScreen()); // Splash will handle navigation to order
                                  }

                                    await Get.find<AddressController>().loadAddresses();

                                  Get.find<LoadingController>().isLoading.value = false;
                                  Get.off(AllowLocationScreen());
                                } else {
                                  Get.find<LoadingController>().isLoading.value = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Failed")));
                                }
                              }
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
