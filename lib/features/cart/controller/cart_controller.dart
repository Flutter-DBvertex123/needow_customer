/*

import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/model/services/cart_service.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/prefs.dart';

import '../../address/model/addressModel.dart';
import '../model/models/addToCartModel.dart';
import '../model/models/cartItemsModel.dart';

class CartController extends GetxController {
  RxList<CartItem> cartList = <CartItem>[].obs;
  Rx<UsersCartModel> usersCart = UsersCartModel.empty().obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CartItems> localCartItems = <CartItems>[].obs;
  RxBool isCalculating = false.obs;

  // --- GRAND TOTAL ---
  // double get grandTotal =>
  //     cartList.fold(0, (sum, cart) => sum + cart.total);

  Map<String, int> uiQty = {};

  void updateUIQty(String productId, int qty) {
    uiQty[productId] = qty;
    update([productId]); // 🔥 rebuild only widget with this ID
  }

  // =========================================================
  // 🛒 ADD TO CART (AUTO HANDLE: NEW CART OR UPDATE CART)
  // =========================================================

  int getQuantity(String productId) {
    final index = localCartItems.indexWhere((item) => item.productId == productId);
    return index == -1 ? 0 : localCartItems[index].quantity;
  }
  ///Add or update a perticular items

  Future<bool> addOrUpdateProductInCart(String productId,int quantity) async {
   */
