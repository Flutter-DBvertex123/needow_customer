// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/model/services/restaurentService.dart';
// import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
//
// import '../model/restaurentItemModel.dart';
//
// class ResturentController extends GetxController {
//
//   RxList<Restaurant> restaurantList = <Restaurant>[].obs;
//   RxList<String> filters = <String>[].obs;
//   Future<RestaurantResponse> getRestaurents(String status) async {
//     final response =  await Get.find<RestaurentService>().getRestaurants(status: status);
//     restaurantList.assignAll(response.restaurants);
//     filters.value  = uniqueRestaurantTypes;
//     return response;
//   }
//   List<String> get uniqueRestaurantTypes {
//     return restaurantList
//         .map((e) => e.restaurantType)
//         .where((type) => type.isNotEmpty)
//         .toSet()   // removes duplicates
//         .toList();
//   }
// //   Future<List<ProductModel>> getRestaurantItems(String restaurentId) async {
// //     print("getting food produst");
// //     await Future.delayed(Duration(seconds: 2)); // Simulate network delay
// //     final  data =  await  Get.find<RestaurentService>().getRestaurantItems(restaurentId);
// //     print("restaurent item length : ${data['data']}");
// //     if(data["success"]){
// //       return data['data'];
// //     }else{
// //       return [];
// //     }
// //   }
// // }
//   Future<List<ProductModel>> getRestaurantItems(String restaurentId) async {
//     print("getting food product");
//     await Future.delayed(Duration(seconds: 2)); // Simulate network delay
//
//     try {
//       final data = await Get.find<RestaurentService>().getRestaurantItems(
//           restaurentId);
//       print("restaurent item length : ${data['data']}");
//
//       if (data["success"] && data['data'] != null) {
//         // Explicitly cast to List<ProductModel>
//         final productList = (data['data'] as List).cast<ProductModel>();
//         print("Successfully loaded ${productList.length} products");
//         return productList;
//       } else {
//         print("Failed to load products or empty data");
//         return [];
//       }
//     } catch (e) {
//       print("Error in getRestaurantItems: $e");
//       return [];
//     }
//   }
// }
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/model/services/restaurentService.dart';
// import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
//
// import '../model/restaurentItemModel.dart';
//
// class ResturentController extends GetxController {
//   RxList<Restaurant> restaurantList = <Restaurant>[].obs;
//   RxList<String> filters = <String>[].obs;
//
//   Future<RestaurantResponse> getRestaurents(String status) async {
//     try {
//       final response =
//       await Get.find<RestaurentService>().getRestaurants(status: status);
//       restaurantList.assignAll(response.restaurants);
//
//       // Extract unique restaurant types and update filters
//       filters.value = uniqueRestaurantTypes;
//
//       print('Restaurant types found: ${filters.value}');
//
//       return response;
//     } catch (e) {
//       print('Error fetching restaurants: $e');
//       rethrow;
//     }
//   }
//
//   /// Get unique restaurant types from the restaurant list
//   List<String> get uniqueRestaurantTypes {
//     final types = restaurantList
//         .map((restaurant) => restaurant.restaurantType)
//         .where((type) => type.isNotEmpty)
//         .toSet() // Removes duplicates
//         .toList();
//
//     // Sort alphabetically for better UX
//     types.sort();
//
//     return types;
//   }
//
//   /// Get restaurants filtered by type
//   List<Restaurant> getRestaurantsByType(String restaurantType) {
//     if (restaurantType.isEmpty) {
//       return restaurantList;
//     }
//     return restaurantList
//         .where((restaurant) => restaurant.restaurantType == restaurantType)
//         .toList();
//   }
//
//   Future<List<ProductModel>> getRestaurantItems(String restaurentId) async {
//     print("getting food product");
//     await Future.delayed(Duration(seconds: 2)); // Simulate network delay
//
//     try {
//       final data = await Get.find<RestaurentService>().getRestaurantItems(
//           restaurentId);
//       print("restaurent item length : ${data['data']}");
//
//       if (data["success"] && data['data'] != null) {
//         // Explicitly cast to List<ProductModel>
//         final productList = (data['data'] as List).cast<ProductModel>();
//         print("Successfully loaded ${productList.length} products");
//         return productList;
//       } else {
//         print("Failed to load products or empty data");
//         return [];
//       }
//     } catch (e) {
//       print("Error in getRestaurantItems: $e");
//       return [];
//     }
//   }
// }
//
// List<RestaurantItemModel> dummyRestaurantItems = [
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
//     name: "Margherita Pizza",
//     description: "Classic cheese margherita with fresh basil.",
//     rating: "4.6",
//     time: "25-30 mins",
//     fee: "₹20",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1550547660-d9450f859349",
//     name: "Veg Burger",
//     description: "Grilled veg patty with special sauce.",
//     rating: "4.3",
//     time: "15-20 mins",
//     fee: "₹15",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1543353071-873f17a7a088",
//     name: "Chicken Biryani",
//     description: "Aromatic Hyderabadi biryani with raita.",
//     rating: "4.7",
//     time: "30-35 mins",
//     fee: "₹30",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
//     name: "Pasta Alfredo",
//     description: "Creamy alfredo pasta with herbs.",
//     rating: "4.5",
//     time: "20-25 mins",
//     fee: "₹18",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1546964124-0cce460f38ef",
//     name: "Tandoori Momos",
//     description: "Spicy tandoori momos served with chutney.",
//     rating: "4.4",
//     time: "15-18 mins",
//     fee: "₹12",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1473093226795-af9932fe5856",
//     name: "Paneer Butter Masala",
//     description: "Cream-rich paneer curry with spices.",
//     rating: "4.8",
//     time: "25-30 mins",
//     fee: "₹22",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1617191519105-9e63e7c19fe2",
//     name: "Cold Coffee",
//     description: "Iced coffee with whipped cream.",
//     rating: "4.2",
//     time: "10-12 mins",
//     fee: "₹10",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1576402187876-30616e1b6203",
//     name: "Chocolate Cake",
//     description: "Moist dark chocolate cake slice.",
//     rating: "4.9",
//     time: "8-10 mins",
//     fee: "₹15",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1532634943-47ef0b0b5d42",
//     name: "French Fries",
//     description: "Crispy golden fries with masala.",
//     rating: "4.1",
//     time: "10-15 mins",
//     fee: "₹8",
//   ),
//   RestaurantItemModel(
//     image: "https://images.unsplash.com/photo-1551183053-bf91a1d81141",
//     name: "South Indian Thali",
//     description: "Idli, dosa, vada, sambhar & chutneys.",
//     rating: "4.6",
//     time: "20-25 mins",
//     fee: "₹25",
//   ),
// ];

