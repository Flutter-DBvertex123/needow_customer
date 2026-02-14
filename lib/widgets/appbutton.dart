// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:newdow_customer/utils/getSize.dart';
//
// class Appbutton extends StatelessWidget {
//   bool? isLoading;
//   Callback onTap;
//   String buttonText;
//   Icon? buttonIcon;
//   Appbutton({super.key,required this.buttonText,this.buttonIcon,required this.onTap,required this.isLoading});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 58,
//         alignment: Alignment.center,
//         constraints: BoxConstraints(
//           minWidth: 0.8.toWidthPercent(),
//       ),
//         decoration: BoxDecoration(
//           color: Color(0xff0A9962),
//           borderRadius: BorderRadius.circular(27),
//         ),
//         child: isLoading ? CircularProgressIndicator(color: Colors.white,) :Text(buttonText,style: TextStyle(color: Colors.white,fontSize:18 ),),
//         ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/utils/getSize.dart';

class LoadingController extends GetxController {
  RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}

// Step 2: Updated AppButton Widget

class Appbutton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Icon? buttonIcon;
  final Color? backgroundColor;

   Appbutton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.buttonIcon,
    this.backgroundColor,
  });
  final controller = Get.find<LoadingController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => InkWell(
        onTap: (controller.isLoading?.value ?? false) ? null : onTap,
        child: Container(
          height: 58,
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minWidth: 0.8.toWidthPercent(),
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Color(0xff0A9962),
            borderRadius: BorderRadius.circular(27),
          ),
          child: (controller.isLoading?.value ?? false)
              ? CircularProgressIndicator(color: Colors.white)
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonIcon != null) ...[
                buttonIcon!,
                SizedBox(width: 8),
              ],
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