/* if(productId == (cartList.map((e) => e.id))){*//*

      print("product allready available");
     final res = await Get.find<CartService>().updateCart(cartId: usersCart.value.id,
          body: {
            "userId": await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? ''),
            "items": [
              {
                "productId": productId,
                "quantity": quantity
              }
            ],
          }
      );
     res ? await fetchCarts() : null;

    return res;
  }
  ///Add or update local cartList
  // void addOrUpdateLocalCartItem(String productId, int quantity) {
  //   print("product Quantity $quantity");
  //   // Check if product already exists
  //   final index = localCartItems.indexWhere(
  //           (item) => item.productId == productId);
  //
  //   if (index >= 0) {
  //     // Update quantity
  //     if (quantity > 0) {
  //       print("Qt $quantity");
  //       localCartItems[index] = localCartItems[index].copyWith(
  //         quantity: quantity,
  //       );
  //     } else {
  //       // Remove if quantity = 0
  //       localCartItems.removeAt(index);
  //     }
  //   } else {
  //     // Add new item
  //     localCartItems.add(
  //       CartItems(
  //         productId: productId,
  //         quantity: quantity,
  //       ),
  //     );
  //   }
  //
  //   print("LOCAL CART ITEMS: ${localCartItems.map((e) => e.toJson()).toList()}");
  // }

  //Sync local cartList with backend
  Future<bool> syncCartWithBackend() async {

    String userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id) ?? "";
    print("adding product in cart");
    bool success = false;

    // CASE 1: Cart exists → UPDATE
    if (cartList.isNotEmpty) {
      print("cart is not empty");
      String cartId = cartList.first.id;

      success = await updateCart(
        cartId: cartId,
        userId: userId,
        items: localCartItems,
      );
    }

    // CASE 2: No cart → CREATE
    else {
      final body = {
        "userId": userId,
        "items": localCartItems.map((e) => e.toJson()).toList(),
        "placeholder": "string",
      };

      success = await Get.find<CartService>().addToCart(body);
    }

    if (success) {
      await fetchCarts(); // refresh UI
    }
    return success;
  }

  // =========================================================
  // 🔄 FETCH CARTS
  // =========================================================
  Future<void> fetchCarts() async {
    try {
      isCalculating(true);
      isLoading.value = true;
      errorMessage.value = '';

      final data = await Get.find<CartService>().getUsersCart();
      if (data != null) {
        await Get.find<CartController>().calculateCheckout(Get.find<AddressController>().selectedDeliveryAddress.value ?? AddressModel.empty());
        usersCart(data);
        cartList.assignAll(data.items);
        print("Lenght of item list${cartList.length}");
        isCalculating(false);
      } else {
        cartList.clear();
        isCalculating(false);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      cartList.clear();
      isCalculating(false);
    } finally {
      isLoading.value = false;
      isCalculating(false);
    }
  }

  // =========================================================
  // 🗑 DELETE CART ITEM
  // =========================================================
  Future<Map<String, dynamic>> removeCartItem(String cartId) async {
    final response = await Get.find<CartService>().removeCartItem(cartId);

    cartList.removeWhere((cart) => cart.id == cartId);

    return response;
  }

  // =========================================================
  // 🔧 UPDATE CART (API CALL)
  // =========================================================
  Future<bool> updateCart({
    required String cartId,
    required String userId,
    required List<CartItems> items,
    String? placeholder,
  }) async {
    final address =  Get.find<AddressController>().selectedDeliveryAddress;
    final cleanedItems = items
        .where((item) => item.quantity > 0)
        .map((item) => {
    "productId": item.productId,
    "quantity": item.quantity,
    }).toList();

    final body = {
      "userId": userId,
      "items": cleanedItems,
      if (placeholder != null) "placeholder": placeholder,
    };

    final isUpdated =  await Get.find<CartService>().updateCart(
      cartId: cartId,
      body: body, // SEND FULL BODY
    );
    if(isUpdated){
      final cartCheckoutRes = await Get.find<CartService>().calculateCheckout(userId: await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? ""), deliveryAddress: address.value ?? AddressModel.empty());
      return isUpdated;
    }
    return isUpdated;
  }

  Future<void> calculateCheckout(AddressModel deliveryAddress) async {
    final address = Get.find<AddressController>().selectedDeliveryAddress.value;
    final checkoutCon = Get.find<CheckoutController>();
    final cartCheckoutRes = await Get.find<CartService>().calculateCheckout(userId: await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? ""), deliveryAddress: address ?? AddressModel.empty());
    checkoutCon.groceryCart(cartCheckoutRes.groups?.grocery ?? CartGroup.empty());
    checkoutCon.foodCart(cartCheckoutRes.groups?.food ?? CartGroup.empty());
    checkoutCon.medicineCart(cartCheckoutRes.groups?.medicine ?? CartGroup.empty());
  }
}
*/
/*
import 'dart:io';

import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/model/services/cart_service.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/utils/uploadResponse.dart';

import '../../address/model/addressModel.dart';
import '../model/models/addToCartModel.dart';
import '../model/models/cartItemsModel.dart';

class CartController extends GetxController {
  // ⚠️ CRITICAL: Use regular List, not RxList to prevent automatic rebuilds
  List<CartItem> cartList = [];
  Rx<UsersCartModel> usersCart = UsersCartModel.empty().obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CartItems> localCartItems = <CartItems>[].obs;
  RxBool isCalculating = false.obs;

  // Store UI quantities separately to avoid full list rebuilds
  Map<String, int> uiQty = {};

  // Track removed items for optimistic UI updates
  Set<String> removedItemIds = {};

  /// Update only the specific product's quantity widget
  void updateUIQty(String productId, int qty) {
    uiQty[productId] = qty;
    update([productId]); // Only rebuild widgets with this specific ID
  }

  /// Get current quantity for a product
  int getQuantity(String productId) {
    final index = localCartItems.indexWhere((item) => item.productId == productId);
    return index == -1 ? 0 : localCartItems[index].quantity;
  }

  /// Get filtered cart items by category (pure function, no observables)
  List<CartItem> getCartItemsByCategory(String category) {
    return cartList.where((item) {
      if (removedItemIds.contains(item.id)) return false;
      return item.product?.productType?.toLowerCase() == category.toLowerCase();
    }).toList();
  }

  Future<Map<String,dynamic>> uploadPrescriptionBeforeAddingToCart(File prescriptionImage) async {
    final response = await Get.find<CartService>().uploadPrescription(prescriptionImage);
    return response;
  }

  /// Add or update a particular item in cart
  Future<bool> addOrUpdateProductInCart(String productId, int quantity,String? prescriptionUrl) async {
    try {
      final res = await Get.find<CartService>().updateCart(
          cartId: usersCart.value.id,
          body: {
            "userId": await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? ''),
            "items": [
              {
                "productId": productId,
                "quantity": quantity,
                "prescriptionUrl": prescriptionUrl ?? ""
              }
            ],
          }
      );

      if (res) {
        // Silently update the cart list without triggering rebuilds
        await _silentFetchCarts();
      }

      return res;
    } catch (e) {
      print("Error updating cart: $e");
      return false;
    }
  }

  /// Fetch carts WITHOUT triggering rebuilds (for background updates)
  Future<void> _silentFetchCarts() async {
    try {
      final data = await Get.find<CartService>().getUsersCart();
      if (data != null) {
        final selectedAddress = Get.find<AddressController>().selectedDeliveryAddress.value;
        if (selectedAddress != null) {
          await calculateCheckout(selectedAddress);
        }
        usersCart.value = data;
        cartList = data.items; // Direct assignment, no .assignAll()

        // Update UI quantities silently
        for (var item in data.items) {
          if (item.product?.id != null) {
            uiQty[item.product!.id] = item.quantity.toInt();
          }
        }
      }
    } catch (e) {
      print("Silent fetch error: $e");
    }
  }

  /// Fetch carts from backend (ONLY called on initial load)
  Future<void> fetchCarts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      removedItemIds.clear();

      final data = await Get.find<CartService>().getUsersCart();
      if (data != null) {
        usersCart.value = data;
        cartList = data.items;

        // Initialize UI quantities for all items
        for (var item in data.items) {
          if (item.product?.id != null) {
            uiQty[item.product!.id] = item.quantity.toInt();
          }
        }

        // Calculate checkout if address is selected
        final selectedAddress = Get.find<AddressController>().selectedDeliveryAddress.value;
        if (selectedAddress != null) {
          await calculateCheckout(selectedAddress);
        }

        errorMessage.value = '';
      } else {
        cartList = [];
        errorMessage.value = 'No items';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      cartList = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Sync local cart with backend
  Future<bool> syncCartWithBackend() async {
    String userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id) ?? "";
    bool success = false;

    if (cartList.isNotEmpty) {
      print("cartlist exist updating cart ${localCartItems.length}");
      String cartId = cartList.first.id;
      success = await updateCart(
        cartId: cartId,
        userId: userId,
        items: localCartItems,
      );
    } else {
      final body = {
        "userId": userId,
        "items": localCartItems.map((e) => e.toJson()).toList(),
        "placeholder": "string",
      };

      success = await Get.find<CartService>().addToCart(body);
    }

    if (success) {
      await _silentFetchCarts();
    }
    return success;
  }

  /// Remove cart item with optimistic UI update
  // Future<void> removeItemFromCart(String itemId, String productId, String category) async {
  //   // 1. Mark as removed immediately (optimistic UI)
  //   removedItemIds.add(itemId);
  //
  //   // 2. Update only the specific category list
  //   update(['cart_list_$category']);
  //
  //   // 3. Sync with backend
  //   await addOrUpdateProductInCart(productId, 0);
  // }
  Future<void> removeItemFromCart(
      String itemId,
      String productId,
      String category,
      ) async {
    removedItemIds.add(itemId);
    update(['cart_list_$category']);
  }


  /// Undo item removal
  // void undoRemoveItem(String itemId, String category) {
  //   removedItemIds.remove(itemId);
  //   update(['cart_list_$category']);
  // }
  void undoRemoveItem(String itemId, String category) {
    removedItemIds.remove(itemId);
    update(['cart_list_$category']);
  }


  /// Remove cart item (old method)
  Future<Map<String, dynamic>> removeCartItem(String cartId) async {
    final response = await Get.find<CartService>().removeCartItem(cartId);
    return response;
  }

  /// Update cart (API call)
  Future<bool> updateCart({
    required String cartId,
    required String userId,
    required List<CartItems> items,
    String? placeholder,
  }) async {
    final address = Get.find<AddressController>().selectedDeliveryAddress;
    print("items lenght ${items.length}");
    final cleanedItems = items
        .where((item) => item.quantity > 0)
        .map((item) => {
      "productId": item.productId,
      "quantity": item.quantity,
      "prescriptionUrl": item.prescriptionUrl
    })
        .toList();
    print("length of upadte cart ${items.length}");
    final body = {
      "userId": userId,
      "items": cleanedItems,
      if (placeholder != null) "placeholder": placeholder,
    };

    final isUpdated = await Get.find<CartService>().updateCart(
      cartId: cartId,
      body: body,
    );

    if (isUpdated && address.value != null) {
      await calculateCheckout(address.value!);
    }

    return isUpdated;
  }

  /// Calculate checkout totals
  Future<void> calculateCheckout(AddressModel deliveryAddress) async {
    isCalculating.value = true;

    try {
      final address = Get.find<AddressController>().selectedDeliveryAddress.value;
      final checkoutCon = Get.find<CheckoutController>();

      final cartCheckoutRes = await Get.find<CartService>().calculateCheckout(
          userId: await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? ""),
          deliveryAddress: address ?? AddressModel.empty()
      );

      checkoutCon.groceryCart.value = cartCheckoutRes.groups?.grocery ?? CartGroup.empty();
      checkoutCon.foodCart.value = cartCheckoutRes.groups?.food ?? CartGroup.empty();
      checkoutCon.medicineCart.value = cartCheckoutRes.groups?.medicine ?? CartGroup.empty();
    } finally {
      isCalculating.value = false;
    }
  }
  /// Build localCartItems from ProductController quantities
  void buildLocalCartItemsFromProducts(
      Map<String, dynamic> quantities,
      ) {
    localCartItems.clear();

    quantities.forEach((productId, item) {
      if (item.quantity > 0) {
        localCartItems.add(
          CartItems(
            productId: productId,
            quantity: item.quantity,
            prescriptionUrl: item.prescriptionUrl,
          ),
        );
      }
    });
  }
  void increaseItem(
      String productId, {
        bool requiresPrescription = false,
        String prescriptionUrl = "",
      }) {
    final index =
    localCartItems.indexWhere((item) => item.productId == productId);

    if (index >= 0) {
      localCartItems[index] = localCartItems[index].copyWith(
        quantity: localCartItems[index].quantity + 1,
        productId: productId,
        prescriptionUrl: prescriptionUrl
      );
    } else {
      localCartItems.add(
        CartItems(
          productId: productId,
          quantity: 1,
          prescriptionUrl:
          requiresPrescription ? prescriptionUrl : "",
        ),
      );
    }

    update([productId]); // rebuild only that product UI
  }

  /// Decrease quantity (local only)
  void decreaseItem(String productId) {
    final index =
    localCartItems.indexWhere((item) => item.productId == productId);

    if (index >= 0) {
      final currentQty = localCartItems[index].quantity;

      if (currentQty > 1) {
        localCartItems[index] =
            localCartItems[index].copyWith(quantity: currentQty - 1);
      } else {
        localCartItems.removeAt(index);
      }

      update([productId]);
    }
  }

  /// Get quantity for UI
  int getLocalQuantity(String productId) {
    final index =
    localCartItems.indexWhere((item) => item.productId == productId);
    return index == -1 ? 0 : localCartItems[index].quantity;
  }

}*/
import 'dart:io';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/model/services/cart_service.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/utils/prefs.dart';
import '../../address/model/addressModel.dart';
import '../model/models/cartItemsModel.dart';

