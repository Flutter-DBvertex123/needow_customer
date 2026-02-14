
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/model/businessServices/business_type_service.dart';
import 'package:newdow_customer/features/home/model/models/buisness_type_model.dart';

import '../../product/models/model/ProductModel.dart';

class BusinessController extends GetxController{

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadBusinessTypes();
  }
  RxList<BusinessTypeModel> businessTypes = <BusinessTypeModel>[].obs;
  RxBool isLoading = false.obs;
  Future<void> loadBusinessTypes() async {
    businessTypes.clear();
    final data = await Get.find<BusinessTypeService>().getAllBusinessTypes();
    businessTypes.assignAll(data);
  }

  void clearDashboardData() {
    // clear food/grocery/pharmacy lists
  }

  Future<void> loadDashboardData({required String city}) async {
    // fetch food, grocery, pharmacy based on city
  }
  Future<List<BusinessTypeModel>> getBusinessAllTypes() async {
    final data = await Get.find<BusinessTypeService>().getAllBusinessTypes();
    businessTypes.value = data;
    print("Business type ${businessTypes.length} ");

    return data;
  }
}
// import 'package:get/get
// .dart';
// import 'package:newdow_customer/features/home/model/businessServices/business_type_service.dart';
// import 'package:newdow_customer/features/home/model/models/buisness_type_model.dart';
//
// class BusinessController extends GetxController {
//   RxList<BusinessTypeModel> businessTypes = <BusinessTypeModel>[].obs;
//   RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Load business types when controller initializes
//     loadBusinessTypes();
//   }
//
//   /// Load all business types from API
//   Future<void> loadBusinessTypes({String? city}) async {
//     try {
//       isLoading.value = true;
//
//       final data = await Get.find<BusinessTypeService>().getAllBusinessTypes();
//
//       // If city is provided, filter business types by city
//       if (city != null && city.isNotEmpty) {
//         final filtered = data.where((business) =>
//             business.cities.contains(city)
//         ).toList();
//         businessTypes.assignAll(filtered);
//       } else {
//         businessTypes.assignAll(data);
//       }
//
//       print("Business types loaded: ${businessTypes.length}");
//     } catch (e) {
//       print("Error loading business types: $e");
//       businessTypes.clear();
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Refresh business types (useful for pull-to-refresh)
//   Future<void> refreshBusinessTypes({String? city}) async {
//     await loadBusinessTypes(city: city);
//   }
//
//   /// Clear dashboard data when address changes
//   void clearDashboardData() {
//     // You can implement clearing of cached products here if needed
//     print("Dashboard data cleared");
//   }
//
//   /// Load dashboard data based on city
//   Future<void> loadDashboardData({required String city}) async {
//     try {
//       // Reload business types filtered by city
//       await loadBusinessTypes(city: city);
//
//       // You can add additional dashboard data loading here
//       // For example: featured products, promotions, etc.
//     } catch (e) {
//       print("Error loading dashboard data: $e");
//     }
//   }
//
//   /// Legacy method - kept for backward compatibility
//   /// Consider using loadBusinessTypes() instead
//   @Deprecated('Use loadBusinessTypes() instead')
//   Future<List<BusinessTypeModel>> getBusinessAllTypes() async {
//     final data = await Get.find<BusinessTypeService>().getAllBusinessTypes();
//     businessTypes.value = data;
//     print("Business types ${businessTypes.length}");
//     return data;
//   }
//
//   /// Check if a specific business type is available in user's city
//   bool isBusinessAvailable(String businessId, String? userCity) {
//     if (userCity == null || userCity.isEmpty) return false;
//
//     final business = businessTypes.firstWhereOrNull(
//             (b) => b.id == businessId
//     );
//
//     return business?.cities.contains(userCity) ?? false;
//   }
//
//   /// Get business type by index safely
//   BusinessTypeModel? getBusinessByIndex(int index) {
//     if (index >= 0 && index < businessTypes.length) {
//       return businessTypes[index];
//     }
//     return null;
//   }
// }