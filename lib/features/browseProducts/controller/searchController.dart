import 'dart:async';
import 'package:get/get.dart';
import 'package:newdow_customer/features/browseProducts/models/services/searchService.dart';


import '../../product/models/model/ProductModel.dart'; // your custom API service file

// class ProductSearchController extends GetxController {
//
//
//   var isLoading = false.obs;
//   RxList<ProductModel> products = <ProductModel>[].obs;
//   RxString searchQuery = ''.obs;
//   var errorMessage = ''.obs;
//
//   Timer? _debounce;
//
//   /// Called whenever user types something in the search box
//   Future<void> onSearchChanged(String query) async {
//     searchQuery.value = query.trim();
//
//     // Cancel any ongoing debounce timer
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//
//     // Wait 400ms before firing API request
//     _debounce =  await Timer(const Duration(milliseconds: 400), ()  async {
//       if (query.isNotEmpty) {
//        final data = await Get.find<SearchService>().searchProduct(query);
//        print('dara $data');
//        products.assignAll(data);
//       } else {
//         products.clear();
//       }
//     });
//   }
//   void clearSearch() {
//     searchQuery.value = "";
//     products.clear();
//     _debounce?.cancel();
//   }
//
//
//
//   @override
//   void onClose() {
//     _debounce?.cancel();
//     super.onClose();
//   }
// }
class ProductSearchController extends GetxController {
  var isFocused = false.obs; // <--- NEW

  var isLoading = false.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxString searchQuery = ''.obs;
  var errorMessage = ''.obs;

  Timer? _debounce;

  Future<void> onSearchChanged(String query) async {
    searchQuery.value = query.trim();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isNotEmpty) {
        final data = await Get.find<SearchService>().searchProduct(query);
        products.assignAll(data);
      } else {
        products.clear();
      }
    });
  }

  void clearSearch() {
    searchQuery.value = "";
    products.clear();
    _debounce?.cancel();
  }
}