class CartController extends GetxController {
  // ✅ Use RxList for reactive updates
  RxList<CartItem> cartList = <CartItem>[].obs;
  Rx<UsersCartModel> usersCart = UsersCartModel.empty().obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isCalculating = false.obs;

  // ✅ Local pending changes (not yet synced)
  RxMap<String, CartItems> pendingItems = <String, CartItems>{}.obs;

  // ✅ Track removed items for optimistic UI
  Set<String> removedItemIds = {};

  /// ===============================
  /// GET CART ITEMS BY CATEGORY
  /// ===============================
  List<CartItem> getCartItemsByCategory(String category) {
    return cartList.where((item) {
      if (removedItemIds.contains(item.id)) return false;
      return item.product?.productType?.toLowerCase() == category.toLowerCase();
    }).toList();
  }

  /// ===============================
  /// UPLOAD PRESCRIPTION
  /// ===============================
  Future<Map<String, dynamic>> uploadPrescriptionBeforeAddingToCart(
      File prescriptionImage) async {
    return await Get.find<CartService>().uploadPrescription(prescriptionImage);
  }

  /// 🔄 Track which item is currently updating
  RxString updatingItemId = RxString("");

  /// ✅ Mark item as updating
  void setUpdatingItem(String productId) {
    updatingItemId.value = productId;
    update([productId]);
  }

