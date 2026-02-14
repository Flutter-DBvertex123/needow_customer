import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../product/controller/productContorller.dart';
import '../../../../product/models/model/ProductModel.dart';

class RecomendedProductController extends GetxController {
  RxList<ProductModel> recommendedProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  int page = 1;
  final int limit = 5;

  Future<void> loadRecommendedProducts(String businessId) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    final result =  await Get.find<ProductController>().getProductByBusinessType(
      businessId,
      limit,
      page,
    );

    final filtered = result.where((e) => e.isRecommended == true).toList();

    if (filtered.length < limit) {
      hasMore.value = false;
    }

    recommendedProducts.addAll(filtered);
    page++;

    isLoading.value = false;
  }

  void reset() {
    page = 1;
    hasMore.value = true;
    recommendedProducts.clear();
  }
}
