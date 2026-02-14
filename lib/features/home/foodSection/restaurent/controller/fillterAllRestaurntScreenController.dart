import 'package:get/get.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/services/restaurentService.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';

class AllRestaurantsFilterController extends GetxController {
  RxList<Restaurant> allRestaurants = <Restaurant>[].obs;
  RxList<Restaurant> filteredRestaurants = <Restaurant>[].obs;
  RxList<String> filters = <String>[].obs;
  Rx<String?> selectedFilter = Rx<String?>(null);
  RxBool isLoading = false.obs;

  /// Load restaurants with optional category filter
  Future<void> loadRestaurants() async {
    try {
      isLoading.value = true;
      print('🍽️ Loading restaurants...');


      // Pass categoryId to the service
      final response = await Get.find<RestaurentService>().getRestaurants(
        status: "",
      );

      allRestaurants.assignAll(response.restaurants);
      filteredRestaurants.assignAll(response.restaurants);

      // Extract unique restaurant types from loaded restaurants
      filters.value = _extractUniqueTypes();


      print('✅ Restaurants loaded: ${allRestaurants.length}');
      print('📊 Filters: ${filters.value}');
    } catch (e) {
      print('❌ Error loading restaurants: $e');
    } finally {
      isLoading.value = false;
    }
  }Future<void> loadRestaurantsByCuisine(String cuisine) async {
    try {
      isLoading.value = true;
      print('🍽️ Loading restaurants...');
      if (cuisine.isNotEmpty) {
        print('📂 cuisine ID: $cuisine');
      }

      // Pass categoryId to the service
      final response = await Get.find<RestaurentService>().getRestaurantsByCuisine(cuisine);
      print('🍽️ Restaurants loaded from service: ${response.length}');
      allRestaurants.assignAll(response);
      filteredRestaurants.assignAll(response);

      // Extract unique restaurant types from loaded restaurants
      filters.value = _extractUniqueTypes();

      print('✅ Restaurants loaded: ${allRestaurants.length}');
      print('📊 Filters: ${filters.value}');
    } catch (e) {
      print('❌ Error loading restaurants: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Extract unique restaurant types
  List<String> _extractUniqueTypes() {
    final types = allRestaurants
        .map((restaurant) => restaurant.restaurantType)
        .where((type) => type.isNotEmpty)
        .toSet()
        .toList();

    types.sort();
    return types;
  }

  /// Apply filter by restaurant type
  void applyFilter(String? filterType) {
    selectedFilter.value = filterType;
    print('🔍 Applying filter: $filterType');

    if (filterType == null || filterType.isEmpty) {
      filteredRestaurants.assignAll(allRestaurants);
      print('✅ Filter cleared - showing all ${filteredRestaurants.length} restaurants');
    } else {
      final filtered = allRestaurants
          .where((restaurant) => restaurant.restaurantType == filterType)
          .toList();
      filteredRestaurants.assignAll(filtered);
      print('✅ Filter applied - showing ${filteredRestaurants.length} restaurants');
    }
  }

  /// Clear all filters and reset
  void reset() {
    selectedFilter.value = null;
    filteredRestaurants.assignAll(allRestaurants);
  }

  @override
  void onClose() {
    allRestaurants.clear();
    filteredRestaurants.clear();
    filters.clear();
    selectedFilter.value = null;
    super.onClose();
  }
}