  /// ✅ Clear updating state
  void clearUpdatingItem() {
    updatingItemId.value = "";
    update([updatingItemId.value]); // Rebuild with new value
  }


  /// ===============================
  /// INCREASE ITEM (LOCAL ONLY)
  /// ===============================
  void increaseItem(
      String productId, {
        bool requiresPrescription = false,
        String prescriptionUrl = "",
      }) {
    cartList.firstWhere((item) => item.product?.id == productId).quantity+1;
    // print("is pres req $requiresPrescription");
    // final currentItem = pendingItems[productId];
    //
    // if (currentItem != null) {
    //   pendingItems[productId] = currentItem.copyWith(
    //     quantity: currentItem.quantity + 1,
    //     // quantity: currentItem.quantity > 0
    //     //     ? currentItem.quantity + 1
    //     //     : 2,
    //     prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
    //   );
    // } else {
    //   pendingItems[productId] = CartItems(
    //     productId: productId,
    //     quantity: 1,
    //     prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
    //   );
    // }

    // ✅ Update UI for this specific product
    update([productId]);
  }

  void addItemQuantity(
      String productId,
      int addQty, {
        bool requiresPrescription = false,
        String prescriptionUrl = "",
      }) {
    if (addQty <= 0) return;

    final currentItem = pendingItems[productId];

    if (currentItem != null) {
      // ✅ Product exists → add on quantity
      pendingItems[productId] = currentItem.copyWith(
        quantity: currentItem.quantity + addQty,
        prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
      );
    } else {
      // ✅ New product → add with given quantity
      pendingItems[productId] = CartItems(
        productId: productId,
        quantity: addQty,
        prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
      );
    }

    update([productId]);
  }

