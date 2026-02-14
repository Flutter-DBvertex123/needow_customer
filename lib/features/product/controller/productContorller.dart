/*

import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/features/product/models/services/product_service.dart';

/// ===============================
/// Local cart item model
/// ===============================
class LocalCartItem {
  int quantity;
  String? prescriptionUrl;

  LocalCartItem({
    this.quantity = 1,
    this.prescriptionUrl,
  });
}

/// ===============================
/// Product Controller
/// ===============================
class ProductController extends GetxController {
  /// Single product quantity (legacy – kept intentionally)
  RxInt productQuantity = 1.obs;

  /// Selected tab / filter index
  RxInt selectedParams = 0.obs;

  /// All products combined (used for price lookup)
  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  /// Main cart quantity store
  /// Map<productId, LocalCartItem>
  RxMap<String, LocalCartItem> quantities =
      <String, LocalCartItem>{}.obs;

  /// Product lists
  RxList<ProductModel> businessTypeProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  RxList<ProductModel> subCategoryProducts = <ProductModel>[].obs;

  /// ===============================
  /// INIT
  /// ===============================
  @override
  void onInit() {
    super.onInit();
    _loadQuantitiesFromCart();
  }

  /// ===============================
  /// CLEANUP
  /// ===============================
  @override
  void onClose() {
    productQuantity.value = 1;
    quantities.clear();
    super.onClose();
  }

  /// ===============================
  /// TAB / FILTER SELECTION
  /// ===============================
  /// (kept because your UI uses it)
  void updateIteamByParams(int index) {
    selectedParams.value = index;
  }

  /// ===============================
  /// CART → PRODUCT SYNC (PRIVATE)
  /// ===============================
  void _loadQuantitiesFromCart() {
    try {
      final cartController = Get.find<CartController>();

      for (var item in cartController.cartList) {
        if (item.product?.id != null) {
          quantities[item.product!.id] = LocalCartItem(
            quantity: item.quantity.toInt() ?? 1,
            prescriptionUrl: null, // CartItem doesn't contain this
          );
        }
      }

      quantities.refresh();
    } catch (e) {
      print("Error loading quantities from cart: $e");
    }
  }

  /// ===============================
  /// CART → PRODUCT SYNC (PUBLIC)
  /// ===============================
  /// Call this after cart refresh
  void syncQuantitiesFromCart() {
    quantities.clear();
    _loadQuantitiesFromCart();
  }

  /// ===============================
  /// GET QUANTITY
  /// ===============================
  int getQuantity(String productId) {
    return quantities[productId]?.quantity ?? 0;
  }

  /// ===============================
  /// INCREASE QUANTITY
  /// ===============================
  void increase(String productId, String? prescription) {
    if (!quantities.containsKey(productId)) {
      quantities[productId] = LocalCartItem(
        quantity: 1,
        prescriptionUrl: prescription,
      );
    } else {
      quantities[productId]!.quantity += 1;
      quantities[productId]!.prescriptionUrl = prescription;
    }

    quantities.refresh();
  }

  /// ===============================
  /// DECREASE QUANTITY
  /// ===============================
  void decrease(String productId) {
    if (!quantities.containsKey(productId)) return;

    if (quantities[productId]!.quantity > 1) {
      quantities[productId]!.quantity -= 1;
    } else {
      quantities.remove(productId);
    }

    quantities.refresh();
  }

  /// ===============================
  /// TOTAL CART PRICE
  /// ===============================
  double get totalPrice {
    double total = 0;

    quantities.forEach((productId, item) {
      final product = allProducts.firstWhereOrNull(
            (p) => p.id == productId,
      );

      if (product != null) {
        final price =
            product.discountedPrice ?? product.price ?? 0;
        total += price * item.quantity;
      }
    });

    return total;
  }

  /// ===============================
  /// SINGLE PRODUCT PRICE
  /// ===============================
  double getSingleProductPrice(ProductModel product, int qty) {
    final price = product.discountedPrice ?? product.price ?? 0;
    return price * qty;
  }

  /// ===============================
  /// CART DATA FOR BACKEND
  /// ===============================
  Map<String, int> getCartItems() {
    return quantities.map(
          (key, value) => MapEntry(key, value.quantity),
    );
  }

  /// ===============================
  /// LEGACY METHODS (KEPT)
  /// ===============================
  void increaseProductQuantity() => productQuantity.value++;

  void decreaseProductQuantity() {
    if (productQuantity.value > 1) {
      productQuantity.value--;
    }
  }

  /// ===============================
  /// API CALLS
  /// ===============================
  Future<List<ProductModel>> getProductByBusinessType(
      String type, int limit, int page) async {
    final data = await Get.find<ProductService>()
        .getProductByBusinessType(type, limit, page);

    businessTypeProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProductByCategory(String type) async {
    final data =
    await Get.find<ProductService>().getProductByCategory(type);

    categoryProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProductBySubCategory(String type) async {
    final data = await Get.find<ProductService>()
        .getProductBySubCategory(type);

    subCategoryProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProducts(
      int? limit, String? category) async {
    final data =
    await Get.find<ProductService>().getPorducts(limit, category);

    _updateAllProducts();
    return data;
  }

  /// ===============================
  /// MERGE PRODUCTS
  /// ===============================
  void _updateAllProducts() {
    final Map<String, ProductModel> map = {};

    for (var p in businessTypeProducts) map[p.id] = p;
    for (var p in categoryProducts) map[p.id] = p;
    for (var p in subCategoryProducts) map[p.id] = p;

    allProducts.value = map.values.toList();
  }
}
*/
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/features/product/models/services/product_service.dart';

