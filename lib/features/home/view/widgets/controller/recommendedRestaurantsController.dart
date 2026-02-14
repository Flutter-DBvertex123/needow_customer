// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
// import '../model/recommendedRestaurantModel.dart';
// import '../model/recommended_restaurant_service.dart';
//
// class RecommendedRestaurantController extends GetxController {
//   final isLoading = true.obs;
//   final restaurants = <Restaurant>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadRestaurants();
//   }
//
//   Future<void> loadRestaurants() async {
//     isLoading(true);
//
//     final response =
//     await RecommendedRestaurantService.fetchRestaurants();
//
//     if (response != null && response['success']==true) {
//       print("cbvcvbcvbcvn${response}");
//       restaurants.assignAll(response['data'].map((e) => Restaurant.fromJson(e)));
//       // restaurants.assignAll(
//       //   response.data!
//       //       .where((e) => e.isRecommended == true && e.isActive == true)
//       //       .toList(),
//       // );
//     }
//
//     isLoading(false);
//   }
// }


import 'package:get/get.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
import '../model/recommended_restaurant_service.dart';

class RecommendedRestaurantController extends GetxController {
  final isLoading = false.obs;
  final restaurants = <Restaurant>[].obs;

  /// 🔥 Future method (FutureBuilder ke liye)
  Future<List<Restaurant>> loadRestaurants() async {
    isLoading(true);

    final response =
    await RecommendedRestaurantService.fetchRestaurants();

    if (response != null ) {
      print("cbvcvbcvbcvn${response["data"]}");
      final List<Restaurant> list = (response['data'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();

      restaurants.assignAll(list);
      isLoading(false);
      print("cbcbfchbfhfh${restaurants.length}");
      return restaurants;
    }

    isLoading(false);
    return [];
  }
}