  // void addItemQuantity(
  //     String productId,
  //     int addQty, {
  //       bool requiresPrescription = false,
  //       String prescriptionUrl = "",
  //     }) {
  //   if (addQty <= 0) return;
  //
  //   final index = cartList.indexWhere(
  //         (item) => item.product?.id == productId,
  //   );
  //
  //   if (index != -1) {
  //     // ✅ Product exists → update quantity
  //     final currentItem = cartList[index];
  //
  //     cartList[index] = currentItem.copyWith(
  //       quantity: currentItem.quantity + addQty,
  //       prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
  //     );
  //   } else {
  //     // ✅ New product → add to cart
  //     cartList.add(
  //       CartItem(
  //         productId: productId,
  //         quantity: addQty,
  //         prescriptionUrl: requiresPrescription ? prescriptionUrl : "",
  //       ),
  //     );
  //   }
  //
  //   update([productId]);
  // }


  /// ===============================
  /// DECREASE ITEM (LOCAL ONLY)
  /// ===============================
  void decreaseItem(String productId) {
    final currentItem = pendingItems[productId];
    cartList.firstWhere((item) => item.product?.id == productId).quantity-1;
    // if (currentItem != null) {
    //   if (currentItem.quantity > 1) {
    //     pendingItems[productId] = currentItem.copyWith(
    //       quantity: currentItem.quantity - 1,
    //     );
    //   } else {
    //     pendingItems.remove(productId);
    //   }

      update([productId]);
    //}
  }

