import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/auth/view/onboarding.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/constants.dart';
import '../../../widgets/appbutton.dart';
import '../controller/auth_controller.dart';
import 'otp_screen.dart';


class LoginScreen extends StatelessWidget {
  bool? isFromLogout;
  LoginScreen({super.key, this.isFromLogout});

  // Initialize the controller
  final _formKey = GlobalKey<FormState>();

  final controller =  Get.find<PhoneAuthController>();
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
              Text("Login",style: TextStyle(fontSize: 22),),
              SizedBox(),
            ],
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 16),
            child: IconButton(
              onPressed: () => Get.to(Onboarding()),
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
               child: Center(
                 child: SafeArea(
                   child: SingleChildScrollView(
                     child: Form(
                       key: _formKey,
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 24),
                           child: Obx(() => Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Container(
                                 alignment: Alignment.center,
                                 child: Column(

                                   children: [
                                     SvgPicture.asset(login_image,height: 181,width: 154,),
                                     SizedBox(height: 30,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                               'Login',
                                               style: TextStyle(
                                                   fontSize: 22,
                                                   fontWeight: FontWeight.bold,
                                                   color: Colors.black
                                               ),
                                             ),Text(
                                               'Enter your mobile number',
                                               style: TextStyle(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.bold,
                                                   color: Color(0xffB6B6B6)
                                               ),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),

                                     const SizedBox(height: 40),
                                     TextFormField(
                                       cursorColor: Colors.green,
                                       controller: controller.phoneController,
                                       inputFormatters: [
                                         FilteringTextInputFormatter.digitsOnly,
                                         LengthLimitingTextInputFormatter(10)
                                       ],
                                       keyboardType: TextInputType.number,
                                       decoration: InputDecoration(
                                         labelText: "Phone Number",
                                         prefixText: "+91 ",
                                         hintText: "Your phone number",
                                         hintStyle: TextStyle(color: AppColors.textSecondary),
                                         labelStyle: const TextStyle(color: Color(0xff0A9962)),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: const BorderSide(
                                             color: Color(0xff0A9962), // green border on focus
                                             width: 2,
                                           ),
                                         ),
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: const BorderSide(
                                             color: Color(0xff0A9962), // green border when not focused
                                             width: 1.5,
                                           ),
                                         ),
                                         border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                         ),
                                         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                       ),
                                       validator: (value) => controller.validatePhone(value ?? ""),
                                     ),
                                     const SizedBox(height: 30),

                                     // Send OTP / Verify OTP button
                                     Appbutton(
                                         buttonText: "Continue",
                                         onTap: ()  async  {
                                           if (_formKey.currentState!.validate()) {
                                              Get.find<LoadingController>().isLoading.value = true;
                                             final response = await Get.find<PhoneAuthController>().sendOtp();

                                             if(response['success']) {
                                               AppSnackBar.showSuccess(context, message: "Your Otp ${response['data']}");
                                               Get.off(OtpScreen(),);
                                               Get.find<LoadingController>().isLoading.value = false;
                                             }else{
                                               AppSnackBar.showError(context,message:"Failed to send otp",);
                                               Get.find<LoadingController>().isLoading.value = false;
                                             }
                                           }else{
                                             AppSnackBar.showError(context,message:"Invalid Credential",);
                                             Get.find<LoadingController>().isLoading.value = false;
                                           }

                                         },
                                     ),
                                     // OTP input field (only visible after OTP sent)
                                     if (controller.isOtpSent.value) ...[
                                       const SizedBox(height: 20),
                                       TextField(
                                         controller: controller.otpController,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                           hintText: 'Enter OTP',
                                           filled: true,
                                           fillColor: Colors.white,
                                           border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8),
                                             borderSide: BorderSide.none,
                                           ),
                                           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                         ),
                                       ),
                                     ],
                                     //SizedBox(height: 20,),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                           ),
                         ),
                       ),
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
