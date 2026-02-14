//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/browseProducts/models/services/local_add_to_cart_model.dart';
// import 'package:newdow_customer/features/browseProducts/view/widget/load_products_shimmer.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/controller/restaurentController.dart';
// import 'package:newdow_customer/features/product/controller/productContorller.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
//
// import '../../../widgets/appbar.dart';
// import '../../../widgets/imageHandler.dart';
// import '../../../widgets/snackBar.dart';
// import '../../cart/model/models/cartModel.dart';
// import '../../cart/view/my_cart_screen.dart';
// import '../../product/models/model/ProductModel.dart';
// import '../../product/view/view_product_screen.dart';
// import '../../product/view/widgets/uploadPrescriptionDialog.dart';
// import '../controller/searchController.dart';
//
// class BrowseProductsScreen extends StatefulWidget {
//   final String params;
//   final LoadProductFor loadFor;
//
//   const BrowseProductsScreen({
//     super.key,
//     required this.loadFor,
//     required this.params,
//   });
//
//   @override
//   State<BrowseProductsScreen> createState() => _BrowseProductsScreenState();
// }
//
// class _BrowseProductsScreenState extends State<BrowseProductsScreen> {
//   final productController = Get.find<ProductController>();
//   final cartController = Get.find<CartController>();
//
//
//   late ScrollController _scrollController;
//   final ProductSearchController searchController = Get.put(
//       ProductSearchController());
//   List<ProductModel> products = [];
//   int currentPage = 1;
//   int pageSize = 8;
//   bool isLoading = false;
//   bool hasMoreData = true;
//   bool isInitialLoading = true;
//   bool _isLoading = false;
//   String categoryTitle = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//     productController.syncQuantitiesFromCart();
//     _loadInitialProducts();
//     productController.quantityList.clear();
//     // productController.quantityList.assignAll(
//     //   Map.fromIterable(
//     //     products,
//     //     key: (e) => e.id!,
//     //     value: (_) => e,
//     //   ),
//     // );
//     productController.quantityList.assignAll(
//       Map.fromIterable(
//         products,
//         key: (e) => e.id!,
//         value: (e) => ProductQtyData(
//           quantity: 0,
//           requiresPrescription: e.isPrescriptionRequired ?? false,
//           prescriptionUrl: "",
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//     productController.quantityList.clear();
//   }
//
//   void _onScroll() {
//     // Check if user scrolled to bottom
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       if (hasMoreData && !isLoading) {
//         _loadMoreProducts();
//       }
//     }
//   }
//
//
//   void setTitle() {
//     print("loading for l${widget.loadFor}");
//     print("setting title");
//     if (widget.loadFor == LoadProductFor.fromBusinessType) {
//       if (products.isNotEmpty) {
//         print("In business");
//         setState(() {
//           categoryTitle = products.first.productType == "food"
//               ? "Food Products"
//               : products.first.productType == "grocery"
//               ? "Grocery Products"
//               : "Medicinal Products";
//         });
//       }
//     }
//
//     else if (widget.loadFor == LoadProductFor.fromCategory) {
//       if (products.isNotEmpty) {
//         setState(() {
//           categoryTitle = products.first.category?.name ?? "";
//         });
//       }
//     } else if (widget.loadFor == LoadProductFor.fromSubCategory) {
//       // print("loading for subcategory ${products.first.category?.name}");
//       print("lenftg ${products.length}");
//       if (products.isNotEmpty) {
//         categoryTitle = products.first.subCategory?.name ?? "";
//         print("categroy name $categoryTitle");
//       }
//     }
//     else if (widget.loadFor == LoadProductFor.forRestaurant) {
//       if (products.isNotEmpty) {
//         setState(() {
//           categoryTitle = "Restaurant Items";
//         });
//       }
//     }
//   }
//
//   Future<void> _loadInitialProducts() async {
//     setState(() => isInitialLoading = true);
//     try {
//       final newProducts = await _getProduct(page: 1);
//       setState(() {
//         products = newProducts;
//         currentPage = 1;
//         hasMoreData = newProducts.length >= pageSize;
//         isInitialLoading = false;
//         setTitle();
//       });
//
//       // Update controller's product list for price calculations
//       productController.allProducts.addAll(newProducts);
//     } catch (e) {
//       setState(() => isInitialLoading = false);
//       AppSnackBar.showError(context, message: "Failed to load products");
//     }
//   }
//
//   Future<void> _loadMoreProducts() async {
//     if (isLoading) return;
//
//     setState(() => isLoading = true);
//     try {
//       final newProducts = await _getProduct(page: currentPage + 1);
//
//       setState(() {
//         if (newProducts.isNotEmpty) {
//           products.addAll(newProducts);
//           currentPage++;
//           hasMoreData = newProducts.length >= pageSize;
//
//           // Update controller's product list
//           // productController.quantityList.addAll(
//           //   Map.fromIterable(
//           //     newProducts,
//           //     key: (e) => e.id!,
//           //     value: (_) => 0,
//           //   ),
//           // );
//           productController.quantityList.addAll(
//             Map.fromIterable(
//               newProducts,
//               key: (e) => e.id!,
//               value: (e) => ProductQtyData(
//                 quantity: 0,
//                 requiresPrescription: e.isPrescriptionRequired ?? false,
//                 prescriptionUrl: "",
//               ),
//             ),
//           );
//
//           productController.allProducts.addAll(newProducts);
//         } else {
//           hasMoreData = false;
//         }
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       AppSnackBar.showError(context, message: "Failed to load more products");
//     }
//   }
//
//   Future<void> _onAddToCart(ProductModel product) async {
//     try {
//       for (final entry in productController.quantityList.entries) {
//         final productId = entry.key;
//         final qty = entry.value.quantity;
//
//         if (qty > 0) {
//           productController.increase(productId, qty.toString());
//         }
//       }
//       productController.quantityList.clear();
//       final response = await cartController.syncCartWithBackend();
//       AppSnackBar.showSuccess(context,
//           message: response ? "Cart Updated" : "Failed to update cart");
//
//       // Refresh cart and sync quantities
//       await cartController.fetchCarts();
//       productController.syncQuantitiesFromCart();
//     } catch (e) {
//       AppSnackBar.showError(context, message: "Failed to add to cart");
//     }
//   }
//
//   Future<List<ProductModel>> _getProduct({required int page}) async {
//     switch (widget.loadFor) {
//       case LoadProductFor.fromBusinessType:
//         return await productController.getProductByBusinessType(
//             widget.params, pageSize, page);
//
//       case LoadProductFor.fromCategory:
//         return await productController.getProductByCategory(widget.params);
//
//       case LoadProductFor.fromSubCategory:
//         return await productController.getProductBySubCategory(widget.params);
//
//       case LoadProductFor.forRestaurant:
//         return await Get.find<ResturentController>().getRestaurantItems(widget.params);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           alignment: Alignment.center,
//           height: 0.1.toHeightPercent(),
//
//           child: Row(
//
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Total Price",
//                     style: TextStyle(fontSize: 16, color: Color(0xFFD9D9D9)),),
//                   Obx(() =>
//                       Text(
//                         "\₹${productController.totalPrice.toStringAsFixed(2)}",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w700),))
//                 ],
//               ),
//               InkWell(
//                 onTap: _isLoading ? null : () async {
//                   setState(() => _isLoading = true);
//                    try {
//                   //   for (final entry in productController.quantityList.entries) {
//                   //     final productId = entry.key;
//                   //     var qty = entry.value;
//                   //     print(productId);
//                   //     print(qty.toString());
//                   //     if (qty > 0)  {
//                   //        productController.increase(productId,null);
//                   //
//                   //     }
//                   //     print("Pending items list produts q${cartController.pendingItems[productId]?.quantity.toString()}");
//                   //   }
//                   //   for (final entry in productController.quantityList.entries) {
//                   //     final productId = entry.key;
//                   //     final qty = entry.value;
//                   //
//                   //     if (qty > 0) {
//                   //       cartController.addItemQuantity(productId, qty);
//                   //     }
//                   //
//                   //     print(
//                   //       "Pending cart qty ${cartController.pendingItems[productId]?.quantity}",
//                   //     );
//                   //   }
//                     // for (final entry in productController.quantityList.entries) {
//                     //   final productId = entry.key;
//                     //   final qty = entry.value;
//                     //
//                     //   if (qty > 0) {
//                     //     cartController.addItemQuantity(productId, qty);
//                     //   }
//                     //
//                     //   print(
//                     //     "Pending cart qty ${cartController.pendingItems[productId]?.quantity}",
//                     //   );
//                     // }
//
//
//                     //productController.quantityList.clear();
//
//                     final response = await cartController.syncCartWithBackend();
//                     if (response) {
//                       productController.quantityList.clear();
//                       if (mounted) {
//                         Get.to(CartScreen(
//                           isFromBottamNav: false, selectedCategory: products
//                             .first.productType,));
//                       }
//                     } else {
//                       AppSnackBar.showInfo(
//                           context, message: "Failed to update cart");
//                     }
//                   } catch (e) {
//                     AppSnackBar.showError(context, message: "Error: $e");
//                   } finally {
//                     if (mounted) {
//                       setState(() => _isLoading = false);
//                     }
//                   }
//                 },
//
//                 child: Container(
//                   height: 54,
//                   width: 0.56.toWidthPercent(),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: _isLoading
//                         ? Color(0xff0A9962).withValues(alpha: 0.6)
//                         : Color(0xff0A9962),
//                     borderRadius: BorderRadius.circular(27),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     spacing: 8,
//                     children: [
//                       if (_isLoading)
//                         SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2.5,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white),
//                           ),
//                         )
//                       else
//                         SvgPicture.asset(cart_icon),
//                       Text(
//                         _isLoading ? "Processing..." : "Add to Cart",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SafeArea(
//           top: false,
//           child: Stack(
//             children: [
//               CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   CustomAppBar(isInServiceableArea: true),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           // Initial Loading State
//                           if (isInitialLoading)
//                             Container(
//                               height: 0.7.toHeightPercent(),
//                               width: 1.toWidthPercent(),
//                               child: Center(
//                                 child: ProductGridShimmer(itemCount: 10),
//                               ),
//                             )
//                           else
//                             if (products.isEmpty)
//                               Container(
//                                 height: 0.7.toHeightPercent(),
//                                 width: 1.toWidthPercent(),
//                                 child: const Center(
//                                   child: Text("Product not available"),
//                                 ),
//                               )
//                             else
//                             // Products Grid with Lazy Loading
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     categoryTitle,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   GridView.builder(
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       crossAxisSpacing: 12,
//                                       mainAxisSpacing: 12,
//                                       childAspectRatio: 0.86,
//                                     ),
//                                     itemCount: products.length +
//                                         (hasMoreData ? 1 : 0),
//                                     // Extra item for loader
//                                     itemBuilder: (context, index) {
//                                       // Show loading indicator at the end
//                                       if (index == products.length) {
//                                         return const Center(
//                                           child: CircularProgressIndicator(),
//                                         );
//                                       }
//
//                                       return _ProductCard(
//                                         key: ValueKey(products[index].id),
//                                         product: products[index],
//                                         productController: productController,
//                                         cartController: cartController,
//                                         onAddToCart: () {
//                                           _onAddToCart(products[index]);
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // No more data indicator
//                   if (!hasMoreData && products.isNotEmpty)
//                     const SliverToBoxAdapter(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Center(
//                           // child: Text(
//                           //   "No more products",
//                           //   style: TextStyle(color: Colors.grey),
//                           // ),
//                           child: SizedBox(),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               Obx(() {
//                 if (searchController.searchQuery.isEmpty)
//                   return const SizedBox();
//
//                 if (searchController.isLoading.value) {
//                   return _buildOverlay(
//                     context,
//                     const Center(child: CircularProgressIndicator()),
//                   );
//                 }
//
//                 if (searchController.errorMessage.isNotEmpty) {
//                   return _buildOverlay(
//                     context,
//                     Center(child: Text(searchController.errorMessage.value)),
//                   );
//                 }
//
//                 if (searchController.products.isEmpty) {
//                   return _buildOverlay(
//                     context,
//                     const Center(child: Text('No products found')),
//                   );
//                 }
//
//                 return _buildOverlay(
//                   context,
//                   ListView.separated(
//                     separatorBuilder: (_, __) {
//                       return Divider(
//                         height: 5,
//                         color: AppColors.primary.withValues(alpha: 0.5),
//                       );
//                     },
//                     itemCount: searchController.products.length,
//                     itemBuilder: (context, index) {
//                       final product = searchController.products[index];
//                       return ListTile(
//                         leading: SafeNetworkImage(
//                           url: product.imageUrl
//                               .toString()
//                               .replaceAll(RegExp(r'[\[\]]'), '') ??
//                               "",
//                         ),
//                         title: Text(product.name ?? 'Unnamed Product'),
//                         subtitle: Text(
//                           product.description ?? '',
//                           maxLines: 2,
//                           style: TextStyle(color: AppColors.textSecondary),
//                         ),
//                         onTap: () {
//                           FocusScope.of(context).unfocus();
//                           searchController.searchQuery.value = '';
//                           searchController.products.clear();
//                           Get.to(ViewProductScreen(product: product));
//                         },
//                       );
//                     },
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOverlay(BuildContext context, Widget child) {
//     return Positioned(
//       top: kToolbarHeight + 0.15.toHeightPercent(),
//       left: 2,
//       right: 2,
//       bottom: 0,
//       child: Stack(
//         children: [
//
//           /// optional background blur for elegance
//           Material(
//             color: Colors.white,
//             elevation: 8,
//             child: child,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> onAddToCart(ProductModel product) async {
//     try {
//       final response = await cartController.syncCartWithBackend();
//       AppSnackBar.showSuccess(context,
//           message: response ? "Cart Updated" : "Failed to update cart");
//       await cartController.fetchCarts();
//     } catch (e) {
//       AppSnackBar.showError(context, message: "Failed to add to cart");
//     }
//   }
// }
// /// 🎯 Extracted Product Card - Only rebuilds when product data changes
// class _ProductCard extends StatefulWidget {
//   final ProductModel product;
//   final ProductController productController;
//   final CartController cartController;
//   final VoidCallback onAddToCart;
//
//   const _ProductCard({
//     required Key key,
//     required this.product,
//     required this.productController,
//     required this.cartController,
//     required this.onAddToCart,
//   }) : super(key: key);
//
//   @override
//   State<_ProductCard> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<_ProductCard> {
//   bool _isLoading = false;
//   bool isAddingToCart = false;
//   final productController = Get.find<ProductController>();
//   final cartController = Get.find<CartController>();
//   late RxInt localQty;
//
//   @override
//   void initState() {
//     localQty = 0.obs;
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () =>
//           Get.to(
//             ViewProductScreen(product: widget.product),
//           ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: AppColors.secondary,
//         ),
//         padding: EdgeInsets.all(4),
//         child: Column(
//           children: [
//             // Image Container
//             Container(
//               alignment: Alignment.topCenter,
//               height: 0.128.toHeightPercent(),
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(12),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.background,
//                       ),
//                       child: SafeNetworkImage(
//                         url: (widget.product.imageUrl != null &&
//                             widget.product.imageUrl!.isNotEmpty)
//                             ? widget.product.imageUrl!.first
//                             : "",
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 4,
//                     left: 4,
//                     child: widget.product.isPrescriptionRequired ?? false
//                         ? Positioned(
//                         child: Icon(
//                           Icons.health_and_safety, color: AppColors.primary,))
//                         : SizedBox(),
//                   ),
//                   // Add Button
//                   // Positioned(
//                   //   bottom: -4,
//                   //   right: -7,
//                   //   child: GestureDetector(
//                   //     onTap: isAddingToCart ? null : _addToCartHandler,
//                   //     child: Container(
//                   //       width: 45,
//                   //       height: 45,
//                   //       decoration: BoxDecoration(
//                   //         color: AppColors.secondary,
//                   //         borderRadius: BorderRadius.circular(20),
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //             color: Colors.green.withOpacity(0.3),
//                   //             blurRadius: 8,
//                   //             offset: const Offset(0, 2),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //       child: Center(
//                   //         child: isAddingToCart
//                   //             ? const SizedBox(
//                   //           width: 20,
//                   //           height: 20,
//                   //           child: CircularProgressIndicator(
//                   //             strokeWidth: 2,
//                   //           ),
//                   //         )
//                   //             : const Icon(
//                   //           Icons.add_circle_outlined,
//                   //           color: AppColors.primary,
//                   //           size: 38,
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   /*Positioned(
//                     bottom: -4,
//                     right: 2,
//                     child: Container(
//
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         color: Colors.white.withValues(alpha: 0.3),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(onPressed: () {}, icon: CircleAvatar(child: Icon(Icons.remove,),backgroundColor: AppColors.primary,radius: 15,),),
//                           Text("77",style: TextStyle(fontSize: 16),),
//                           IconButton(onPressed: () {
//                             // if (widget.product.maxOrderQuantity == productController.productQuantity.value) {
//                             //   AppSnackBar.show(context,
//                             //       message:
//                             //       "You have reached maximum order quantity");
//                             // } else {
//                             //   print(widget.product.maxOrderQuantity == productController.productQuantity.value);
//                             //   productController.increaseProductQuantity();
//                             //   print(widget.product.maxOrderQuantity);
//                             //   print(productController.productQuantity);
//                             // }
//
//                           },//productController.increaseProductQuantity() ,
//                               icon: CircleAvatar(child: Icon(Icons.add),radius: 15,)),
//                         ],
//                       ),
//                     )
//                   ),*/
//                   // Positioned(
//                   //   bottom: 2,
//                   //   right: 2,
//                   //   child: Container(
//                   //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.white.withValues(alpha: 0.4),
//                   //       borderRadius: BorderRadius.circular(20),
//                   //     ),
//                   //     child: Row(
//                   //       mainAxisSize: MainAxisSize.min,
//                   //       children: [
//                   //
//                   //         // Minus Button (Smaller)
//                   //         InkWell(
//                   //           onTap: () {
//                   //             productController.decreaseProductQuantity();
//                   //           },
//                   //           child: Container(
//                   //             width: 26,
//                   //             height: 26,
//                   //             decoration: BoxDecoration(
//                   //               color: AppColors.primary,
//                   //               shape: BoxShape.circle,
//                   //             ),
//                   //             child: const Icon(Icons.remove, size: 16, color: Colors.white),
//                   //           ),
//                   //         ),
//                   //
//                   //         const SizedBox(width: 6),
//                   //
//                   //         // Quantity Text
//                   //         /*Obx(() => Text(productController!.productQuantity.toString(),style: TextStyle(fontSize: 18),)),*/
//                   //         Text("1"),
//                   //         const SizedBox(width: 6),
//                   //
//                   //         // Plus Button (Smaller)
//                   //         InkWell(
//                   //           onTap: () {
//                   //             if (widget.product.maxOrderQuantity == productController.productQuantity.value) {
//                   //               AppSnackBar.show(context,
//                   //                   message:
//                   //                   "You have reached maximum order quantity");
//                   //             } else {
//                   //               print(widget.product.maxOrderQuantity == productController.productQuantity.value);
//                   //               productController.increaseProductQuantity();
//                   //               print(widget.product.maxOrderQuantity);
//                   //               print(productController.productQuantity);
//                   //             }
//                   //
//                   //           },
//                   //           child: Container(
//                   //             width: 26,
//                   //             height: 26,
//                   //             decoration: const BoxDecoration(
//                   //               color: AppColors.primary,
//                   //               shape: BoxShape.circle,
//                   //             ),
//                   //             child: const Icon(Icons.add, size: 16, color: Colors.white),
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // )
//                   Positioned(
//                     bottom: 2,
//                     right: 2,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withValues(alpha: 0.3),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       // child: Row(
//                       //   mainAxisSize: MainAxisSize.min,
//                       //   children: [
//                       //     /// ---- MINUS BUTTON ----
//                       //     InkWell(
//                       //       onTap: () {
//                       //         productController.decrease(widget.product.id);
//                       //
//                       //         // optional: update local cart too
//                       //         // cartController.addOrUpdateLocalCartItem(
//                       //         //     widget.product.id,
//                       //         //     productController.getQuantity(widget.product.id)
//                       //         // );
//                       //       },
//                       //       child: Container(
//                       //         width: 26,
//                       //         height: 26,
//                       //         decoration: BoxDecoration(
//                       //           color: AppColors.primary,
//                       //           shape: BoxShape.circle,
//                       //         ),
//                       //         child: const Icon(Icons.remove, size: 16, color: Colors.white),
//                       //       ),
//                       //     ),
//                       //
//                       //     const SizedBox(width: 6),
//                       //
//                       //     /// ---- QUANTITY TEXT ----
//                       //     Obx(() => Text(
//                       //       productController.getQuantity(widget.product.id).toString(),
//                       //       style:  TextStyle(fontSize: 16,color: Colors.white),
//                       //     )),
//                       //
//                       //     const SizedBox(width: 6),
//                       //
//                       //     /// ---- PLUS BUTTON ----
//                       //     InkWell(
//                       //       onTap:  _isLoading ? null :  () async {
//                       //         setState(() => _isLoading = true);
//                       //         if(widget.product.isPrescriptionRequired ?? false){
//                       //           // Close loading state before showing dialog
//                       //           setState(() => _isLoading = false);
//                       //
//                       //           showPrescriptionDialog(context, (File? image) async {
//                       //             if (image != null) {
//                       //               setState(() => _isLoading = true);
//                       //
//                       //               try {
//                       //                 // Upload prescription
//                       //
//                       //                 final result = await cartController.uploadPrescriptionBeforeAddingToCart(image);
//                       //
//                       //                 if (result['success'] == true) {
//                       //                   final prescriptionUrl = result['url'];
//                       //                   print('Prescription URL: $prescriptionUrl');
//                       //
//                       //                   //Proceed with adding to cart with prescription URL
//                       //                   // final response = await cartController.addOrUpdateProductInCart(
//                       //                   //   widget.product.id,
//                       //                   //   productController.getQuantity(widget.product.id),
//                       //                   //   prescriptionUrl, // Pass URL to cart
//                       //                   // );
//                       //                   productController.increase(widget.product.id,prescriptionUrl);
//                       //                   AppSnackBar.showSuccess(
//                       //                     context,
//                       //                     message: result['message'] ?? "Prescription uploaded & cart updated",
//                       //                   );
//                       //
//                       //                   if (mounted) {
//                       //                     Get.to(CartScreen(
//                       //                       isFromBottamNav: false,
//                       //                       selectedCategory: widget.product.productType,
//                       //                     ));
//                       //                   }
//                       //                 } else {
//                       //                   AppSnackBar.showError(
//                       //                     context,
//                       //                     message: result['message'] ?? "Failed to upload prescription",
//                       //                   );
//                       //                 }
//                       //               } catch (e) {
//                       //                 AppSnackBar.showError(context, message: "Error: $e");
//                       //               } finally {
//                       //                 if (mounted) {
//                       //                   setState(() => _isLoading = false);
//                       //                 }
//                       //               }
//                       //             }
//                       //           });
//                       //         }else{
//                       //           int current = productController.getQuantity(widget.product.id);
//                       //           if (current == widget.product.maxOrderQuantity) {
//                       //             AppSnackBar.show(context,
//                       //                 message: "You have reached maximum order quantity");
//                       //           } else {
//                       //             productController.increase(widget.product.id,null);
//                       //
//                       //             // cartController.addOrUpdateLocalCartItem(
//                       //             //     widget.product.id,
//                       //             //     productController.getQuantity(widget.product.id)
//                       //             // );
//                       //           }
//                       //         }
//                       //
//                       //
//                       //
//                       //       },
//                       //       child: Container(
//                       //         width: 26,
//                       //         height: 26,
//                       //         decoration: const BoxDecoration(
//                       //           color: AppColors.primary,
//                       //           shape: BoxShape.circle,
//                       //         ),
//                       //         child: const Icon(Icons.add, size: 16, color: Colors.white),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//
//                           /// ---------------- MINUS BUTTON ----------------
//                           InkWell(
//                             onTap: () {
//                               // if (productController.quantityList[widget.product.id] > 0) {
//                               //   productController.quantityList[widget.product.id]--;
//                               //   cartController.decreaseItem(widget.product.id);
//                               // }
//
//                               // final id = widget.product.id!;
//                               // final currentQty = productController.quantityList[id] ?? 0;
//                               //
//                               // if (currentQty > 0) {
//                               //   productController.quantityList[id] = currentQty - 1;
//                               //   //cartController.decreaseItem(widget.product.id);
//                               // }
//                               final id = widget.product.id!;
//                               final currentData = productController.quantityList[id];
//
//                               if (currentData != null && currentData.quantity > 0) {
//                                 final newQty = currentData.quantity - 1;
//
//                                 if (newQty == 0) {
//                                   // optional: remove product completely
//                                   productController.quantityList.remove(id);
//                                 } else {
//                                   productController.quantityList[id] =
//                                       currentData.copyWith(quantity: newQty);
//                                 }
//
//                                 // cartController.decreaseItem(id);
//                               }
//
//                             },
//                             child: Container(
//                               width: 26,
//                               height: 26,
//                               decoration: BoxDecoration(
//                                 color: AppColors.primary,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                   Icons.remove, size: 16, color: Colors.white),
//                             ),
//                           ),
//
//                           const SizedBox(width: 6),
//
//                           /// ---------------- QUANTITY ----------------
//                           // Obx(() =>
//                           //     Text(
//                           //       productController.quantityList[widget.product.id].value.toString(),
//                           //       // cartController.getLocalQuantity(
//                           //       //     widget.product.id).toString(),
//                           //       style: const TextStyle(
//                           //           fontSize: 16, color: Colors.white),
//                           //     )),
//                           Obx(() {
//                             final qty =
//                                 productController.quantityList[widget.product.id]?.quantity ?? 0;
//
//                             return Text(
//                               qty.toString(),
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             );
//                           }),
//
//
//                           const SizedBox(width: 6),
//
//                           /// ---------------- PLUS BUTTON ----------------
//                           InkWell(
//                             onTap: _isLoading
//                                 ? null
//                                 : () async {
//                               setState(() => _isLoading = true);
//                               final qty =
//                                   productController.quantityList[widget.product.id]?.quantity ?? 0;
//                               if(widget.product.maxOrderQuantity != null && qty  >= widget.product.maxOrderQuantity!) {
//                                 AppSnackBar.showError(context, message: "Maximum order quantity reached");
//                               }else{
//                               /// ---------------- PRESCRIPTION FLOW (UNCHANGED) ----------------
//                               if (widget.product.isPrescriptionRequired ??
//                                   false) {
//                                 setState(() => _isLoading = false);
//
//                                 showPrescriptionDialog(
//                                     context, (File? image) async {
//                                   if (image == null) return;
//
//                                   setState(() => _isLoading = true);
//                                   try {
//                                     final result = await cartController
//                                         .uploadPrescriptionBeforeAddingToCart(
//                                         image);
//
//                                     if (result['success'] == true) {
//                                       final prescriptionUrl = result['url'];
//
//                                       /// ✅ USE CONTROLLER (already implemented)
//                                       // localQty.value++;
//                                       // productController.increase(
//                                       //   widget.product.id,
//                                       //   prescriptionUrl,
//                                       // );
//                                       // final id = widget.product.id!;
//                                       // final currentQty = productController
//                                       //     .quantityList[id] ?? 0;
//                                       //
//                                       //
//                                       // productController.quantityList[id] =
//                                       //     currentQty + 1;
//                                       cartController.updatePrescription(widget.product.id, prescriptionUrl);
//                                       //cartController.increaseItem(widget.product.id);
//
//
//                                       AppSnackBar.showSuccess(
//                                         context,
//                                         message: result['message'] ??
//                                             "Prescription uploaded & added to cart",
//                                       );
//
//                                       if (mounted) {
//                                         // Get.to(
//                                         //   CartScreen(
//                                         //     isFromBottamNav: false,
//                                         //     selectedCategory:
//                                         //     widget.product.productType,
//                                         //   ),
//                                         // );
//                                       }
//                                     } else {
//                                       AppSnackBar.showError(
//                                         context,
//                                         message:
//                                         result['message'] ??
//                                             "Failed to upload prescription",
//                                       );
//                                     }
//                                   } catch (e) {
//                                     AppSnackBar.showError(
//                                       context,
//                                       message: "Error: $e",
//                                     );
//                                   } finally {
//                                     if (mounted) {
//                                       setState(() => _isLoading = false);
//                                     }
//                                   }
//                                 });
//                               }
//
//                               /// ---------------- NORMAL PRODUCT FLOW ----------------
//                               else {
//                                 final current =
//                                 cartController.getLocalQuantity(
//                                     widget.product.id);
//
//                                 if (current ==
//                                     widget.product.maxOrderQuantity) {
//                                   AppSnackBar.show(
//                                     context,
//                                     message:
//                                     "You have reached maximum order quantity",
//                                   );
//                                 } else {
//                                   /// ✅ SIMPLE INCREASE
//                                   //   localQty.value++;
//                                   // cartController.increaseItem(
//                                   //     widget.product.id,
//                                   //     requiresPrescription: false
//                                   // );
//                                   //  final id = widget.product.id!;
//                                   // productController.increaseQty(id);
//                                   // final id = widget.product.id!;
//                                   // final currentQty = productController
//                                   //     .quantityList[id] ?? 0;
//                                   //
//                                   //
//                                   // productController.quantityList[id] =
//                                   //     currentQty + 1;
//                                   //cartController.updatePrescription(widget.product.id, "");
//                                   productController.increaseQtyBrowseProduct(widget.product.id);
//                                   //cartController.increaseItem(widget.product.id);
//                                   // final id = widget.product.id!;
//                                   // final currentQty = productController.quantityList[id] ?? 0;
//                                   //
//                                   // productController.quantityList[id] = currentQty + 1;
//
//                                 }
//                                 setState(() => _isLoading = false);
//                               }
//                             }
//                             },
//                             child: Container(
//                               width: 26,
//                               height: 26,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.primary,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                   Icons.add, size: 16, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       )
//                       ,
//                     ),
//                   )
//
//                 ],
//               ),
//             ),
//             // Product Info
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //
//                   //   children: [
//                   //     Container(
//                   //       width: 0.23.toWidthPercent(),
//                   //       child: Text(
//                   //         widget.product.name ?? "",
//                   //         style: const TextStyle(
//                   //           fontSize: 18,
//                   //           fontWeight: FontWeight.w400,
//                   //         ),
//                   //         maxLines: 1,
//                   //         overflow: TextOverflow.fade,
//                   //       ),
//                   //     ),
//                   //     Spacer(),
//                   //     Container(
//                   //       width: 0.18.toWidthPercent(),
//                   //       child: Text(
//                   //         "${widget.product.weight.toString()} ${widget.product.unit == "liter" ? "lit" : widget.product.unit ?? ""}" ?? "",
//                   //         style: TextStyle(
//                   //           fontSize: 14,
//                   //           color: AppColors.textSecondary,
//                   //         ),
//                   //         maxLines: 1,
//                   //         overflow: TextOverflow.fade,
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           widget.product.name ?? "",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//
//                       SizedBox(width: 08),
//
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           widget.product.productType == "food" ? "${widget.product.servingSize} ${widget.product.unit ==
//                               "liter" ? "lit" : widget.product.unit ?? ""}"
//                               :"${widget.product.quantity} ${widget.product.unit ==
//                               "liter" ? "lit" : widget.product.unit ?? ""}",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary,
//                           ),
//                           maxLines: 1,
//                           textAlign: TextAlign.right,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 4),
//                   Row(
//                     spacing: 12,
//                     children: [
//                       Text(
//                         "₹${widget.product.discountedPrice.toString()}",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         "₹${widget.product.price.toString()}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           decoration: TextDecoration.lineThrough,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/browseProducts/models/services/local_add_to_cart_model.dart';
import 'package:newdow_customer/features/browseProducts/view/widget/load_products_shimmer.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/controller/restaurentController.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/model/restaurentModel.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../utils/isRestaurantOepn.dart';
import '../../../utils/prefs.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/imageHandler.dart';
import '../../../widgets/snackBar.dart';
import '../../cart/model/models/cartItemsModel.dart';
import '../../cart/model/models/cartModel.dart';
import '../../cart/model/services/cart_service.dart';
import '../../cart/view/my_cart_screen.dart';
import '../../product/models/model/ProductModel.dart';
import '../../product/view/view_product_screen.dart';
import '../../product/view/widgets/uploadPrescriptionDialog.dart';
import '../controller/searchController.dart';

/// 🎯 Local Quantity Data Model
class LocalProductQty {
  final String productId;
  int quantity;
  String prescriptionUrl;
  bool requiresPrescription;

  LocalProductQty({
    required this.productId,
    this.quantity = 0,
    this.prescriptionUrl = "",
    this.requiresPrescription = false,
  });

  LocalProductQty copyWith({
    int? quantity,
    String? prescriptionUrl,
    bool? requiresPrescription,
  }) {
    return LocalProductQty(
      productId: productId,
      quantity: quantity ?? this.quantity,
      prescriptionUrl: prescriptionUrl ?? this.prescriptionUrl,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
    );
  }
}

class BrowseProductsScreen extends StatefulWidget {
  final String params;
  final LoadProductFor loadFor;

  const BrowseProductsScreen({
    super.key,
    required this.loadFor,
    required this.params,
  });

  @override
  State<BrowseProductsScreen> createState() => _BrowseProductsScreenState();
}

class _BrowseProductsScreenState extends State<BrowseProductsScreen> {
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  late ScrollController _scrollController;
  final ProductSearchController searchController = Get.put(ProductSearchController());

  List<ProductModel> products = [];

  /// 🎯 Local quantity management (cleared on navigation)
  Map<String, LocalProductQty> localQuantities = {};

  int currentPage = 1;
  int pageSize = 8;
  bool isLoading = false;
  bool hasMoreData = true;
  bool isInitialLoading = true;
  bool _isSyncingCart = false;
  String categoryTitle = "";
  Restaurant? cachedResaturent;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _loadInitialProducts();
      if (widget.loadFor == LoadProductFor.forRestaurant) {
        loadRestaurant();
      }
  }
  Future<void> loadRestaurant() async {
    final res = await Get.find<ResturentController>()
        .getRestaurentById(widget.params);

    setState(() {
      cachedResaturent = res;
    });
  }


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _clearLocalQuantities(); // Clear on screen exit
    super.dispose();
  }

  /// 🧹 Clear all local quantities
  void _clearLocalQuantities() {
    localQuantities.clear();
  }

  /// ➕ Increase quantity locally
  void _increaseQuantityLocally(String productId, {String prescriptionUrl = ""}) {
    setState(() {
      if (localQuantities.containsKey(productId)) {
        final current = localQuantities[productId]!;
        localQuantities[productId] = current.copyWith(
          quantity: current.quantity + 1,
          prescriptionUrl: prescriptionUrl.isNotEmpty ? prescriptionUrl : current.prescriptionUrl,
        );
      } else {
        localQuantities[productId] = LocalProductQty(
          productId: productId,
          quantity: 1,
          prescriptionUrl: prescriptionUrl,
        );
      }
    });
  }

  /// ➖ Decrease quantity locally
  void _decreaseQuantityLocally(String productId) {
    setState(() {
      if (localQuantities.containsKey(productId)) {
        final current = localQuantities[productId]!;
        if (current.quantity > 1) {
          localQuantities[productId] = current.copyWith(quantity: current.quantity - 1);
        } else {
          localQuantities.remove(productId);
        }
      }
    });
  }

  /// 📤 Get local quantity for a product
  int _getLocalQuantity(String productId) {
    return localQuantities[productId]?.quantity ?? 0;
  }

  /// 💾 Update prescription for a product
  void _setPrescriptionUrl(String productId, String url) {
    setState(() {
      if (localQuantities.containsKey(productId)) {
        final current = localQuantities[productId]!;
        localQuantities[productId] = current.copyWith(prescriptionUrl: url);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (hasMoreData && !isLoading) {
        _loadMoreProducts();
      }
    }
  }

  void setTitle() {
    if (widget.loadFor == LoadProductFor.fromBusinessType) {
      if (products.isNotEmpty) {
        setState(() {
          categoryTitle = products.first.productType == "food"
              ? "Food Products"
              : products.first.productType == "grocery"
              ? "Grocery Products"
              : "Medicinal Products";
        });
      }
    } else if (widget.loadFor == LoadProductFor.fromCategory) {
      if (products.isNotEmpty) {
        setState(() {
          categoryTitle = products.first.category?.name ?? "";
        });
      }
    } else if (widget.loadFor == LoadProductFor.fromSubCategory) {
      if (products.isNotEmpty) {
        categoryTitle = products.first.subCategory?.name ?? "";
      }
    } else if (widget.loadFor == LoadProductFor.forRestaurant) {
      if (products.isNotEmpty) {
        setState(() {
          categoryTitle = "Restaurant Items";
        });
      }
    }
  }

  Future<void> _loadInitialProducts() async {
    setState(() => isInitialLoading = true);
    try {
      final newProducts = await _getProduct(page: 1);
      setState(() {
        products = newProducts;
        currentPage = 1;
        hasMoreData = newProducts.length >= pageSize;
        isInitialLoading = false;
        setTitle();
      });
      productController.allProducts.addAll(newProducts);
    } catch (e) {
      setState(() => isInitialLoading = false);
      AppSnackBar.showError(context, message: "Failed to load products");
    }
  }

  Future<void> _loadMoreProducts() async {
    if (isLoading) return;

    setState(() => isLoading = true);
    try {
      final newProducts = await _getProduct(page: currentPage + 1);

      setState(() {
        if (newProducts.isNotEmpty) {
          products.addAll(newProducts);
          currentPage++;
          hasMoreData = newProducts.length >= pageSize;
          productController.allProducts.addAll(newProducts);
        } else {
          hasMoreData = false;
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      AppSnackBar.showError(context, message: "Failed to load more products");
    }
  }

  /// 🛒 Sync local cart to backend
  Future<bool> _syncLocalCartToBackend() async {
    if (localQuantities.isEmpty) {
      AppSnackBar.showInfo(context, message: "Cart is empty");
      return false;
    }

    setState(() => _isSyncingCart = true);


      // Add items to controller for syncing

      // Sync with backend
      // final response = await cartController.syncCartWithBackend();
      try {
        final userId = await AuthStorage.getUserFromPrefs().then((u) =>
        u?.id) ?? "";

        // Convert pending items to list
        //final items = pendingItems.values.toList();
        final items = localQuantities.map((key, value) {
          return MapEntry(
            key,
            CartItems(
              productId: key,
              quantity: value.quantity,
              prescriptionUrl: value.prescriptionUrl,
            ),
          );
        }).values.toList();
        print("syncing items count: ${items.length}");

        bool success = false;

        if (cartController.usersCart.value != UsersCartModel.empty()) {
          // Update existing cart
          success = await cartController.updateCart(
            cartId: cartController.cartList.first.id,
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
          //cartController.pendingItems.clear();

          // ✅ Fetch updated cart from backend
          await cartController.fetchCarts();
          Get.to(CartScreen(isFromBottamNav: false,selectedCategory: products.first.productType,));

        }
        return success;
      } catch (e) {
        print("❌ Sync error: $e");
        return false;
      } finally {
        if (mounted) {
          setState(() => _isSyncingCart = false);
        }
      }
    }


  Future<List<ProductModel>> _getProduct({required int page}) async {
    switch (widget.loadFor) {
      case LoadProductFor.fromBusinessType:
        return await productController.getProductByBusinessType(widget.params, pageSize, page);
      case LoadProductFor.fromCategory:
        return await productController.getProductByCategory(widget.params);
      case LoadProductFor.fromSubCategory:
        return await productController.getProductBySubCategory(widget.params);
      case LoadProductFor.forRestaurant:
        return await Get.find<ResturentController>().getRestaurantItems(widget.params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 0.1.toHeightPercent(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Price",
                    style: TextStyle(fontSize: 16, color: Color(0xFFD9D9D9)),),
                  Text(
                    "₹${_calculateTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              InkWell(
                onTap: _isSyncingCart ? null : _syncLocalCartToBackend,
                child: Container(
                  height: 54,
                  width: 0.56.toWidthPercent(),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _isSyncingCart
                        ? Color(0xff0A9962).withValues(alpha: 0.6)
                        : Color(0xff0A9962),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      if (_isSyncingCart)
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      else
                        SvgPicture.asset(cart_icon),
                      Text(
                        _isSyncingCart ? "Processing..." : "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  CustomAppBar(isInServiceableArea: true),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          if(widget.loadFor == LoadProductFor.forRestaurant && cachedResaturent != null)
                            restaurantHeader(cachedResaturent!),
                          if (isInitialLoading)
                            Container(
                              height: 0.7.toHeightPercent(),
                              width: 1.toWidthPercent(),
                              child: Center(
                                child: ProductGridShimmer(itemCount: 10),
                              ),
                            )
                          else if (products.isEmpty)
                            Container(
                              height: 0.7.toHeightPercent(),
                              width: 1.toWidthPercent(),
                              child: const Center(
                                child: Text("Product not available"),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  categoryTitle,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.86,
                                  ),
                                  itemCount: products.length + (hasMoreData ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == products.length) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return _ProductCard(
                                      key: ValueKey(products[index].id),
                                      product: products[index],
                                      quantity: _getLocalQuantity(products[index].id!),
                                      onQuantityChanged: (delta, prescriptionUrl) {
                                        if (delta > 0) {
                                          _increaseQuantityLocally(
                                            products[index].id!,
                                            prescriptionUrl: prescriptionUrl,
                                          );
                                        } else {
                                          _decreaseQuantityLocally(products[index].id!);
                                        }
                                      },
                                      onPrescriptionSet: (url) {
                                        _setPrescriptionUrl(products[index].id!, url);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!hasMoreData && products.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: SizedBox()),
                      ),
                    ),
                ],
              ),
              Obx(() {
                if (searchController.searchQuery.isEmpty) return const SizedBox();

                if (searchController.isLoading.value) {
                  return _buildOverlay(
                    context,
                    const Center(child: CircularProgressIndicator()),
                  );
                }

                if (searchController.errorMessage.isNotEmpty) {
                  return _buildOverlay(
                    context,
                    Center(child: Text(searchController.errorMessage.value)),
                  );
                }

                if (searchController.products.isEmpty) {
                  return _buildOverlay(
                    context,
                    const Center(child: Text('No products found')),
                  );
                }

                return _buildOverlay(
                  context,
                  ListView.separated(
                    separatorBuilder: (_, __) {
                      return Divider(
                        height: 5,
                        color: AppColors.primary.withValues(alpha: 0.5),
                      );
                    },
                    itemCount: searchController.products.length,
                    itemBuilder: (context, index) {
                      final product = searchController.products[index];
                      return ListTile(
                        leading: SafeNetworkImage(
                          url: product.imageUrl.toString().replaceAll(RegExp(r'[\[\]]'), '') ?? "",
                        ),
                        title: Text(product.name ?? 'Unnamed Product'),
                        subtitle: Text(
                          product.description ?? '',
                          maxLines: 2,
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          searchController.searchQuery.value = '';
                          searchController.products.clear();
                          Get.to(ViewProductScreen(product: product));
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget restaurantHeader(Restaurant restaurant) {

          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Container
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          restaurant.coverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Restaurant Info
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Name with Type Badge
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.secondary,
                            backgroundImage: NetworkImage(restaurant.logo),
                          ),
                          SizedBox(width: 0.02.toWidthPercent()),
                          Expanded(
                            child: Text(
                              restaurant.name ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // Type Badge with Color
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getRestaurantTypeColor(restaurant),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              restaurant.restaurantType ?? 'Mixed',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (restaurant.restaurantType?.toLowerCase() ==
                                    'mixed' ||
                                    restaurant.restaurantType?.toLowerCase() ==
                                        'mixed veg')
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Open/Closed Status
                      Text(
                        isRestaurantOpen(
                          weeklyOffDay: restaurant.weeklyOffDay,
                          startTime: restaurant.workingHours.start,
                          endTime: restaurant.workingHours.end,
                        )
                            ? 'Open Now'
                            : 'Closed Now',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isRestaurantOpen(
                            weeklyOffDay: restaurant.weeklyOffDay,
                            startTime: restaurant.workingHours.start,
                            endTime: restaurant.workingHours.end,
                          )
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Cuisines Row
                      Text(
                        'Cuisines: ${restaurant.cuisineTypes.isNotEmpty ? restaurant.cuisineTypes.join(', ') : 'N/A'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Address
                      Text(
                        'Address: ${restaurant.address ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
          ]),
          )
    ]
    )
    );
  }
  Color getRestaurantTypeColor(Restaurant restaurant) {
    switch (restaurant.restaurantType?.toLowerCase()) {
      case 'veg':
      case 'vegetarian':
        return Colors.green;
      case 'non-veg':
      case 'non-vegetarian':
        return Colors.red;
      case 'mixed':
        return Colors.yellow[700] ?? Colors.yellow;
      default:
        return Colors.grey;
    }
  }
  double _calculateTotalPrice() {
    double total = 0;
    for (final entry in localQuantities.entries) {
      final product = products.firstWhereOrNull((p) => p.id == entry.key);
      if (product != null) {
        total += (product.discountedPrice ?? 0) * entry.value.quantity;
      }
    }
    return total;
  }

  Widget _buildOverlay(BuildContext context, Widget child) {
    return Positioned(
      top: kToolbarHeight + 0.15.toHeightPercent(),
      left: 2,
      right: 2,
      bottom: 0,
      child: Material(
        color: Colors.white,
        elevation: 8,
        child: child,
      ),
    );
  }
}

/// 🎯 Extracted Product Card
class _ProductCard extends StatefulWidget {
  final ProductModel product;
  final int quantity;
  final Function(int delta, String prescriptionUrl) onQuantityChanged;
  final Function(String url) onPrescriptionSet;

  const _ProductCard({
    required Key key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onPrescriptionSet,
  }) : super(key: key);

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ViewProductScreen(product: widget.product,qty: widget.quantity,)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.secondary,
        ),
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            // Image Container
            Container(
              alignment: Alignment.topCenter,
              height: 0.128.toHeightPercent(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.background),
                      child: SafeNetworkImage(
                        url: (widget.product.imageUrl != null && widget.product.imageUrl!.isNotEmpty)
                            ? widget.product.imageUrl!.first
                            : "",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: widget.product.isPrescriptionRequired ?? false
                        ? Icon(Icons.health_and_safety, color: AppColors.primary)
                        : SizedBox(),
                  ),
                  // Quantity Controls
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Minus Button
                          InkWell(
                            onTap: widget.quantity > 0
                                ? () => widget.onQuantityChanged(-1, "")
                                : null,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.remove, size: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Quantity Text
                          Text(
                            widget.quantity.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          // Plus Button
                          InkWell(
                            onTap: _isLoading ? null : () => _onPlusButtonTap(),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : const Icon(Icons.add, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.name ?? "",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.product.productType == "food"
                              ? "${widget.product.servingSize} ${widget.product.unit == "liter" ? "lit" : widget.product.unit ?? ""}"
                              : "${widget.product.quantity} ${widget.product.unit == "liter" ? "lit" : widget.product.unit ?? ""}",
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    spacing: 12,
                    children: [
                      Text(
                        "₹${widget.product.discountedPrice.toString()}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${widget.product.price.toString()}",
                        style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPlusButtonTap() async {
    setState(() => _isLoading = true);

    try {
      if (widget.product.isPrescriptionRequired ?? false) {
        setState(() => _isLoading = false);

        showPrescriptionDialog(context, (File? image) async {
          if (image == null) return;

          setState(() => _isLoading = true);
          try {
            final cartController = Get.find<CartController>();
            final result = await cartController.uploadPrescriptionBeforeAddingToCart(image);

            if (result['success'] == true) {
              final prescriptionUrl = result['url'];
              widget.onPrescriptionSet(prescriptionUrl);
              widget.onQuantityChanged(1, prescriptionUrl);

              AppSnackBar.showSuccess(
                context,
                message: result['message'] ?? "Prescription uploaded & added to cart",
              );
            } else {
              AppSnackBar.showError(
                context,
                message: result['message'] ?? "Failed to upload prescription",
              );
            }
          } catch (e) {
            AppSnackBar.showError(context, message: "Error: $e");
          } finally {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          }
        });
      } else {
        if (widget.quantity >= (widget.product.maxOrderQuantity ?? 999)) {
          AppSnackBar.showError(context, message: "Maximum order quantity reached");
        } else {
          widget.onQuantityChanged(1, "");
        }
        setState(() => _isLoading = false);
      }
    } catch (e) {
      AppSnackBar.showError(context, message: "Error: $e");
      setState(() => _isLoading = false);
    }
  }

}