  /// ===============================
  /// GET LOCAL QUANTITY
  /// ===============================
  int getLocalQuantity(String productId) {
    // First check pending items
    if (pendingItems.containsKey(productId)) {
      return pendingItems[productId]!.quantity;
    }

    // Then check cart list
    try {
     // return 0;
      final cartItem = cartList.firstWhere(
            (item) => item.product?.id == productId,
       //return pendingItems[productId]?.quantity ?? 0;
      );
      return cartItem.quantity.toInt();
    } catch (e) {
      return 0;
    }
  }
  // int getLocalQuantityForProducts(String productId) {
  //   // First check pending items
  //   if (pendingItems.containsKey(productId)) {
  //     return pendingItems[productId]!.quantity;
  //   }else{
  //     return 0;
  //   }
  //
  // }

  void increaseItemIfQtyExists(
      String productId, {
        bool requiresPrescription = false,
        String prescriptionUrl = "",
      }) {
    final currentQty = getLocalQuantity(productId);

    // 🚫 RULE: If qty is 0 → do nothing
    if (currentQty == 0) return;

    increaseItem(
      productId,
      requiresPrescription: requiresPrescription,
      prescriptionUrl: prescriptionUrl,
    );
  }
  void decreaseItemIfQtyExists(String productId) {
    final currentQty = getLocalQuantity(productId);

    // 🚫 RULE: If qty is 0 → do nothing
    if (currentQty == 0) return;

    decreaseItem(productId);
  }

  /// ===============================
  /// SYNC CART WITH BACKEND
  /// ===============================
  Future<bool> syncCartWithBackend() async {
    if (Get.find<ProductController>().quantityList.isEmpty) {
      print("⚠️ No pending items to sync");
      return true;
    }

    try {
      final userId = await AuthStorage.getUserFromPrefs().then((u) => u?.id) ?? "";

      // Convert pending items to list
      //final items = pendingItems.values.toList();
      final items =  Get.find<ProductController>().quantityList.map((key, value) {
        return MapEntry(
          key,
          CartItems(
            productId: key,
            quantity: value.quantity,
            prescriptionUrl:  value.prescriptionUrl,
          ),
        );
      }).values.toList();
      print("syncing items count: ${items.length}");

      bool success = false;

      if (usersCart.value != UsersCartModel.empty() ) {
        // Update existing cart
        success = await updateCart(
          cartId: cartList.first.id,
          userId: userId,
          items: items,
        );
      } else {
        // Create new cart
        final body = {
          "userId": userId,
          "items": items.map((e) => e.toJson()).toList(),
          "placeholder": "string",
        };
        success = await Get.find<CartService>().addToCart(body);
      }

      if (success) {
        // ✅ Clear pending items after successful sync
        pendingItems.clear();

        // ✅ Fetch updated cart from backend
        await fetchCarts();
      }

      return success;
    } catch (e) {
      print("❌ Sync error: $e");
      return false;
    }
  }