import '../../browseProducts/models/services/local_add_to_cart_model.dart';

class ProductController extends GetxController {
  RxInt productQuantity = 1.obs;
  RxInt selectedParams = 0.obs;

  // Product lists
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> businessTypeProducts = <ProductModel>[].obs;
  RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  RxList<ProductModel> subCategoryProducts = <ProductModel>[].obs;
  RxMap<String,ProductQtyData> quantityList = <String,ProductQtyData>{}.obs;
  RxList<Map<String,dynamic>> addOnProducts = <Map<String,dynamic>>[].obs;
  // RxDouble addOnTotalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    syncQuantitiesFromCart();
  }

  @override
  void onClose() {
    productQuantity.value = 1;
    super.onClose();
  }

  void increaseAddOnProduct(String productId) {
    final current = addOnProducts.firstWhereOrNull((p) => p['id'] == productId);

    if (current != null) {
      current['quantity'] = (current['quantity'] ?? 0) + 1;
      addOnProducts.refresh();
    }
  }
  void decreaseAddOnProduct(String productId) {
    final current = addOnProducts.firstWhereOrNull((p) => p['id'] == productId);

    if (current != null && (current['quantity'] ?? 0) > 0) {
      current['quantity'] = (current['quantity'] ?? 0) - 1;
      addOnProducts.refresh();
    }
  }
  /// ===============================
  /// SYNC FROM CART
  /// ===============================
  void syncQuantitiesFromCart() {
    // This now just ensures cart controller is loaded
    // All quantity management happens in CartController
  }

  /// ===============================
  /// GET QUANTITY (DELEGATES TO CART)
  /// ===============================
  int getQuantity(String productId) {
    final cartController = Get.find<CartController>();
    return cartController.getLocalQuantity(productId);
  }

  /// ===============================
  /// INCREASE (DELEGATES TO CART)
  /// ===============================
  void increase(String productId, String? prescription) {
    final cartController = Get.find<CartController>();
    cartController.increaseItem(
      productId,
      requiresPrescription: prescription != null,
      prescriptionUrl: prescription ?? "",
    );
  }

  /// ===============================
  /// DECREASE (DELEGATES TO CART)
  /// ===============================
  void decrease(String productId) {
    final cartController = Get.find<CartController>();
    cartController.decreaseItem(productId);
  }

  /// ===============================
  /// TOTAL PRICE
  /// ===============================
  double get totalPrice {
    double total = 0;
    final cartController = Get.find<CartController>();

    cartController.pendingItems.forEach((productId, item) {
      final product = allProducts.firstWhereOrNull((p) => p.id == productId);

      if (product != null) {
        final price = product.discountedPrice ?? product.price ?? 0;
        total += price * item.quantity;
      }
    });

    return total;
  }

  /// ===============================
  /// SINGLE PRODUCT PRICE
  /// ===============================
  double getSingleProductPrice(ProductModel product, int qty) {
    final price = product.discountedPrice ?? product.price ?? 0;
    return price * qty;
  }

  /// ===============================
  /// LEGACY METHODS
  /// ===============================
  void increaseProductQuantity() => productQuantity.value++;

  void decreaseProductQuantity() {
    if (productQuantity.value > 1) {
      productQuantity.value--;
    }
  }

  void updateIteamByParams(int index) {
    selectedParams.value = index;
  }

  /// ===============================
  /// API CALLS
  /// ===============================
  Future<List<ProductModel>> getProductByBusinessType(
      String type,
      int limit,
      int page,
      ) async {
    final data = await Get.find<ProductService>()
        .getProductByBusinessType(type, limit, page);

    businessTypeProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProductByCategory(String type) async {
    final data = await Get.find<ProductService>().getProductByCategory(type);
    categoryProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProductBySubCategory(String type) async {
    final data = await Get.find<ProductService>().getProductBySubCategory(type);
    subCategoryProducts.value = data;
    _updateAllProducts();
    return data;
  }

  Future<List<ProductModel>> getProducts(int? limit, String? category) async {
    final data = await Get.find<ProductService>().getPorducts(limit, category);
    _updateAllProducts();
    return data;
  }

  /// ===============================
  /// MERGE PRODUCTS
  /// ===============================
  void _updateAllProducts() {
    final Map<String, ProductModel> map = {};

    for (var p in businessTypeProducts) map[p.id] = p;
    for (var p in categoryProducts) map[p.id] = p;
    for (var p in subCategoryProducts) map[p.id] = p;

    allProducts.value = map.values.toList();
  }

  // void increaseQty(String productId) {
  //   quantityList[productId] =
  //       (quantityList[productId] ?? 0) + 1;
  // }

  void increaseQtyBrowseProduct(String productId) {
    final current = quantityList[productId];

    if (current != null) {
      quantityList[productId] = current.copyWith(
        quantity: current.quantity + 1,
      );
    } else {
      quantityList[productId] = ProductQtyData(quantity: 1);
    }
  }



  // void decreaseQty(String productId) {
  //   final current = quantityList[productId] ?? 0;
  //   if (current > 0) {
  //     quantityList[productId]?.quantity. = current - 1;
  //   }
  // }
  void decreaseQtyForBrowseProduct(String productId) {
    final current = quantityList[productId];

    if (current != null && current.quantity > 0) {
      quantityList[productId] =
          ProductQtyData(quantity: current.quantity - 1);
    }
  }


}