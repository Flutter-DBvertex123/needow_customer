// import 'package:get/get.dart';
// import 'package:newdow_customer/features/cart/model/services/couponServices.dart';
//
//
// import '../model/models/couponModel.dart';
//
//
// class CouponController extends GetxController{
//   RxInt finalAmount = 0.obs;
//   RxList<CouponModel> coupons = <CouponModel>[].obs;
//   Future<List<CouponModel>>getCoupons() async {
//     final data  = await Get.find<CouponService>().getCoupons();
//     coupons.value = data;
//     return data;
//   }
//
//   Future<void> redeamCupoon(String code,String userId,double amount) async {
//     finalAmount.value = await Get.find<CouponService>().redeemCoupon(code, userId, amount);
//   }
// }
/*
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/model/services/couponServices.dart';
import '../model/models/couponModel.dart';

class CouponController extends GetxController {
  RxDouble finalAmount = 0.0.obs;
  RxList<CouponModel> coupons = <CouponModel>[].obs;
  RxString appliedCouponCode = ''.obs;
  RxString appliedCategoryType = ''.obs; // Track which category has coupon applied
  RxDouble discountAmount = 0.0.obs;
  RxBool isCouponApplied = false.obs;

  /// Get all available coupons
  Future<List<CouponModel>> getCoupons() async {
    try {
      final data = await Get.find<CouponService>().getCoupons();
      coupons.value = data;
      return data;
    } catch (e) {
      print("Error fetching coupons: $e");
      rethrow;
    }
  }

  /// Redeem coupon with category-specific tracking
  Future<void> redeemCoupon({
    required String code,
    required String userId,
    required double amount,
    required String categoryType, // e.g., "grocery", "food", "medicine"
  }) async {
    try {
      if (code.isEmpty) {
        Get.snackbar('Error', 'Please enter a coupon code');
        return;
      }

      // Call coupon service to validate and redeem
      final result = await Get.find<CouponService>()
          .redeemCoupon(code, userId, amount);

      if (result != null && result > 0) {
        // Coupon was successfully applied
        appliedCouponCode.value = code;
        appliedCategoryType.value = categoryType;
        discountAmount.value = amount - result;
        finalAmount.value = result.toDouble();
        isCouponApplied.value = true;

        Get.snackbar(
          'Success',
          'Coupon applied! You saved ₹${discountAmount.value.toStringAsFixed(2)}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Invalid Coupon',
          'Coupon code is invalid or expired',
          snackPosition: SnackPosition.BOTTOM,
        );
        clearCoupon();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to apply coupon: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      clearCoupon();
    }
  }

  /// Legacy method for backward compatibility
  Future<void> redeamCupoon(String code, String userId, double amount) async {
    // Default category type if not specified
    await redeemCoupon(
      code: code,
      userId: userId,
      amount: amount,
      categoryType: 'default',
    );
  }

  /// Clear applied coupon
  void clearCoupon() {
    finalAmount.value = 0.0;
    appliedCouponCode.value = '';
    appliedCategoryType.value = '';
    discountAmount.value = 0.0;
    isCouponApplied.value = false;
  }

  /// Check if coupon is applied to specific category
  bool isCouponForCategory(String categoryType) {
    return isCouponApplied.value && appliedCategoryType.value == categoryType;
  }

  /// Get effective total for a category
  double getEffectiveTotal(String categoryType, double baseTotal) {
    if (isCouponForCategory(categoryType)) {
      return finalAmount.value;
    }
    return baseTotal;
  }

  /// Clear coupon when switching categories
  void clearCouponForCategory(String categoryType) {
    if (appliedCategoryType.value == categoryType) {
      clearCoupon();
    }
  }
}*/
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/model/services/couponServices.dart';
import '../model/models/couponModel.dart';

class CouponController extends GetxController {
   RxDouble finalAmount = 0.0.obs;
  final RxList<CouponModel> coupons = RxList<CouponModel>();
  final RxString appliedCouponCode = RxString('');
  final RxString appliedCategoryType = RxString(''); // Track which category has coupon applied
  final RxDouble discountAmount = RxDouble(0.0);
  final RxBool isCouponApplied = RxBool(false);

  /// Get all available coupons
  Future<List<CouponModel>> getCoupons() async {
    try {
      final data = await Get.find<CouponService>().getCoupons();
      coupons.value = data;
      return data;
    } catch (e) {
      print("Error fetching coupons: $e");
      rethrow;
    }
  }

  /// Redeem coupon with category-specific tracking
  Future<void> redeemCoupon({
    required String code,
    required String userId,
    required double amount,
    required String categoryType, // e.g., "grocery", "food", "medicine"
  }) async {
    try {
      if (code.isEmpty) {
        Get.snackbar('Error', 'Please enter a coupon code');
        return;
      }

      // Call coupon service to validate and redeem
      final result = await Get.find<CouponService>()
          .redeemCoupon(code, userId, amount);
      print("result $result");
      if (result != null && result > 0) {
        // Coupon was successfully applied
        appliedCouponCode.value = code;
        appliedCategoryType.value = categoryType;
        discountAmount.value = amount - result;
        finalAmount.value = result.toDouble();
        isCouponApplied.value = true;

        Get.snackbar(
          'Success',
          'Coupon applied! You saved ₹${discountAmount.value.toStringAsFixed(2)}',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Invalid Coupon',
          'Coupon code is invalid or expired',
          snackPosition: SnackPosition.BOTTOM,
        );
        clearCoupon();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to apply coupon: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      clearCoupon();
    }
  }

  /// Legacy method for backward compatibility
  Future<void> redeamCupoon(String code, String userId, double amount) async {
    // Default category type if not specified
    await redeemCoupon(
      code: code,
      userId: userId,
      amount: amount,
      categoryType: 'default',
    );
  }

  /// Clear applied coupon
  void clearCoupon() {
    finalAmount.value = 0.0;
    appliedCouponCode.value = '';
    appliedCategoryType.value = '';
    discountAmount.value = 0.0;
    isCouponApplied.value = false;
  }

  /// Check if coupon is applied to specific category
  bool isCouponForCategory(String categoryType) {
    return isCouponApplied.value && appliedCategoryType.value == categoryType;
  }

  /// Get effective total for a category
  double getEffectiveTotal(String categoryType, double baseTotal) {
    if (isCouponForCategory(categoryType)) {
      return finalAmount.value;
    }
    return baseTotal;
  }

  /// Clear coupon when switching categories
  void clearCouponForCategory(String categoryType) {
    if (appliedCategoryType.value == categoryType) {
      clearCoupon();
    }
  }
}