  /// ===============================
  /// ADD OR UPDATE PRODUCT (DIRECT)
  /// ===============================
  Future<bool> addOrUpdateProductInCart(
      String productId,
      int quantity,
      String? prescriptionUrl,
      ) async {
    try {
      final res = await Get.find<CartService>().updateCart(
        cartId: usersCart.value.id,
        body: {
          "userId": await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? ''),
          "items": [
            {
              "productId": productId,
              "quantity": quantity,
              "prescriptionUrl": prescriptionUrl ?? ""
            }
          ],
        },
      );

      if (res) {
        await _silentFetchCarts();
      }

      return res;
    } catch (e) {
      print("❌ Error updating cart: $e");
      return false;
    }
  }

  /// ===============================
  /// FETCH CARTS (SILENT - NO UI UPDATE)
  /// ===============================
  Future<void> _silentFetchCarts() async {
    try {
      final data = await Get.find<CartService>().getUsersCart();

      if (data != null) {
        usersCart.value = data;
        cartList.value = data.items;
        final selectedAddress = Get.find<AddressController>().selectedDeliveryAddress.value;
        if (selectedAddress != null) {
          await calculateCheckout(selectedAddress);
        }
      }
    } catch (e) {
      print("❌ Silent fetch error: $e");
    }
  }

  /// ===============================
  /// FETCH CARTS (PUBLIC - WITH LOADING)
  /// ===============================
  Future<void> fetchCarts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      removedItemIds.clear();

      final data = await Get.find<CartService>().getUsersCart();

      if (data != null) {
        usersCart.value = data;
        cartList.value = data.items;

        final selectedAddress = Get.find<AddressController>().selectedDeliveryAddress.value;
        if (selectedAddress != null) {
          await calculateCheckout(selectedAddress);
        }

        errorMessage.value = '';
      } else {
        cartList.clear();
        errorMessage.value = 'No items';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      cartList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// ===============================
  /// REMOVE ITEM (OPTIMISTIC UI)
  /// ===============================
  Future<void> removeItemFromCart(
      String itemId,
      String productId,
      String category,
      ) async {
    // Mark as removed immediately
    removedItemIds.add(itemId);
    update(['cart_list_$category']);
  }

  /// ===============================
  /// UNDO REMOVE ITEM
  /// ===============================
  void undoRemoveItem(String itemId, String category) {
    removedItemIds.remove(itemId);
    update(['cart_list_$category']);
  }

  /// ===============================
  /// UPDATE CART (API CALL)
  /// ===============================
  Future<bool> updateCart({
    required String cartId,
    required String userId,
    required List<CartItems> items,
    String? placeholder,
  }) async {
    final address = Get.find<AddressController>().selectedDeliveryAddress;

    final cleanedItems = items
        .where((item) => item.quantity > 0)
        .map((item) => {
      "productId": item.productId,
      "quantity": item.quantity,
      "prescriptionUrl": item.prescriptionUrl ?? ""
    })
        .toList();

    final body = {
      "userId": userId,
      "items": cleanedItems,
      if (placeholder != null) "placeholder": placeholder,
    };

    final isUpdated = await Get.find<CartService>().updateCart(
      cartId: cartId,
      body: body,
    );

    if (isUpdated && address.value != null) {
      await calculateCheckout(address.value!);
    }

    return isUpdated;
  }

  /// ===============================
  /// CALCULATE CHECKOUT
  /// ===============================
  Future<void> calculateCheckout(AddressModel deliveryAddress) async {
    isCalculating.value = true;

    try {
      final address = Get.find<AddressController>().selectedDeliveryAddress.value;
      final checkoutCon = Get.find<CheckoutController>();

      final cartCheckoutRes = await Get.find<CartService>().calculateCheckout(
        userId: await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? ""),
        deliveryAddress: address ?? AddressModel.empty(),
      );

      checkoutCon.groceryCart.value = cartCheckoutRes.groups?.grocery ?? CartGroup.empty();
      checkoutCon.foodCart.value = cartCheckoutRes.groups?.food ?? CartGroup.empty();
      checkoutCon.medicineCart.value = cartCheckoutRes.groups?.medicine ?? CartGroup.empty();
    } finally {
      isCalculating.value = false;
    }
  }

  /// ===============================
  /// BUILD LOCAL CART FROM PRODUCTS
  /// ===============================
  void buildLocalCartItemsFromProducts(Map<String, dynamic> quantities) {
    pendingItems.clear();

    quantities.forEach((productId, item) {
      if (item.quantity > 0) {
        pendingItems[productId] = CartItems(
          productId: productId,
          quantity: item.quantity,
          prescriptionUrl: item.prescriptionUrl,
        );
      }
    });
  }
  void updatePrescription(String productId, String url) {
    final quantityList = Get.find<ProductController>().quantityList;
    final current = quantityList[productId];
    if (current == null) return;

    quantityList[productId] =
        current.copyWith(prescriptionUrl: url);
  }
}