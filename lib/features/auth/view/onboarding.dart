import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../utils/constants.dart';
import 'login_screen.dart';
class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 1.toWidthPercent(),
            ),
            Image.asset(logoDark),
            GestureDetector(
              onTap: () => Get.off(LoginScreen()),
              child: Container(
                width: 113,
                height: 42,
                padding: EdgeInsets.all(6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff0B573C),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Let,s Go",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      )
    );
  }
}
