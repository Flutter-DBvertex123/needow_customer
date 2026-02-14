/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/view/widgets/cart_shimmer.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../../../widgets/imageHandler.dart';
import 'chekout_screen.dart';

class CartScreen extends StatefulWidget {
  final bool isFromBottamNav;
  const CartScreen({super.key, required this.isFromBottamNav});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final cartCon = Get.find<CartController>();
  late TabController _tabController;
  bool _isCouponLoading = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartCon.fetchCarts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter carts by category
  // List<CartItem> getCartsByCategory(List<CartModel> carts, String category) {
  //
  //     return carts.first.items.any((item) =>
  //     item.product?.productType?.toLowerCase() == category.toLowerCase()
  //     );
  //   // return carts.where((cart) {
  //   //   return cart.items.any((item) =>
  //   //   item.product?.productType?.toLowerCase() == category.toLowerCase()
  //   //   );
  //   // }).toList();
  //   //
  // }
  List<CartItem> getCartsByCategory(List<CartModel> carts, String category) {
    List<CartItem> result = [];

    for (var cart in carts) {
      for (var item in cart.items) {
        if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
          result.add(item);
        }
      }
    }

    return result;
  }

  // Calculate total for filtered carts
  double calculateCategoryTotal(List<CartItem> cartItems) {
    double total = 0;

      for (var item in cartItems) {
        total += item.lineTotal;

    }
    return total;
  }
  final TextEditingController couponCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            // AppBar
            SliverAppBar(
              leadingWidth: 75,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.background,
              ),
              toolbarHeight: 0.08.toHeightPercent(),
              surfaceTintColor: AppColors.background,
              title: const Column(
                children: [
                  Text(
                    "My Carts",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              leading: widget.isFromBottamNav ?
                SizedBox()  :
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    radius: 30,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.green,
                      size: 25,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              pinned: true,
              collapsedHeight: 0.08.toHeightPercent(),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.black,
                dividerColor: AppColors.primary.withValues(alpha: 0.5),
                dividerHeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,

                padding: const EdgeInsets.symmetric(horizontal: 16),
                tabs: const [
                  Tab(text: "Food"),
                  Tab(text: "Grocery"),
                  Tab(text: "Medicine"),
                ],
              ),
            ),
            // Tab Content
            SliverFillRemaining(
              hasScrollBody: true,
              child: Obx(() {
                if (cartCon.isLoading.value) {
                  return Center(child: CartListShimmer());
                }

                if (cartCon.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text("Error: ${cartCon.errorMessage.value}"),
                  );
                }

                if (cartCon.cartList.isEmpty) {
                  return const Center(child: Text("No items in your cart"));
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCartListTab("Food"),
                    _buildCartListTab("Grocery"),
                    _buildCartListTab("Medicine"),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartListTab(String category) {

    return Obx(() {
      final filteredCartItems = getCartsByCategory(cartCon.cartList, category);
      final categoryTotal = calculateCategoryTotal(filteredCartItems);

      if (filteredCartItems.isEmpty) {
        return Center(
          child: Text("No $category items in your cart"),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredCartItems.length,
              itemBuilder: (context, cartIndex) {
                final item = filteredCartItems[cartIndex];


                if (item == null) return const SizedBox.shrink();

                return Dismissible(
                  key: Key(item.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(delete_icon),
                  ),
                  // onDismissed: (direction) async {
                  //
                  //   cartCon.addOrUpdateLocalCartItem(item.product?.id ?? "", 0);
                  //   //final data = await cartCon.removeCartItem(item.id);
                  //   await cartCon.syncCartWithBackend();
                  //   //AppSnackBar.showSuccess(context, message: data["message"]);
                  // },
                  */
/*onDismissed: (direction) async {
                    // Step 1: Store removed item data
                    String removedProductId = item.product?.id ?? "";
                    int removedQuantity = int.parse(item.quantity.toString());

                    // Step 2: Remove from cart locally
                    cartCon.addOrUpdateLocalCartItem(removedProductId, 0);

                    // Step 3: Show snackbar with UNDO button (3 seconds)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Item removed'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'UNDO',
                          textColor: const Color(0xff0A9962),
                          onPressed: () {
                            // User tapped UNDO: Restore item locally
                            cartCon.addOrUpdateLocalCartItem(removedProductId, removedQuantity);
                          },
                        ),
                      ),
                    ).closed.then((reason) {
                      // Step 4: After snackbar disappears, check if user clicked UNDO
                      // If UNDO was clicked, quantity will be restored (non-zero)
                      // If not clicked, sync with backend to remove permanently
                      if (cartCon.getQuantity(removedProductId) == 0) {
                        // User didn't click UNDO - sync with backend to remove
                        cartCon.syncCartWithBackend();
                      }
                    });
                  },*/ /*

                  onDismissed: (direction) async {
                    // Step 1: Store removed item data
                    String removedProductId = item.product?.id ?? "";
                    int removedQuantity = int.parse(item.quantity.toString());

                    // Step 2: Remove from cart locally
                    cartCon.addOrUpdateLocalCartItem(removedProductId, 0);

                    // Step 3: Flag to track if user clicked UNDO
                    bool isUndone = false;

                    // Step 4: Show snackbar with UNDO button (3 seconds)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Item removed'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'UNDO',
                          textColor: const Color(0xff0A9962),
                          onPressed: () {
                            // User tapped UNDO: Restore item locally
                            isUndone = true;
                            cartCon.addOrUpdateLocalCartItem(removedProductId, removedQuantity);
                          },
                        ),
                      ),
                    ).closed.then((reason) async {
                      // Step 5: After snackbar disappears, sync based on undo status
                      if (isUndone) {
                        // User clicked UNDO - sync to restore
                        await cartCon.syncCartWithBackend();
                        print('Item restored to cart');
                      } else {
                        // User didn't click UNDO - sync to remove permanently
                        await cartCon.syncCartWithBackend();
                        print('Item removed permanently from cart');
                      }
                    });
                  },
                  child: Card(
                    elevation: 0.2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 65,
                                  width: 65,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SafeNetworkImage(
                                      url: (item.product?.imageUrl != null &&
                                          item.product!.imageUrl.isNotEmpty)
                                          ? item.product!.imageUrl[0]
                                          : "",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product?.name ?? "Unknown",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.product?.productType ?? "",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "₹${item.unitPrice ?? 0}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 0.05.toHeightPercent(),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primary
                                            .withValues(alpha: 0.5),
                                        child: const Icon(Icons.remove,
                                            color: Colors.white, size: 16),
                                      ),
                                      onPressed: () async {
                                        if (1 == item.quantity) {
                                          AppSnackBar.show(context,
                                              message:
                                              "You have reached minimum order quantity");
                                        } else {
                                          cartCon.addOrUpdateLocalCartItem(item.product?.id ?? "", int.parse((item.quantity-1).toString()));
                                          await cartCon.syncCartWithBackend();
                                          // List<CartItems> items = [
                                          //   CartItems(
                                          //     productId: item.product!.id,
                                          //     quantity: item.quantity - 1,
                                          //   )
                                          // ];
                                          //
                                          // final response = await cartCon
                                          //     .updateCart(
                                          //   cartId: cart.id,
                                          //   userId: cart.user.id,
                                          //   items: items,
                                          // );
                                          // if (response) {
                                          //   await cartCon.fetchCarts();
                                          // }
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primary,
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 16),
                                      ),
                                      onPressed: () async {
                                        if (item.product?.maxOrderQuantity ==
                                            item.product?.quantity) {
                                          AppSnackBar.show(context,
                                              message:
                                              "You have reached maximum order quantity");
                                        } else {
                                          cartCon.addOrUpdateLocalCartItem(item.product?.id ?? "", int.parse((item.quantity+1).toString()));
                                          await cartCon.syncCartWithBackend();
                                          // List<CartItems> items = [
                                          //   CartItems(
                                          //     productId: item.product!.id,
                                          //     quantity: item.quantity + 1,
                                          //   )
                                          // ];
                                          // final response = await cartCon
                                          //     .updateCart(
                                          //   cartId: cart.id,
                                          //   userId: cart.user.id,
                                          //   items: items,
                                          // );
                                          // if (response) {
                                          //   await cartCon.fetchCarts();
                                          // }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "₹${(item.unitPrice*item.quantity).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Coupon Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 0.06.toHeightPercent(),
                      width: 0.60.toWidthPercent(),
                      child: TextField(
                        controller: couponCtrl,
                        decoration: InputDecoration(
                          hintText: "Enter Coupon Code",
                          hintStyle: TextStyle(
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 0.06.toHeightPercent(),
                      width: 0.25.toWidthPercent(),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isCouponLoading
                              ? AppColors.primary.withValues(alpha: 0.6)
                              : AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: _isCouponLoading ? null : () async {
                          if (couponCtrl.text.isEmpty) {
                            AppSnackBar.showInfo(context, message: "Please enter coupon code");
                            return;
                          }

                          setState(() => _isCouponLoading = true);
                          try {
                            final userId = await AuthStorage.getUserFromPrefs()
                                .then((u) => u?.id ?? "");

                            // IMPORTANT: Pass the category type to apply coupon only to this category
                            await Get.find<CouponController>().redeemCoupon(
                              code: couponCtrl.text,
                              userId: userId,
                              amount: categoryTotal,
                              categoryType: category, // Pass category type (e.g., "grocery", "food", "medicine")
                            );

                            // Clear coupon field on success
                            if (mounted) {
                              couponCtrl.clear();
                            }
                          } catch (e) {
                            AppSnackBar.showError(context, message: "Error applying coupon: $e");
                          } finally {
                            if (mounted) {
                              setState(() => _isCouponLoading = false);
                            }
                          }
                        },
                        child: _isCouponLoading
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Total and Checkout Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          final couponController = Get.find<CouponController>();
                          // Only show discounted amount if coupon is applied to THIS category
                          final isCouponForThisCategory =
                              couponController.appliedCategoryType.value == category;

                          final totalToShow = isCouponForThisCategory &&
                              couponController.finalAmount.value > 0
                              ? couponController.finalAmount.value.toDouble()
                              : categoryTotal;

                          return Text(
                            "₹${totalToShow.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      width: 0.55.toWidthPercent(),
                      child: Appbutton(
                        buttonText: "Checkout",
                        onTap: () {
                          // Get.to(
                          //       () => CheckoutScreen(carts: filteredCartItems),
                          // );
                        },
                        isLoading: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
  Widget _shimmerTile() {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 120, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  CartItem? getItems(List<CartItem> cartItems) {
    if (cartItems.isNotEmpty) {
      return cartItems.first;
    }
    return null;
  }
}*/
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
// import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
// import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/features/cart/view/widgets/cart_shimmer.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/imageHandler.dart';
// import '../../address/view/create_address_screen.dart';
// import 'chekout_screen.dart';
//
// class CartScreen extends StatefulWidget {
//
//   final bool isFromBottamNav;
//   final String? selectedCategory; // Add this parameter
//
//    CartScreen({
//     super.key,
//     required this.isFromBottamNav,
//     this.selectedCategory, // Optional category to auto-select tab
//   });
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
//   final cartCon = Get.find<CartController>();
//   late TabController _tabController;
//   bool _isCouponLoading = false;
//   final addressCtrl = Get.find<AddressController>();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       cartCon.fetchCarts();
//       _selectTabByCategory(); // Select tab based on product type
//     });
//   }
//
//   /// Select tab based on product category
//   void _selectTabByCategory() {
//     int tabIndex = 0;
//
//     if (widget.selectedCategory != null) {
//       switch (widget.selectedCategory?.toLowerCase()) {
//         case 'food':
//           tabIndex = 0;
//           break;
//         case 'grocery':
//           tabIndex = 1;
//           break;
//         case 'medicine':
//           tabIndex = 2;
//           break;
//         default:
//           tabIndex = 0;
//       }
//
//       // Animate to the selected tab
//       if (_tabController.index != tabIndex) {
//         _tabController.animateTo(
//           tabIndex,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//
//       print('Cart Screen: Auto-selected tab index: $tabIndex for category: ${widget.selectedCategory}');
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   // Filter carts by category
//   List<CartItem> getCartsByCategory(List<CartModel> carts, String category) {
//     List<CartItem> result = [];
//
//     for (var cart in carts) {
//       for (var item in cart.items) {
//         if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
//           result.add(item);
//         }
//       }
//     }
//
//     return result;
//   }
//
//   // Calculate total for filtered carts
//   double calculateCategoryTotal(List<CartItem> cartItems) {
//     double total = 0;
//
//     for (var item in cartItems) {
//       total += item.lineTotal;
//     }
//     return total;
//   }
//
//   final TextEditingController couponCtrl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             // AppBar
//             SliverAppBar(
//               leadingWidth: 75,
//               systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarColor: AppColors.background,
//               ),
//               toolbarHeight: 0.08.toHeightPercent(),
//               surfaceTintColor: AppColors.background,
//               title: const Column(
//                 children: [
//                   Text(
//                     "My Cart",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               leading: widget.isFromBottamNav
//                   ? const SizedBox()
//                   : Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: CircleAvatar(
//                     backgroundColor: AppColors.secondary,
//                     radius: 30,
//                     child: const Icon(
//                       Icons.arrow_back_sharp,
//                       color: AppColors.primary,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//               ),
//               centerTitle: true,
//               pinned: true,
//               collapsedHeight: 0.08.toHeightPercent(),
//               bottom: TabBar(
//                 controller: _tabController,
//                 indicatorColor: AppColors.primary,
//                 labelColor: AppColors.primary,
//                 unselectedLabelColor: Colors.black,
//                 dividerColor: AppColors.primary.withValues(alpha: 0.5),
//                 dividerHeight: 2,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicatorWeight: 4,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 tabs: const [
//                   Tab(text: "Food"),
//                   Tab(text: "Grocery"),
//                   Tab(text: "Medicine"),
//                 ],
//               ),
//             ),
//            // Tab Content
//             SliverFillRemaining(
//               hasScrollBody: true,
//               child: Obx(() {
//                 if (cartCon.isLoading.value) {
//                   return Center(child: CartListShimmer());
//                 }
//
//                 if (cartCon.errorMessage.isNotEmpty) {
//                   return Center(
//                     child: Text("Error: ${cartCon.errorMessage.value}"),
//                   );
//                 }
//
//                 if (cartCon.cartList.isEmpty) {
//                   return const Center(child: Text("No items in your cart"));
//                 }
//
//                 return TabBarView(
//                   controller: _tabController,
//                   children: [
//                     // _buildCartListTab("Food",widget.cartCalculation.groups.food),
//                     // _buildCartListTab("Grocery",widget.cartCalculation.groups.grocery),
//                     // _buildCartListTab("Medicine",widget.cartCalculation.groups.medicine),
//                     _buildCartListTab(
//                       "Food",
//                       Get.find<CheckoutController>().foodCart.value!,
//                     ),
//                     _buildCartListTab(
//                       "Grocery",
//                       Get.find<CheckoutController>().groceryCart.value!,
//                     ),
//                     _buildCartListTab(
//                       "Medicine",
//                       Get.find<CheckoutController>().medicineCart.value!,
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCartListTab(String category, CartGroup cartCalculation) {
//     return Obx(() {
//       final filteredCartItems = getCartsByCategory(cartCon.cartList, category,);
//       //final categoryTotal = calculateCategoryTotal(filteredCartItems);
//
//
//       if (filteredCartItems.isEmpty) {
//         return Center(
//           child: Text("No $category items in your cart"),
//         );
//       }
//
//       return Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: filteredCartItems.length,
//               itemBuilder: (context, cartIndex) {
//                 final item = filteredCartItems[cartIndex];
//
//                 if (item == null) return const SizedBox.shrink();
//
//                 return Dismissible(
//                   key: Key(item.toString()),
//                   direction: DismissDirection.endToStart,
//                   background: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: SvgPicture.asset(delete_icon),
//                   ),
//                   onDismissed: (direction) async {
//                     // Step 1: Store removed item data
//                     String removedProductId = item.product?.id ?? "";
//                     int removedQuantity = int.parse(item.quantity.toString());
//
//                     // Step 2: Remove from cart locally
//                     cartCon.addOrUpdateLocalCartItem(removedProductId, 0);
//
//                     // Step 3: Flag to track if user clicked UNDO
//                     bool isUndone = false;
//
//                     // Step 4: Show snackbar with UNDO button (3 seconds)
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text('Item removed'),
//                         duration: const Duration(seconds: 3),
//                         action: SnackBarAction(
//                           label: 'UNDO',
//                           textColor: const Color(0xff0A9962),
//                           onPressed: () {
//                             // User tapped UNDO: Restore item locally
//                             isUndone = true;
//                             cartCon.addOrUpdateLocalCartItem(
//                                 removedProductId, removedQuantity);
//                           },
//                         ),
//                       ),
//                     ).closed.then((reason) async {
//                       // Step 5: After snackbar disappears, sync based on undo status
//                       if (isUndone) {
//                         // User clicked UNDO - sync to restore
//                         await cartCon.syncCartWithBackend();
//                         print('Item restored to cart');
//                       } else {
//                         // User didn't click UNDO - sync to remove permanently
//                         await cartCon.syncCartWithBackend();
//                         print('Item removed permanently from cart');
//                       }
//                     });
//                   },
//                   child: Card(
//                     elevation: 0.2,
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 SizedBox(
//                                   height: 65,
//                                   width: 65,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: SafeNetworkImage(
//                                       url: (item.product?.imageUrl != null &&
//                                           item.product!.imageUrl.isNotEmpty)
//                                           ? item.product!.imageUrl[0]
//                                           : "",
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         item.product?.name ?? "Unknown",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         item.product?.productType ?? "",
//                                         style: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2),
//                                       Text(
//                                         "₹${item.unitPrice ?? 0}",
//                                         style: const TextStyle(fontSize: 15),
//                                       ),
//
//                                       // Text(
//                                       //   "₹${(item.product?.discountedPrice == null ||
//                                       //       item.product?.discountedPrice == 0)
//                                       //       ? item.product?.price ?? 0
//                                       //       : item.product?.discountedPrice ?? 0}",
//                                       //   style: const TextStyle(fontSize: 15),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Container(
//                                 height: 0.05.toHeightPercent(),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.secondary,
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                       padding: EdgeInsets.zero,
//                                       icon: CircleAvatar(
//                                         radius: 15,
//                                         backgroundColor: AppColors.primary
//                                             .withValues(alpha: 0.5),
//                                         child: const Icon(Icons.remove,
//                                             color: Colors.white, size: 16),
//                                       ),
//                                       onPressed: () async {
//                                         if (1 == item.quantity) {
//                                           AppSnackBar.show(context,
//                                               message:
//                                               "You have reached minimum order quantity");
//                                         } else {
//                                           int updatedQty = (item.quantity - 1).toInt();
//
//                                           cartCon.updateUIQty(item.product!.id!, updatedQty);
//                                           cartCon.addOrUpdateLocalCartItem(
//                                               item.product?.id ?? "",
//                                               int.parse((item.quantity - 1)
//                                                   .toString()));
//                                           await cartCon.syncCartWithBackend();
//                                         }
//                                       },
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 2),
//                                       // child: Text(
//                                       //   item.quantity.toString(),
//                                       //   style: const TextStyle(
//                                       //     fontWeight: FontWeight.bold,
//                                       //     fontSize: 16,
//                                       //   ),
//                                       // ),
//                                        child:  GetBuilder<CartController>(
//                                           id: item.product!.id,
//                                           builder: (c) {
//                                             int qty = c.uiQty[item.product!.id] ?? item.quantity.toInt();
//
//                                             return Text(
//                                               qty.toString(),
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                               ),
//                                             );
//                                           },
//                                         )
//
//                                     ),
//                                     IconButton(
//                                       padding: EdgeInsets.zero,
//                                       icon: CircleAvatar(
//                                         radius: 15,
//                                         backgroundColor: AppColors.primary,
//                                         child: const Icon(Icons.add,
//                                             color: Colors.white, size: 16),
//                                       ),
//                                       onPressed: () async {
//                                         if (item.product?.maxOrderQuantity ==
//                                             item.product?.quantity) {
//                                           AppSnackBar.show(context,
//                                               message:
//                                               "You have reached maximum order quantity");
//                                         } else {
//                                           int updatedQty = (item.quantity + 1).toInt();
//
//                                           cartCon.updateUIQty(item.product!.id!, updatedQty);
//                                           cartCon.addOrUpdateLocalCartItem(
//                                               item.product?.id ?? "",
//                                               int.parse((item.quantity + 1)
//                                                   .toString()));
//                                           await cartCon.syncCartWithBackend();
//                                         }
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 // child: Text(
//                                 //   "₹${(item.unitPrice * item.quantity).toStringAsFixed(2)}",
//                                 //   style: const TextStyle(
//                                 //     fontWeight: FontWeight.bold,
//                                 //     fontSize: 14,
//                                 //   ),
//                                 // ),
//                                  child:  GetBuilder<CartController>(
//                                     id: item.product!.id,
//                                     builder: (c) {
//                                       int qty = c.uiQty[item.product!.id] ?? item.quantity.toInt();
//
//                                       return Text(
//                                         "₹${(item.unitPrice * qty).toStringAsFixed(2)}",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       );
//                                       // final price = (item.product?.discountedPrice == null ||
//                                       //     item.product?.discountedPrice == 0)
//                                       //     ? item.product?.price ?? 0
//                                       //     : item.product?.discountedPrice ?? 0;
//                                       //
//                                       // return Text(
//                                       //   "₹${(price * qty).toStringAsFixed(2)}",
//                                       //   style: const TextStyle(
//                                       //     fontWeight: FontWeight.bold,
//                                       //     fontSize: 14,
//                                       //   ),
//                                       // );
//
//                                     },
//                                   )
//
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // ... rest of your bottom container code remains the same
//           Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFFF9F9F9),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   offset: Offset(0, -2),
//                 ),
//               ],
//               border: Border(
//                 top: BorderSide(color: Colors.grey[300]!),
//               ),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (addressCtrl.selectedDeliveryAddress.value == null) ...[
//                   // -------- Saved Addresses --------
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: addressCtrl.usersAddress.length,
//                     separatorBuilder: (_, __) => Divider(
//                       height: 1,
//                       color: AppColors.primary.withValues(alpha: 0.4),
//                     ),
//                     itemBuilder: (context, index) {
//                       final address = addressCtrl.usersAddress[index];
//
//                       return ListTile(
//                         leading: Icon(
//                           address.type == "home"
//                               ? Icons.home_outlined
//                               : Icons.location_city_outlined,
//                           color: AppColors.primary,
//                         ),
//                         title: Text(address.city ?? ""),
//                         subtitle: Text(
//                           "${address.street}\\${address.landmark}\\"
//                               "${address.city}\\${address.state}",
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         trailing: Icon(
//                           Icons.radio_button_unchecked_outlined,
//                           color: AppColors.primary,
//                         ),
//                         onTap: () async {
//                           addressCtrl.selectedDeliveryAddress.value = address;
//                           final response = await cartCon.calculateCheckout(address);
//
//                         },
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // -------- Select from Map --------
//                   ListTile(
//                     leading: Icon(Icons.map_outlined, color: AppColors.primary),
//                     title: Text(
//                       "Select delivery option from map",
//                       style: TextStyle(
//                         color: AppColors.primary,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     onTap: () {
//                       Get.to(() => AddAddressScreen());
//                     },
//                   ),
//                 ],
//
//                 // ================= ADDRESS SELECTED =================
//                 if (addressCtrl.selectedDeliveryAddress.value != null) ...[
//                   // -------- Selected Address Card --------
//                   Card(
//                     elevation: 1,
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.check_circle_outline,
//                         color: AppColors.primary,
//                       ),
//                       title: const Text("Change Address",
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       subtitle: Text(
//                         "${addressCtrl.selectedDeliveryAddress.value?.street ?? ''}\\"
//                             "${addressCtrl.selectedDeliveryAddress.value?.landmark ?? ""}\\"
//                             "${addressCtrl.selectedDeliveryAddress.value?.city ?? ""}\\"
//                             "${addressCtrl.selectedDeliveryAddress.value?.state ?? ""}",
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                       trailing: TextButton(
//                         onPressed: () {
//                           addressCtrl.selectedDeliveryAddress.value = null;
//                         },
//                         child: const Text("Change"),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   // -------- Cart Calculation --------
//                   _buildCartSummary(cartCalculation),
//                   const SizedBox(height: 12),
//                 ],
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       height: 0.06.toHeightPercent(),
//                       width: 0.60.toWidthPercent(),
//                       child: TextField(
//                         controller: couponCtrl,
//                         decoration: InputDecoration(
//                           hintText: "Enter Coupon Code",
//                           hintStyle: TextStyle(
//                             color: Colors.black.withValues(alpha: 0.5),
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(24),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     SizedBox(
//                       height: 0.06.toHeightPercent(),
//                       width: 0.25.toWidthPercent(),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _isCouponLoading
//                               ? AppColors.primary.withValues(alpha: 0.6)
//                               : AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                         ),
//                         onPressed: _isCouponLoading ? null : () async {
//                           if (couponCtrl.text.isEmpty) {
//                             AppSnackBar.showInfo(context, message: "Please enter coupon code");
//                             return;
//                           }
//
//                           setState(() => _isCouponLoading = true);
//                           try {
//                             final userId = await AuthStorage.getUserFromPrefs()
//                                 .then((u) => u?.id ?? "");
//
//                             // IMPORTANT: Pass the category type to apply coupon only to this category
//                             await Get.find<CouponController>().redeemCoupon(
//                               code: couponCtrl.text,
//                               userId: userId,
//                               //amount: categoryTotal,
//                               amount: cartCalculation.groupTotal.toDouble(),
//                               categoryType: category, // Pass category type (e.g., "grocery", "food", "medicine")
//                             );
//
//                             // Clear coupon field on success
//                             if (mounted) {
//                               couponCtrl.clear();
//                             }
//                           } catch (e) {
//                             AppSnackBar.showError(context, message: "Error applying coupon: $e");
//                           } finally {
//                             if (mounted) {
//                               setState(() => _isCouponLoading = false);
//                             }
//                           }
//                         },
//                         child: _isCouponLoading
//                             ? SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                             : const Text(
//                           "Apply",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // Total and Checkout Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Total",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         // Obx(() {
//                         //   final couponController = Get.find<CouponController>();
//                         //   // Only show discounted amount if coupon is applied to THIS category
//                         //   final isCouponForThisCategory =
//                         //       couponController.appliedCategoryType.value == category;
//                         //
//                         //   final totalToShow = isCouponForThisCategory &&
//                         //       couponController.finalAmount.value > 0
//                         //       ? couponController.finalAmount.value.toDouble()
//                         //       :/* categoryTotal*/cartCalculation.groupTotal;
//                         //
//                         //   return Text(
//                         //     "₹${totalToShow.toStringAsFixed(2)}",
//                         //     style: const TextStyle(
//                         //       fontSize: 18,
//                         //       fontWeight: FontWeight.bold,
//                         //     ),
//                         //   );
//                         // }),
//                         Obx(() {
//                           // final couponCtrl = Get.find<CouponController>();
//                           //
//                           // final baseTotal = cartCalculation.groupTotal.toDouble();
//                           //
//                           // final totalToShow = couponCtrl.getEffectiveTotal(
//                           //   category,
//                           //   baseTotal,
//                           // );
//                           final total = getFinalCategoryTotal(
//                             category: category,
//                             baseTotal: cartCalculation.groupTotal.toDouble(),
//                           );
//                           return Text(
//                             "₹${total.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 0.55.toWidthPercent(),
//                       child: Appbutton(
//                         buttonText: "Checkout",
//                         onTap: () {
//                           Get.to(
//                                 () => CheckoutScreen(cartItems: filteredCartItems),
//                           );
//                         },
//
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   CartItem? getItems(List<CartItem> cartItems) {
//     if (cartItems.isNotEmpty) {
//       return cartItems.first;
//     }
//     return null;
//   }
//
//   Widget _buildCartSummary(CartGroup checkout) {
//
//
//     double subtotal = checkout.subtotal.toDouble();
//
//     double deliveryFee = checkout.deliveryFee.toDouble();
//
//     double platformCharge = checkout.platformCharges.toDouble();
//
//     return Card(
//       //margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             _row("Subtotal", subtotal),
//             _row("Delivery Fee", deliveryFee),
//             _row("Platform Charges", platformCharge),
//             const Divider(),
//             _row(
//               "Grand Total",
//               checkout.groupTotal ?? 0,
//               isBold: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _row(String title, num value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight:
//               isBold ? FontWeight.w600 : FontWeight.w400,
//             ),
//           ),
//           Text(
//             "₹$value",
//             style: TextStyle(
//               fontWeight:
//               isBold ? FontWeight.w600 : FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   double getFinalCategoryTotal({
//     required String category,
//     required double baseTotal,
//   }) {
//     final couponCtrl = Get.find<CouponController>();
//
//     if (couponCtrl.isCouponForCategory(category)) {
//       return couponCtrl.finalAmount.value;
//     }
//     return baseTotal;
//   }
//
// }
//
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/view/widgets/cart_shimmer.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../../../widgets/imageHandler.dart';
import '../../address/view/create_address_screen.dart';
import 'chekout_screen.dart';

class CartScreen extends StatefulWidget {
  final bool isFromBottamNav;
  final String? selectedCategory;

  CartScreen({
    super.key,
    required this.isFromBottamNav,
    this.selectedCategory,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final cartCon = Get.find<CartController>();
  late TabController _tabController;
  bool _isCouponLoading = false;
  final addressCtrl = Get.find<AddressController>();
  final TextEditingController couponCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartCon.fetchCarts();
      _selectTabByCategory();
    });
  }

  void _selectTabByCategory() {
    int tabIndex = 0;

    if (widget.selectedCategory != null) {
      switch (widget.selectedCategory?.toLowerCase()) {
        case 'food':
          tabIndex = 0;
          break;
        case 'grocery':
          tabIndex = 1;
          break;
        case 'medicine':
          tabIndex = 2;
          break;
        default:
          tabIndex = 0;
      }

      if (_tabController.index != tabIndex) {
        _tabController.animateTo(
          tabIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    couponCtrl.dispose();
    super.dispose();
  }

  List<CartItem> getCartsByCategory(List<CartModel> carts, String category) {
    List<CartItem> result = [];
    for (var cart in carts) {
      for (var item in cart.items) {
        if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
          result.add(item);
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            // AppBar with Tabs
            Container(
              color: AppColors.background,
              child: Column(
                children: [
                  SizedBox(
                    height: 0.1.toHeightPercent(),
                    child: Stack(
                      children: [
                        if (!widget.isFromBottamNav)
                          Positioned(
                            //left: 16,
                            top: 0.08.toWidthPercent(),
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  radius: 30,
                                  child: const Icon(
                                    Icons.arrow_back_sharp,
                                    color: AppColors.primary,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 0.11.toWidthPercent(),
                          left: 1.toWidthPercent()*0.4,
                          child: const Center(
                            child: Text(
                              "My Cart",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.black,
                    dividerColor: AppColors.primary.withValues(alpha: 0.5),
                    dividerHeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    tabs: const [
                      Tab(text: "Food"),
                      Tab(text: "Grocery"),
                      Tab(text: "Medicine"),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: Obx(() {
                if (cartCon.isLoading.value) {
                  return Center(child: CartListShimmer());
                }

                if (cartCon.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text("Error: ${cartCon.errorMessage.value}"),
                  );
                }

                if (cartCon.cartList.isEmpty) {
                  return const Center(child: Text("No items in your cart"));
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCartListTab(
                      "Food",
                      Get.find<CheckoutController>().foodCart.value!,
                    ),
                    _buildCartListTab(
                      "Grocery",
                      Get.find<CheckoutController>().groceryCart.value!,
                    ),
                    _buildCartListTab(
                      "Medicine",
                      Get.find<CheckoutController>().medicineCart.value!,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartListTab(String category, CartGroup cartCalculation) {
    return Obx(() {
      final filteredCartItems = getCartsByCategory(cartCon.cartList, category);

      if (filteredCartItems.isEmpty) {
        return Center(
          child: Text("No $category items in your cart"),
        );
      }

      return Column(
        children: [
          // Scrollable Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              itemCount: filteredCartItems.length,
              itemBuilder: (context, cartIndex) {
                final item = filteredCartItems[cartIndex];
                if (item == null) return const SizedBox.shrink();

                return Dismissible(
                  key: Key(item.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(delete_icon),
                  ),
                  onDismissed: (direction) async {
                    String removedProductId = item.product?.id ?? "";
                    int removedQuantity = int.parse(item.quantity.toString());
                    cartCon.addOrUpdateLocalCartItem(removedProductId, 0);
                    bool isUndone = false;

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: const Text('Item removed'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'UNDO',
                          textColor: const Color(0xff0A9962),
                          onPressed: () {
                            isUndone = true;
                            cartCon.addOrUpdateLocalCartItem(
                                removedProductId, removedQuantity);
                          },
                        ),
                      ),
                    )
                        .closed
                        .then((reason) async {
                      if (isUndone) {
                        await cartCon.syncCartWithBackend();
                      } else {
                        await cartCon.syncCartWithBackend();
                      }
                    });
                  },
                  child: _buildCartItemCard(item),
                );
              },
            ),
          ),

          // Bottom Container - Fixed
          _buildBottomContainer(category, cartCalculation, filteredCartItems),
        ],
      );
    });
  }

  Widget _buildCartItemCard(CartItem item) {
    return Card(
      elevation: 0.2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            SizedBox(
              height: 65,
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SafeNetworkImage(
                  url: (item.product?.imageUrl != null &&
                      item.product!.imageUrl.isNotEmpty)
                      ? item.product!.imageUrl[0]
                      : "",
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.name ?? "Unknown",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product?.productType ?? "",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "₹${item.unitPrice ?? 0}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          AppColors.primary.withValues(alpha: 0.5),
                          child: const Icon(Icons.remove,
                              color: Colors.white, size: 16),
                        ),
                        onPressed: () async {
                          if (1 == item.quantity) {
                            AppSnackBar.show(context,
                                message:
                                "You have reached minimum order quantity");
                          } else {
                            int updatedQty = (item.quantity - 1).toInt();
                            cartCon.updateUIQty(item.product!.id!, updatedQty);
                            cartCon.addOrUpdateLocalCartItem(
                                item.product?.id ?? "",
                                int.parse((item.quantity - 1).toString()));
                            await cartCon.syncCartWithBackend();
                          }
                        },
                      ),
                      GetBuilder<CartController>(
                        id: item.product!.id,
                        builder: (c) {
                          int qty = c.uiQty[item.product!.id] ??
                              item.quantity.toInt();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              qty.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primary,
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                        onPressed: () async {
                          if (item.product?.maxOrderQuantity ==
                              item.product?.quantity) {
                            AppSnackBar.show(context,
                                message:
                                "You have reached maximum order quantity");
                          } else {
                            int updatedQty = (item.quantity + 1).toInt();
                            cartCon.updateUIQty(item.product!.id!, updatedQty);
                            cartCon.addOrUpdateLocalCartItem(
                                item.product?.id ?? "",
                                int.parse((item.quantity + 1).toString()));
                            await cartCon.syncCartWithBackend();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GetBuilder<CartController>(
                  id: item.product!.id,
                  builder: (c) {
                    int qty =
                        c.uiQty[item.product!.id] ?? item.quantity.toInt();
                    return Text(
                      "₹${(item.unitPrice * qty).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContainer(
      String category, CartGroup cartCalculation, List<CartItem> filteredCartItems) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Address Selection (Compact)
          if (addressCtrl.selectedDeliveryAddress.value == null)
            _buildAddressSelection()
          else
            _buildSelectedAddress(),

          // Divider
          Divider(height: 1, color: Colors.grey[300]),

          // Bottom Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cart Summary (if address selected)
                if (addressCtrl.selectedDeliveryAddress.value != null)
                  _buildCompactSummary(cartCalculation),

                // Coupon Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          controller: couponCtrl,
                          decoration: InputDecoration(
                            hintText: "Coupon Code",
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 48,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isCouponLoading
                              ? AppColors.primary.withValues(alpha: 0.6)
                              : AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: _isCouponLoading
                            ? null
                            : () => _applyCoupon(category, cartCalculation),
                        child: _isCouponLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                            : const Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Total and Checkout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          final total = getFinalCategoryTotal(
                            category: category,
                            baseTotal: cartCalculation.groupTotal.toDouble(),
                          );
                          return Text(
                            "₹${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      width: 0.50.toWidthPercent(),
                      child: Appbutton(
                        buttonText: "Checkout",
                        onTap: () {
                          Get.to(() =>
                              CheckoutScreen(cartItems: filteredCartItems));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSelection() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Saved Addresses
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addressCtrl.usersAddress.length,
              itemBuilder: (context, index) {
                final address = addressCtrl.usersAddress[index];
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  leading: Icon(
                    address.type == "home"
                        ? Icons.home_outlined
                        : Icons.location_city_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  title: Text(
                    address.city ?? "",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "${address.street}, ${address.landmark}, ${address.city}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: Icon(
                    Icons.radio_button_unchecked_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onTap: () async {
                    addressCtrl.selectedDeliveryAddress.value = address;
                    await cartCon.calculateCheckout(address);
                  },
                );
              },
            ),

            // Select from Map
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.map_outlined, color: AppColors.primary, size: 20),
              title: Text(
                "Select from map",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Get.to(() => AddAddressScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedAddress() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${addressCtrl.selectedDeliveryAddress.value?.street}, "
                      "${addressCtrl.selectedDeliveryAddress.value?.city}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              addressCtrl.selectedDeliveryAddress.value = null;
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text("Change", style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSummary(CartGroup checkout) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Subtotal: ₹${checkout.subtotal}  •  Delivery: ₹${checkout.deliveryFee}  •  Platform: ₹${checkout.platformCharges}",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _applyCoupon(String category, CartGroup cartCalculation) async {
    if (couponCtrl.text.isEmpty) {
      AppSnackBar.showInfo(context, message: "Please enter coupon code");
      return;
    }

    setState(() => _isCouponLoading = true);
    try {
      final userId =
      await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "");

      await Get.find<CouponController>().redeemCoupon(
        code: couponCtrl.text,
        userId: userId,
        amount: cartCalculation.groupTotal.toDouble(),
        categoryType: category,
      );

      if (mounted) {
        couponCtrl.clear();
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Error applying coupon: $e");
    } finally {
      if (mounted) {
        setState(() => _isCouponLoading = false);
      }
    }
  }

  double getFinalCategoryTotal({
    required String category,
    required double baseTotal,
  }) {
    final couponCtrl = Get.find<CouponController>();

    if (couponCtrl.isCouponForCategory(category)) {
      return couponCtrl.finalAmount.value;
    }
    return baseTotal;
  }
}*/
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
// import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
// import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
// import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
// import 'package:newdow_customer/features/cart/view/widgets/cart_shimmer.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/utils/prefs.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbutton.dart';
// import '../../../widgets/imageHandler.dart';
// import '../../address/view/create_address_screen.dart';
// import 'chekout_screen.dart';
//
// class CartScreen extends StatefulWidget {
//   final bool isFromBottamNav;
//   final String? selectedCategory;
//
//   CartScreen({
//     super.key,
//     required this.isFromBottamNav,
//     this.selectedCategory,
//   });
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
//   final cartCon = Get.find<CartController>();
//   late TabController _tabController;
//   bool _isCouponLoading = false;
//   final addressCtrl = Get.find<AddressController>();
//   final TextEditingController couponCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       cartCon.fetchCarts();
//       _selectTabByCategory();
//     });
//   }
//
//   void _selectTabByCategory() {
//     int tabIndex = 0;
//
//     if (widget.selectedCategory != null) {
//       switch (widget.selectedCategory?.toLowerCase()) {
//         case 'food':
//           tabIndex = 0;
//           break;
//         case 'grocery':
//           tabIndex = 1;
//           break;
//         case 'medicine':
//           tabIndex = 2;
//           break;
//         default:
//           tabIndex = 0;
//       }
//
//       if (_tabController.index != tabIndex) {
//         _tabController.animateTo(
//           tabIndex,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     couponCtrl.dispose();
//     super.dispose();
//   }
//
//   List<CartItem> getCartsByCategory(List<CartItem> cartItems, String category) {
//     print("Data to filter ${cartItems.length}");
//     List<CartItem> result = [];
//     // for (var cart in carts) {
//     //   for (var item in cart.items) {
//     //     if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
//     //       result.add(item);
//     //     }
//     //   }
//     // }
//     //cartItems.map((item) {
//       // if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
//       //         result.add(item);
//       //       }
//         for (var item in cartItems) {
//           print("itration ${item.product?.productType?.toLowerCase()}");
//           if (item.product?.productType?.toLowerCase() == category.toLowerCase()) {
//             result.add(item);
//           }
//         }
//     //});
//     print("filltereDate ;- ${result.length}");
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         body: Column(
//           children: [
//             // AppBar with Tabs
//             Container(
//               color: AppColors.background,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 0.1.toHeightPercent(),
//                     child: Stack(
//                       children: [
//                         if (!widget.isFromBottamNav)
//                           Positioned(
//                             //left: 16,
//                             top: 0.08.toWidthPercent(),
//                             bottom: 0,
//                             child: Center(
//                               child: IconButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 icon: CircleAvatar(
//                                   backgroundColor: AppColors.secondary,
//                                   radius: 30,
//                                   child: const Icon(
//                                     Icons.arrow_back_sharp,
//                                     color: AppColors.primary,
//                                     size: 25,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 0.11.toWidthPercent(),
//                             left: 1.toWidthPercent()*0.4,
//                             child: const Center(
//                               child: Text(
//                                 "My Cart",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           )
//                       ],
//                     ),
//                   ),
//                   TabBar(
//                     controller: _tabController,
//                     indicatorColor: AppColors.primary,
//                     labelColor: AppColors.primary,
//                     unselectedLabelColor: Colors.black,
//                     dividerColor: AppColors.primary.withValues(alpha: 0.5),
//                     dividerHeight: 2,
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     indicatorWeight: 4,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     tabs: const [
//                       Tab(text: "Food"),
//                       Tab(text: "Grocery"),
//                       Tab(text: "Medicine"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Tab Content
//             Expanded(
//               child: Obx(() {
//                 if (cartCon.isLoading.value) {
//                   return Center(child: CartListShimmer());
//                 }
//
//                 if (cartCon.errorMessage.isNotEmpty) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Image.asset(add_cart_icon,scale: 3,),
//                       Text("Add products in cart to get start."),
//                     ],
//                   );
//                 }
//
//                 if (cartCon.cartList.isEmpty) {
//                   return  Center(child: Text("No items in your cart"));
//                 }
//
//                 return TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildCartListTab(
//                       "Food",
//                       Get.find<CheckoutController>().foodCart.value!,
//                     ),
//                     _buildCartListTab(
//                       "Grocery",
//                       Get.find<CheckoutController>().groceryCart.value!,
//                     ),
//                     _buildCartListTab(
//                       "Medicine",
//                       Get.find<CheckoutController>().medicineCart.value!,
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Cart list Tab
//   Widget _buildCartListTab(String category, CartGroup cartCalculation) {
//     return Obx(() {
//       cartCon.isLoading.value;
//       final filteredCartItems = getCartsByCategory(cartCon.cartList, category);
//
//       if (filteredCartItems.isEmpty) {
//         return Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(empty_cart,scale: 3,),
//             Text("No $category items in your cart"),
//           ],
//         );
//       }
//
//       return Column(
//         children: [
//           // Scrollable Cart Items
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//               itemCount: filteredCartItems.length,
//               itemBuilder: (context, cartIndex) {
//                 final item = filteredCartItems[cartIndex];
//                 if (item == null) return const SizedBox.shrink();
//
//                 return Dismissible(
//                   key: Key(item.toString()),
//                   direction: DismissDirection.endToStart,
//                   background: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: SvgPicture.asset(delete_icon),
//                   ),
//                   onDismissed: (direction) async {
//                     CartItem removedItem = item;
//                     String removedProductId = item.product?.id ?? "";
//                     int removedQuantity = int.parse(item.quantity.toString());
//                     cartCon.cartList.remove(item);
//                     //cartCon.addOrUpdateLocalCartItem(removedProductId, 0);
//                     bool isUndone = false;
//
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(
//                       SnackBar(
//                         content: const Text('Item removed'),
//                         duration: const Duration(seconds: 3),
//                         action: SnackBarAction(
//                           label: 'UNDO',
//                           textColor: const Color(0xff0A9962),
//                           onPressed: () {
//                             isUndone = true;
//                             // cartCon.addOrUpdateLocalCartItem(
//                             //     removedProductId, removedQuantity);
//                           },
//                         ),
//                       ),
//                     )
//                         .closed
//                         .then((reason) async {
//                       if (isUndone) {
//                         print("Undo removed item");
//                         //await cartCon.syncCartWithBackend();
//                         cartCon.cartList.assign(removedItem);
//                       } else {
//                         //await cartCon.syncCartWithBackend();
//                         await cartCon.addOrUpdateProductInCart(item.product?.id ?? "", 0);
//                       }
//                     });
//                   },
//                   child: _buildCartItemCard(item),
//                 );
//               },
//             ),
//           ),
//
//           // Bottom Container - Fixed
//           _buildBottomContainer(category, cartCalculation, filteredCartItems),
//         ],
//       );
//     });
//   }
//
//   /// Cart Item card
//   Widget _buildCartItemCard(CartItem item) {
//     return Card(
//       elevation: 0.2,
//       margin: const EdgeInsets.only(bottom: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Product Image
//             SizedBox(
//               height: 65,
//               width: 65,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: SafeNetworkImage(
//                   url: (item.product?.imageUrl != null &&
//                       item.product!.imageUrl.isNotEmpty)
//                       ? item.product!.imageUrl[0]
//                       : "",
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//
//             // Product Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.product?.name ?? "Unknown",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     item.product?.productType ?? "",
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     "₹${item.unitPrice ?? 0}",
//                     style: const TextStyle(fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Quantity Controls
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: AppColors.secondary,
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(
//                           minWidth: 40,
//                           minHeight: 40,
//                         ),
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                           AppColors.primary.withValues(alpha: 0.5),
//                           child: const Icon(Icons.remove,
//                               color: Colors.white, size: 16),
//                         ),
//                         onPressed: () async {
//                           if (1 == item.quantity) {
//                             AppSnackBar.show(context,
//                                 message:
//                                 "You have reached minimum order quantity");
//                           } else {
//                             // int updatedQty = (item.quantity - 1).toInt();
//                             // cartCon.updateUIQty(item.product!.id!, updatedQty);
//                             // cartCon.addOrUpdateLocalCartItem(
//                             //     item.product?.id ?? "",
//                             //     int.parse((item.quantity - 1).toString()));
//                             // await cartCon.syncCartWithBackend();
//                             int updatedQty = (item.quantity - 1).toInt();
//                             cartCon.updateUIQty(item.product!.id, updatedQty);
//                             await cartCon.addOrUpdateProductInCart(item.product!.id, updatedQty);
//                           }
//                         },
//                       ),
//                       GetBuilder<CartController>(
//                         id: item.product!.id,
//                         builder: (c) {
//                           int qty = c.uiQty[item.product!.id] ??
//                               item.quantity.toInt();
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: Text(
//                               qty.toString(),
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(
//                           minWidth: 40,
//                           minHeight: 40,
//                         ),
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor: AppColors.primary,
//                           child: const Icon(Icons.add,
//                               color: Colors.white, size: 16),
//                         ),
//                         onPressed: () async {
//                           if (item.product?.maxOrderQuantity ==
//                               item.product?.quantity) {
//                             AppSnackBar.show(context,
//                                 message:
//                                 "You have reached maximum order quantity");
//                           } else {
//                             // int updatedQty = (item.quantity + 1).toInt();
//                             // cartCon.updateUIQty(item.product!.id!, updatedQty);
//                             // cartCon.addOrUpdateLocalCartItem(
//                             //     item.product?.id ?? "",
//                             //     int.parse((item.quantity + 1).toString()));
//                             // await cartCon.syncCartWithBackend();
//                             int updatedQty = (item.quantity + 1).toInt();
//                             cartCon.updateUIQty(item.product!.id, updatedQty);
//                             await cartCon.addOrUpdateProductInCart(item.product!.id, updatedQty);
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 GetBuilder<CartController>(
//                   id: item.product!.id,
//                   builder: (c) {
//                     int qty =
//                         c.uiQty[item.product!.id] ?? item.quantity.toInt();
//                     return Text(
//                       "₹${(item.unitPrice * qty).toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Bottam Conatiner with address and cart calculation
//   Widget _buildBottomContainer(
//       String category, CartGroup cartCalculation, List<CartItem> filteredCartItems) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF9F9F9),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//         border: Border(
//           top: BorderSide(color: Colors.grey[300]!),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Address Selection (Compact)
//           if (addressCtrl.selectedDeliveryAddress.value == null)
//             _buildAddressSelection()
//           else
//             _buildSelectedAddress(),
//
//           // Divider
//           Divider(height: 1, color: Colors.grey[300]),
//
//           // Bottom Actions
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Cart Summary (if address selected)
//                 if (addressCtrl.selectedDeliveryAddress.value != null)
//                   _buildCompactSummary(cartCalculation),
//
//                 // Coupon Row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 48,
//                         child: TextField(
//                           controller: couponCtrl,
//                           decoration: InputDecoration(
//                             hintText: "Coupon Code",
//                             hintStyle: TextStyle(
//                               color: Colors.black.withValues(alpha: 0.5),
//                               fontSize: 14,
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(24),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     SizedBox(
//                       height: 48,
//                       width: 100,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _isCouponLoading
//                               ? AppColors.primary.withValues(alpha: 0.6)
//                               : AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                         ),
//                         onPressed: _isCouponLoading
//                             ? null
//                             : () => _applyCoupon(category, cartCalculation),
//                         child: _isCouponLoading
//                             ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white),
//                           ),
//                         )
//                             : const Text(
//                           "Apply",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Total and Checkout
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Total",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Obx(() {
//                           if (cartCon.isCalculating.value) {
//                             return Row(
//                               children: [
//                                 SizedBox(
//                                   height: 16,
//                                   width: 16,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         AppColors.primary),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   "Calculating...",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }
//
//                           final total = getFinalCategoryTotal(
//                             category: category,
//                             baseTotal: cartCalculation.groupTotal.toDouble(),
//                           );
//                           return Text(
//                             "₹${total.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                     // SizedBox(
//                     //   width: 0.50.toWidthPercent(),
//                     //   child: Obx(() => Appbutton(
//                     //     buttonText: cartCon.isCalculating.value ? "Please wait..." : "Checkout",
//                     //     onTap: () => cartCon.isCalculating.value ? null : () {
//                     //       print("naviagting to check out screen");
//                     //       Get.to(() =>
//                     //           CheckoutScreen(cartItems: filteredCartItems,checkoutCalculation: cartCalculation,));
//                     //     },
//                     //   )),
//                     // ),
//                     SizedBox(
//                       width: 0.50.toWidthPercent(),
//                       child: Obx(() => Appbutton(
//                         buttonText: cartCon.isCalculating.value ? "Please wait..." : "Checkout",
//                         onTap: () {
//                           if (cartCon.isCalculating.value) return; // Early return if calculating
//
//                           print("navigating to check out screen");
//                           Get.to(() => CheckoutScreen(
//                             orderTotal: getFinalCategoryTotal(category: category, baseTotal: cartCalculation.groupTotal.toDouble()),
//                             cartItems: filteredCartItems,
//                             checkoutCalculation: cartCalculation,
//                           ));
//                         },
//                       )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressSelection() {
//     return Container(
//       constraints: const BoxConstraints(maxHeight: 200),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Saved Addresses
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: addressCtrl.usersAddress.length,
//               itemBuilder: (context, index) {
//                 final address = addressCtrl.usersAddress[index];
//                 return ListTile(
//                   dense: true,
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//                   leading: Icon(
//                     address.type == "home"
//                         ? Icons.home_outlined
//                         : Icons.location_city_outlined,
//                     color: AppColors.primary,
//                     size: 20,
//                   ),
//                   title: Text(
//                     address.city ?? "",
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                   subtitle: Text(
//                     "${address.street}, ${address.landmark}, ${address.city}",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontSize: 11),
//                   ),
//                   trailing: Icon(
//                     Icons.radio_button_unchecked_outlined,
//                     color: AppColors.primary,
//                     size: 20,
//                   ),
//                   onTap: () async {
//                     cartCon.isCalculating.value = true;
//                     try {
//                       addressCtrl.selectedDeliveryAddress.value = address;
//                       await cartCon.calculateCheckout(address);
//                     } catch (e) {
//                       print("Error calculating checkout: $e");
//                     } finally {
//                       if (mounted) {
//                         cartCon.isCalculating.value = false;
//                       }
//                     }
//                   },
//                 );
//               },
//             ),
//
//             // Select from Map
//             ListTile(
//               dense: true,
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//               leading: Icon(Icons.map_outlined, color: AppColors.primary, size: 20),
//               title: Text(
//                 "Select from map",
//                 style: TextStyle(
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 Get.to(() => AddAddressScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSelectedAddress() {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           Icon(Icons.check_circle, color: AppColors.primary, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Delivery Address",
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   "${addressCtrl.selectedDeliveryAddress.value?.street}, "
//                       "${addressCtrl.selectedDeliveryAddress.value?.city}",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontSize: 11, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               if (!cartCon.isCalculating.value) {
//                 addressCtrl.selectedDeliveryAddress.value = null;
//               }
//             },
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               minimumSize: const Size(0, 30),
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             child: Obx(() => Text(
//               "Change",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: cartCon.isCalculating.value ? Colors.grey : null,
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCompactSummary(CartGroup checkout) {
//     return Obx(() {
//       if (cartCon.isCalculating.value) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "Subtotal: ... •  Delivery: ... •  Platform: ... ",
//                 style: const TextStyle(fontSize: 11, color: Colors.grey),
//               ),
//             ],
//           ),
//         );
//       }
//
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Subtotal: ₹${checkout.subtotal}  •  Delivery: ₹${checkout.deliveryFee}  •  Platform: ₹${checkout.platformCharges}",
//               style: const TextStyle(fontSize: 11, color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Future<void> _applyCoupon(String category, CartGroup cartCalculation) async {
//     if (couponCtrl.text.isEmpty) {
//       AppSnackBar.showInfo(context, message: "Please enter coupon code");
//       return;
//     }
//
//     setState(() => _isCouponLoading = true);
//     try {
//       final userId =
//       await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "");
//
//       await Get.find<CouponController>().redeemCoupon(
//         code: couponCtrl.text,
//         userId: userId,
//         amount: cartCalculation.groupTotal.toDouble(),
//         categoryType: category,
//       );
//
//       if (mounted) {
//         couponCtrl.clear();
//       }
//     } catch (e) {
//       AppSnackBar.showError(context, message: "Error applying coupon: $e");
//     } finally {
//       if (mounted) {
//         setState(() => _isCouponLoading = false);
//       }
//     }
//   }
//
//   double getFinalCategoryTotal({
//     required String category,
//     required double baseTotal,
//   }) {
//     final couponCtrl = Get.find<CouponController>();
//
//     if (couponCtrl.isCouponForCategory(category)) {
//       return couponCtrl.finalAmount.value;
//     }
//     return baseTotal;
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/controller/checkout_controller.dart';
import 'package:newdow_customer/features/cart/controller/cupoonController.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';
import 'package:newdow_customer/features/cart/model/models/cartModel.dart';
import 'package:newdow_customer/features/cart/view/widgets/cart_shimmer.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/snackBar.dart';

import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../../../widgets/imageHandler.dart';
import '../../address/view/create_address_screen.dart';
import '../../product/view/widgets/uploadPrescriptionDialog.dart';
import 'chekout_screen.dart';

class CartScreen extends StatefulWidget {
  final bool isFromBottamNav;
  final String? selectedCategory;

  CartScreen({super.key, required this.isFromBottamNav, this.selectedCategory});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final cartCon = Get.find<CartController>();
  late TabController _tabController;
  bool _isCouponLoading = false;
  final addressCtrl = Get.find<AddressController>();
  final TextEditingController couponCtrl = TextEditingController();
  String restaturentId = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartCon.fetchCarts();
      // cartCon.pendingItems = cartCon.cartList.
      _selectTabByCategory();
    });
  }

  void _selectTabByCategory() {
    int tabIndex = 0;

    if (widget.selectedCategory != null) {
      switch (widget.selectedCategory?.toLowerCase()) {
        case 'food':
          tabIndex = 0;
          break;
        case 'grocery':
          tabIndex = 1;
          break;
        case 'medicine':
          tabIndex = 2;
          break;
        default:
          tabIndex = 0;
      }

      if (_tabController.index != tabIndex) {
        _tabController.animateTo(
          tabIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    couponCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            // AppBar with Tabs (Static - never rebuilds)
            Container(
              color: AppColors.background,
              child: Column(
                children: [
                  SizedBox(
                    height: 0.1.toHeightPercent(),
                    child: Stack(
                      children: [
                        if (!widget.isFromBottamNav)
                          Positioned(
                            top: 0.08.toWidthPercent(),
                            bottom: 0,
                            child: Center(
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: CircleAvatar(
                                  backgroundColor: AppColors.secondary,
                                  radius: 30,
                                  child: const Icon(
                                    Icons.arrow_back_sharp,
                                    color: AppColors.primary,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 0.11.toWidthPercent(),
                          left: 1.toWidthPercent() * 0.4,
                          child: const Center(
                            child: Text(
                              "My Cart",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.black,
                    dividerColor: AppColors.primary.withValues(alpha: 0.5),
                    dividerHeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    tabs: const [
                      Tab(text: "Food"),
                      Tab(text: "Grocery"),
                      Tab(text: "Medicine"),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Content - Only rebuild on initial load/error
            Expanded(
              child: Obx(() {
                if (cartCon.isLoading.value) {
                  return Center(child: CartListShimmer());
                }

                if (cartCon.errorMessage.isNotEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(add_cart_icon, scale: 3),
                      Text("Add products in cart to get start."),
                    ],
                  );
                }

                if (cartCon.cartList.isEmpty) {
                  return const Center(child: Text("No items in your cart"));
                }

                // Return TabBarView WITHOUT Obx - it never needs to rebuild
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCartListTab(
                      "Food",
                      Get.find<CheckoutController>().foodCart.value ??
                          CartGroup.empty(),
                    ),
                    _buildCartListTab(
                      "Grocery",
                      Get.find<CheckoutController>().groceryCart.value ??
                          CartGroup.empty(),
                    ),
                    _buildCartListTab(
                      "Medicine",
                      Get.find<CheckoutController>().medicineCart.value ??
                          CartGroup.empty(),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Cart list Tab - Uses GetBuilder for surgical updates
  Widget _buildCartListTab(String category, CartGroup cartCalculation) {
    // GetBuilder only rebuilds when update(['cart_list_$category']) is called
    return GetBuilder<CartController>(
      id: 'cart_list_$category',
      builder: (controller) {
        final filteredCartItems = controller.getCartItemsByCategory(category);

        if (filteredCartItems.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(empty_cart, scale: 3),
              Text("No $category items in your cart"),
            ],
          );
        }

        return Column(
          children: [
            // Scrollable Cart Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                itemCount: filteredCartItems.length,
                itemBuilder: (context, cartIndex) {
                  final item = filteredCartItems[cartIndex];
                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SvgPicture.asset(delete_icon),
                    ),
                    // confirmDismiss: (direction) async {
                    //   // Immediately remove from UI
                    //   cartCon.removeItemFromCart(item.id, item.product?.id ?? "", category);
                    //
                    //   // Show undo snackbar
                    //   final result = await ScaffoldMessenger.of(context)
                    //       .showSnackBar(
                    //     SnackBar(
                    //       content: const Text('Item removed'),
                    //       duration: const Duration(seconds: 3),
                    //       action: SnackBarAction(
                    //         label: 'UNDO',
                    //         textColor: const Color(0xff0A9962),
                    //         onPressed: () {
                    //           // Restore item in UI
                    //           cartCon.undoRemoveItem(item.id, category);
                    //         },
                    //       ),
                    //     ),
                    //   ).closed;
                    //
                    //   // If user didn't undo, backend already synced
                    //   return false; // Return false to prevent Dismissible from removing (we already did)
                    // },
                    confirmDismiss: (direction) async {
                      // Remove only from UI
                      cartCon.removeItemFromCart(
                        item.id,
                        item.product?.id ?? "",
                        category,
                      );

                      final result = await ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(
                              content: const Text('Item removed'),
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'UNDO',
                                textColor: const Color(0xff0A9962),
                                onPressed: () {
                                  cartCon.undoRemoveItem(item.id, category);
                                },
                              ),
                            ),
                          )
                          .closed;

                      // 🔥 If user DID NOT press UNDO → sync backend
                      if (result != SnackBarClosedReason.action) {
                        await cartCon.addOrUpdateProductInCart(
                          item.product?.id ?? "",
                          0,
                          null,
                        );
                      }

                      return false;
                    },

                    child: _buildCartItemCard(item, category),
                  );
                },
              ),
            ),

            // Bottom Container - Fixed
            _buildBottomContainer(category, cartCalculation, filteredCartItems),
          ],
        );
      },
    );
  }

  /// Cart Item card - Individual item rebuilds independently
  Widget _buildCartItemCard(CartItem item, String category) {
    bool _isLoading = false;
    return Card(
      elevation: 0.2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image (Static)
            SizedBox(
              height: 65,
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SafeNetworkImage(
                  url:
                      (item.product?.imageUrl != null &&
                          item.product!.imageUrl.isNotEmpty)
                      ? item.product!.imageUrl[0]
                      : "",
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details (Static)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.name ?? "Unknown",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product?.productType ?? "",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "₹${item.unitPrice ?? 0}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

            // Quantity Controls - ONLY THIS REBUILDS
            GetBuilder<CartController>(
              id: item.product!.id,
              builder: (c) {
                int qty = c.getLocalQuantity(item.product!.id);
                bool isUpdating = c.updatingItemId.value == item.product!.id;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Quantity Controls Container
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ➖ DECREASE BUTTON
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            onPressed: isUpdating
                                ? null
                                : () async {
                                    if (qty <= 1) {
                                      AppSnackBar.show(
                                        context,
                                        message:
                                            "You have reached minimum order quantity",
                                      );
                                    } else {
                                      int updatedQty = qty - 1;
                                      // Update UI immediately
                                      cartCon.decreaseItem(item.product!.id);
                                      // Mark as updating
                                      cartCon.setUpdatingItem(item.product!.id);
                                      // Sync with backend
                                      await cartCon.addOrUpdateProductInCart(
                                        item.product!.id,
                                        updatedQty,
                                        item.prescriptionUrl,
                                      );
                                      // Mark as done updating
                                      cartCon.clearUpdatingItem();
                                    }
                                  },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.5,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          // 🔢 QUANTITY DISPLAY
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: isUpdating
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                    ),
                                  )
                                : Text(
                                    qty.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                          // ➕ INCREASE BUTTON
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            onPressed: isUpdating
                                ? null
                                : () async {
                                    if (item.product?.maxOrderQuantity == qty) {
                                      AppSnackBar.show(
                                        context,
                                        message:
                                            "You have reached maximum order quantity",
                                      );
                                      return;
                                    }

                                    final requiresPrescription =
                                        item.product!.isPrescriptionRequired ==
                                        true;

                                    // If prescription required, show dialog first
                                    if (requiresPrescription) {
                                      setState(() => _isLoading = true);

                                      showPrescriptionDialog(context, (
                                        File? image,
                                      ) async {
                                        if (image == null) {
                                          setState(() => _isLoading = false);
                                          return;
                                        }

                                        setState(() => _isLoading = true);

                                        try {
                                          // Upload prescription
                                          final result = await cartCon
                                              .uploadPrescriptionBeforeAddingToCart(
                                                image,
                                              );

                                          if (result['success'] == true) {
                                            final prescriptionUrl =
                                                result['url'] ?? "";
                                            print(
                                              'Prescription URL: $prescriptionUrl',
                                            );

                                            int updatedQty = qty + 1;
                                            // Update UI immediately
                                            cartCon.increaseItem(
                                              item.product!.id,
                                            );
                                            // Mark as updating
                                            cartCon.setUpdatingItem(
                                              item.product!.id,
                                            );
                                            // Sync with backend with prescription
                                            await cartCon
                                                .addOrUpdateProductInCart(
                                                  item.product!.id,
                                                  updatedQty,
                                                  prescriptionUrl,
                                                );
                                            // Mark as done updating
                                            cartCon.clearUpdatingItem();

                                            AppSnackBar.showSuccess(
                                              context,
                                              message:
                                                  result['message'] ??
                                                  "Prescription uploaded & cart updated",
                                            );
                                          } else {
                                            AppSnackBar.showError(
                                              context,
                                              message:
                                                  result['message'] ??
                                                  "Failed to upload prescription",
                                            );
                                          }
                                        } catch (e) {
                                          AppSnackBar.showError(
                                            context,
                                            message: "Error: $e",
                                          );
                                        } finally {
                                          if (mounted) {
                                            setState(() => _isLoading = false);
                                          }
                                        }
                                      });
                                    } else {
                                      // No prescription required, just increase quantity
                                      int updatedQty = qty + 1;
                                      // Update UI immediately
                                      cartCon.increaseItem(item.product!.id);
                                      // Mark as updating
                                      cartCon.setUpdatingItem(item.product!.id);
                                      // Sync with backend
                                      await cartCon.addOrUpdateProductInCart(
                                        item.product!.id,
                                        updatedQty,
                                        item.prescriptionUrl,
                                      );
                                      // Mark as done updating
                                      cartCon.clearUpdatingItem();
                                    }
                                  },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primary,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 💰 PRICE WITH LOADING STATE
                    GetBuilder<CartController>(
                      id: item.product!.id,
                      builder: (_) {
                        return isUpdating
                            ? SizedBox(
                                width: 40,
                                height: 16,
                                child: LinearProgressIndicator(
                                  minHeight: 4,
                                  backgroundColor: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              )
                            : Text(
                                "₹${item.lineTotal.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                      },
                    ),
                  ],
                );
              },
            ),
            // GetBuilder<CartController>(
            //   id: item.product!.id,
            //   builder: (c) {
            //     //int qty = c.uiQty[item.product!.id] ?? item.quantity.toInt();
            //     int qty = c.getLocalQuantity(item.product!.id);
            //
            //
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         Container(
            //           height: 40,
            //           decoration: BoxDecoration(
            //             color: AppColors.secondary,
            //             borderRadius: BorderRadius.circular(24),
            //           ),
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               IconButton(
            //                 padding: EdgeInsets.zero,
            //                 constraints: const BoxConstraints(
            //                   minWidth: 40,
            //                   minHeight: 40,
            //                 ),
            //                 icon: CircleAvatar(
            //                   radius: 15,
            //                   backgroundColor:
            //                   AppColors.primary.withValues(alpha: 0.5),
            //                   child: const Icon(Icons.remove,
            //                       color: Colors.white, size: 16),
            //                 ),
            //                 onPressed: () async {
            //                   if (qty <= 1) {
            //                     AppSnackBar.show(context,
            //                         message:
            //                         "You have reached minimum order quantity");
            //                   } else {
            //                     int updatedQty = qty - 1;
            //                     // Update UI immediately
            //                     cartCon.decreaseItem(item.product!.id);
            //                     // Sync with backend in background
            //                     cartCon.addOrUpdateProductInCart(
            //                         item.product!.id, updatedQty,null);
            //                   }
            //                   //cartCon.decreaseItem(item.product!.id);
            //                 },
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 8),
            //                 child: Text(
            //                   qty.toString(),
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 16,
            //                   ),
            //                 ),
            //               ),
            //               IconButton(
            //                 padding: EdgeInsets.zero,
            //                 constraints: const BoxConstraints(
            //                   minWidth: 40,
            //                   minHeight: 40,
            //                 ),
            //                 icon: CircleAvatar(
            //                   radius: 15,
            //                   backgroundColor: AppColors.primary,
            //                   child: const Icon(Icons.add,
            //                       color: Colors.white, size: 16),
            //                 ),
            //                 onPressed: () async {
            //                   setState(() => _isLoading = true);
            //                   if (item.product?.maxOrderQuantity == qty) {
            //                     AppSnackBar.show(context,
            //                         message:
            //                         "You have reached maximum order quantity");
            //                   } else {
            //                     int updatedQty = qty + 1;
            //                     // Update UI immediately
            //                     cartCon.increaseItem(item.product!.id);
            //                     // Sync with backend in background
            //                     cartCon.addOrUpdateProductInCart(
            //                         item.product!.id, updatedQty,item.prescriptionUrl);
            //                     final requiresPrescription = item.product!.isPrescriptionRequired == true;
            //                     if(requiresPrescription){
            //                       // Close loading state before showing dialog
            //                       setState(() => _isLoading = false);
            //
            //                       showPrescriptionDialog(context, (File? image) async {
            //                         if (image != null) {
            //                           setState(() => _isLoading = true);
            //
            //                           try {
            //                             // Upload prescription
            //
            //                             final result = await cartCon
            //                                 .uploadPrescriptionBeforeAddingToCart(
            //                                 image);
            //
            //                             if (result['success'] == true) {
            //                               final prescriptionUrl = result['url'];
            //                               print(
            //                                   'Prescription URL: $prescriptionUrl');
            //
            //                               // Proceed with adding to cart with prescription URL
            //                               cartCon.increaseItem(
            //                                 item.product!.id,
            //                                 requiresPrescription: requiresPrescription,
            //                                 prescriptionUrl: requiresPrescription
            //                                     ? prescriptionUrl
            //                                     : "",
            //                               );
            //                             }
            //                           } catch (e) {
            //                             AppSnackBar.showError(context, message: "Error: $e");
            //                           } finally {
            //                             if (mounted) {
            //                               setState(() => _isLoading = false);
            //                             }
            //                           }
            //                         }
            //                       });
            //                     }
            //                     cartCon.increaseItem(
            //                       item.product!.id,
            //                       requiresPrescription: requiresPrescription,
            //                       prescriptionUrl: ""
            //                     );
            //                   }
            //                 },
            //               ),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         // Text(
            //         //   "₹${(item.unitPrice * qty).toStringAsFixed(2)}",
            //         //   style: const TextStyle(
            //         //     fontWeight: FontWeight.bold,
            //         //     fontSize: 14,
            //         //   ),
            //         // ),
            //         GetBuilder<CartController>(
            //           id: item.product!.id,
            //           builder: (_) {
            //             return Text(
            //               //(cartCon.getLocalQuantity(item.product!.id,)*(item.unitPrice)).toStringAsFixed(2),
            //               item.lineTotal.toStringAsFixed(2)
            //             );
            //           },
            //         ),
            //
            //       ],
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  /// Bottom Container with address and cart calculation
  Widget _buildBottomContainer(
    String category,
    CartGroup cartCalculation,
    List<CartItem> filteredCartItems,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Address Selection - Only rebuilds when address changes
          Obx(() {
            if (addressCtrl.selectedDeliveryAddress.value == null) {
              return _buildAddressSelection();
            } else {
              return _buildSelectedAddress();
            }
          }),

          Divider(height: 1, color: Colors.grey[300]),

          // Bottom Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cart Summary
                Obx(() {
                  if (addressCtrl.selectedDeliveryAddress.value != null) {
                    return _buildCompactSummary(cartCalculation);
                  }
                  return const SizedBox.shrink();
                }),

                // Coupon Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          controller: couponCtrl,
                          decoration: InputDecoration(
                            hintText: "Coupon Code",
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 48,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isCouponLoading
                              ? AppColors.primary.withValues(alpha: 0.6)
                              : AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: _isCouponLoading
                            ? null
                            : () => _applyCoupon(category, cartCalculation),
                        child: _isCouponLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "Apply",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Total and Checkout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          if (cartCon.isCalculating.value) {
                            return Row(
                              children: [
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Calculating...",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            );
                          }

                          final total = getFinalCategoryTotal(
                            category: category,
                            baseTotal: cartCalculation.groupTotal.toDouble(),
                          );
                          return Text(
                            "₹${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      width: 0.50.toWidthPercent(),
                      child: Obx(
                        () => Appbutton(
                          buttonText: cartCon.isCalculating.value
                              ? "Please wait..."
                              : "Checkout",
                          onTap: () {
                            if (filteredCartItems[0].product?.productType ==
                                'food') {
                              if (filteredCartItems.isNotEmpty) {
                                final firstRestaurant =
                                    filteredCartItems[0]?.product?.restaurant;

                                final allSameRestaurant = filteredCartItems
                                    .every(
                                      (item) =>
                                          item?.product?.restaurant ==
                                          firstRestaurant,
                                    );

                                if (allSameRestaurant &&
                                    (firstRestaurant != null &&
                                        firstRestaurant!.isNotEmpty)) {
                                  print(
                                    "printing firstresturenr ${firstRestaurant}",
                                  );
                                  restaturentId = firstRestaurant;

                                  if (cartCon.isCalculating.value) return;
                                  final businessType =
                                      Get.find<BusinessController>()
                                          .businessTypes
                                          .firstWhere(
                                            (b) =>
                                                b.name.capitalizeFirst ==
                                                category, // or b.name == category
                                          );
                                  final userCity = addressCtrl
                                      .selectedDeliveryAddress
                                      .value
                                      ?.city;
                                  // final isServiceAvailable =
                                  //     userCity != null &&
                                  //     .cities.contains(userCity);
                                  //print("business type available ${businessType.name}");
                                  final isServiceAvailable =
                                      (userCity?.isNotEmpty ?? false) &&
                                          businessType.cities.any(
                                                (c) =>
                                            c.city.trim().toLowerCase() ==
                                                userCity!.trim().toLowerCase(),
                                          );

                                  isServiceAvailable
                                      ? Get.to(
                                          () => CheckoutScreen(
                                            restaurentId: restaturentId,
                                            orderTotal: getFinalCategoryTotal(
                                              category: category,
                                              baseTotal: cartCalculation
                                                  .groupTotal
                                                  .toDouble(),
                                            ),
                                            cartItems: filteredCartItems,
                                            checkoutCalculation:
                                                cartCalculation,
                                          ),
                                        )
                                      : AppSnackBar.showInfo(
                                          context,
                                          message:
                                              "Selected delivery address is out of service area",
                                        );
                                } else {
                                  if (allSameRestaurant == false) {
                                    AppSnackBar.showInfo(
                                      context,
                                      message:
                                          "You cannot buy food product from multiple restaurant",
                                    );
                                  } else {
                                    AppSnackBar.showInfo(
                                      context,
                                      message: "Restaurant not found",
                                    );
                                  }
                                  // or throw error / show message
                                }
                              }
                            } else {
                              if (cartCon.isCalculating.value) return;
                              final businessType =
                                  Get.find<BusinessController>().businessTypes
                                      .firstWhere(
                                        (b) =>
                                            b.name.capitalizeFirst ==
                                            category, // or b.name == category
                                      );
                              final userCity = addressCtrl
                                  .selectedDeliveryAddress
                                  .value
                                  ?.city;
                              // final isServiceAvailable =
                              //     userCity != null &&
                              //     businessType.cities.contains(userCity);
                              final isServiceAvailable =
                                  (userCity?.isNotEmpty ?? false) &&
                                      businessType.cities.any(
                                            (c) =>
                                        c.city.trim().toLowerCase() ==
                                            userCity!.trim().toLowerCase(),
                                      );

                              //print("business type available ${businessType.name}");
                              isServiceAvailable
                                  ? Get.to(
                                      () => CheckoutScreen(
                                        restaurentId: restaturentId,
                                        orderTotal: getFinalCategoryTotal(
                                          category: category,
                                          baseTotal: cartCalculation.groupTotal
                                              .toDouble(),
                                        ),
                                        cartItems: filteredCartItems,
                                        checkoutCalculation: cartCalculation,
                                      ),
                                    )
                                  : AppSnackBar.showInfo(
                                      context,
                                      message:
                                          "Selected delivery address is out of service area",
                                    );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSelection() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addressCtrl.usersAddress.length,
              itemBuilder: (context, index) {
                final address = addressCtrl.usersAddress[index];
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  leading: Icon(
                    address.type == "home"
                        ? Icons.home_outlined
                        : Icons.location_city_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  title: Text(
                    address.city ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "${address.street}, ${address.landmark}, ${address.city}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: Icon(
                    Icons.radio_button_unchecked_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onTap: () async {
                    cartCon.isCalculating.value = true;
                    try {
                      addressCtrl.selectedDeliveryAddress.value = address;
                      await cartCon.calculateCheckout(address);
                    } catch (e) {
                      print("Error calculating checkout: $e");
                    } finally {
                      if (mounted) {
                        cartCon.isCalculating.value = false;
                      }
                    }
                  },
                );
              },
            ),

            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(
                Icons.map_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              title: Text(
                "Select from map",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Get.to(
                  () => AddAddressScreen(isFromSelectDeliveryAddress: true),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedAddress() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${addressCtrl.selectedDeliveryAddress.value?.street}, "
                  "${addressCtrl.selectedDeliveryAddress.value?.city}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (!cartCon.isCalculating.value) {
                addressCtrl.selectedDeliveryAddress.value = null;
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Obx(
              () => Text(
                "Change",
                style: TextStyle(
                  fontSize: 12,
                  color: cartCon.isCalculating.value ? Colors.grey : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSummary(CartGroup checkout) {
    return Obx(() {
      if (cartCon.isCalculating.value) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Subtotal: ... • Delivery: ... • Platform: ... ",
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal: ₹${checkout.subtotal} • Delivery: ₹${checkout.deliveryFee} • Platform: ₹${checkout.platformCharges}",
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _applyCoupon(String category, CartGroup cartCalculation) async {
    if (couponCtrl.text.isEmpty) {
      AppSnackBar.showInfo(context, message: "Please enter coupon code");
      return;
    }

    setState(() => _isCouponLoading = true);
    try {
      final userId = await AuthStorage.getUserFromPrefs().then(
        (u) => u?.id ?? "",
      );
      print(
        ""
        "code: ${couponCtrl.text},"
        "userId: $userId,"
        "amount: ${cartCalculation.groupTotal.toDouble()},"
        "categoryType: $category,"
        "",
      );
      await Get.find<CouponController>().redeemCoupon(
        code: couponCtrl.text,
        userId: userId,
        amount: cartCalculation.groupTotal.toDouble(),
        categoryType: category,
      );

      if (mounted) {
        couponCtrl.clear();
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Error applying coupon: $e");
    } finally {
      if (mounted) {
        setState(() => _isCouponLoading = false);
      }
    }
  }

  double getFinalCategoryTotal({
    required String category,
    required double baseTotal,
  }) {
    final couponCtrl = Get.find<CouponController>();

    if (couponCtrl.isCouponForCategory(category)) {
      return couponCtrl.finalAmount.value;
    }
    return baseTotal;
  }

  /// Increase quantity (local only)
}
