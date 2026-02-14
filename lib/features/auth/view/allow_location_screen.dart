import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/view/use_current_location_screen.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/navbar.dart';

import '../../address/controller/addressController.dart';
import '../../address/view/create_address_screen.dart';

class AllowLocationScreen extends StatelessWidget {
  AllowLocationScreen({super.key});
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
        body: Stack(
          children: [
            Positioned(
              right: 22,
              top: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Get.to(CustomBottomNav());
                  //     },
                  //     style: ButtonStyle(
                  //         backgroundColor: WidgetStatePropertyAll(Color(0xff0A9962)),
                  //       fixedSize: WidgetStatePropertyAll(Size(65, 37)),
                  //
                  //     ),
                  //     child: Text('Skip',style: TextStyle(color: Colors.white,fontSize: 18),)
                  // )
                  ElevatedButton(
                  onPressed: () {
                     Get.to(CustomBottomNav());
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0A9962),
                        fixedSize: const Size(90, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24), // 👈 Add radius here
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )
                ],
              ),
            ),

            Positioned(
              top: 0.29*MediaQuery.of(context).size.height,
              width: 1.toWidthPercent(),
              child: Container(
                padding: EdgeInsets.all(22),
                child: Column(
                  spacing: 30,
                  children: [
                    SvgPicture.asset(allow_location),
                    Text(
                      "What is Your Location?",
                      style: TextStyle(fontSize: 25),
                    ),
                    Appbutton(
                      buttonText: "Allow Location Access",
                      onTap: () => Get.off(LocationPickerScreen()),

                    ),
                    InkWell(
                      onTap: () => Get.off(AddAddressScreen(initialAddress: Get.find<AddressController>().defaultAddress.value,)),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(minHeight: 54, minWidth: 160),
                        decoration: BoxDecoration(
                          color: Color(0xffEBEBEB),
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Text(
                          "Enter Location Manually",
                          style: TextStyle(color: Color(0x80000000), fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