import 'package:get/get.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/services/restaurentService.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';

import '../model/restaurentItemModel.dart';

class ResturentController extends GetxController {
  RxList<Restaurant> restaurantList = <Restaurant>[].obs;
  RxList<Restaurant> filteredRestaurantList = <Restaurant>[].obs;
  RxList<String> filters = <String>[].obs;
  RxList<String> cuisineTypes = <String>[].obs;
  Rx<String?> selectedFilter = Rx<String?>(null);

  Future<RestaurantResponse> getRestaurents(String status) async {
    try {
      final response =
      await Get.find<RestaurentService>().getRestaurants(status: status);
      restaurantList.assignAll(response.restaurants);

      // Initially, filtered list = all restaurants
      filteredRestaurantList.assignAll(response.restaurants);

      // Extract unique restaurant types and update filters
      filters.value = uniqueRestaurantTypes;

      print('🍽️ Restaurant types found: ${filters.value}');
      print('📊 Total restaurants loaded: ${restaurantList.length}');

      return response;
    } catch (e) {
      print('❌ Error fetching restaurants: $e');
      rethrow;
    }
  }

  /// Apply filter to restaurants
  void applyFilter(String? filterType) {
    selectedFilter.value = filterType;
    print('🔍 Applying filter: $filterType');

    if (filterType == null || filterType.isEmpty) {
      // Show all restaurants
      filteredRestaurantList.assignAll(restaurantList);
      print('✅ Filter cleared - showing all ${filteredRestaurantList.length} restaurants');
    } else {
      // Filter restaurants by type
      final filtered = restaurantList
          .where((restaurant) {
        final matches = restaurant.restaurantType == filterType;
        return matches;
      })
          .toList();
      filteredRestaurantList.assignAll(filtered);
      print('✅ Filter applied - showing ${filteredRestaurantList.length} restaurants for type: $filterType');
    }
  }

  /// Get unique restaurant types from the restaurant list
  List<String> get uniqueRestaurantTypes {
    final types = restaurantList
        .map((restaurant) => restaurant.restaurantType)
        .where((type) => type.isNotEmpty)
        .toSet() // Removes duplicates
        .toList();

    // Sort alphabetically for better UX
    types.sort();

    return types;
  }

  /// Get restaurants filtered by type
  List<Restaurant> getRestaurantsByType(String restaurantType) {
    if (restaurantType.isEmpty) {
      return restaurantList.toList();
    }
    return restaurantList
        .where((restaurant) => restaurant.restaurantType == restaurantType)
        .toList();
  }

  Future<List<ProductModel>> getRestaurantItems(String restaurentId) async {
    print("getting food product");
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    try {
      final data = await Get.find<RestaurentService>().getRestaurantItems(
          restaurentId);
      print("restaurent item length : ${data['data']}");

      if (data["success"] && data['data'] != null) {
        // Explicitly cast to List<ProductModel>
        final productList = (data['data'] as List).cast<ProductModel>();
        print("Successfully loaded ${productList.length} products");
        return productList;
      } else {
        print("Failed to load products or empty data");
        return [];
      }
    } catch (e) {
      print("Error in getRestaurantItems: $e");
      return [];
    }
  }


  Future<void> fetchCuisineTypes() async {
    try {
      final result = await Get.find<RestaurentService>().getCuisineTypes();
      cuisineTypes.assignAll(result);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unable to fetch cuisine types",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<Restaurant> getRestaurentById(String id) async {
    try {
      final response = await Get.find<RestaurentService>().getRestaurentById(id);
      print("restauren in controller ${response.name}");
      return response;
    } catch (e) {
      print('❌ Error fetching restaurant by ID: $e');
      rethrow;
    }
  }
}