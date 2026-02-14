
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SizeRatios on num {

  double toWidthPercent() {
    Size size = MediaQuery.sizeOf(Get.context!);
    return size.width * this;
  }
  double toHeightPercent() {
    Size size = MediaQuery.sizeOf(Get.context!);
    return size.height * this;
  }

}