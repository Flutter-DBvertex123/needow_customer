// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
// import '../../../../../../widgets/appbar.dart';
// import '../../../../../../widgets/imageHandler.dart';
// // import '../../controller/restaurentController.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/features/browseProducts/view/widget/load_products_shimmer.dart';
//
// import '../../restaurent/controller/restaurentController.dart';
// import '../../restaurent/model/restaurentItemModel.dart';
//
// // import '../../model/restaurentItemModel.dart';
//
// class BrowseRestaurentItems extends StatefulWidget {
//   final String restaurentId;
//
//   BrowseRestaurentItems({
//     required this.restaurentId,
//     super.key,
//   });
//
//   @override
//   State<BrowseRestaurentItems> createState() => _BrowseRestaurentItemsState();
// }
//
// class _BrowseRestaurentItemsState extends State<BrowseRestaurentItems> {
//   final cartController = Get.find<CartController>();
//   final ResturentController restController = Get.find<ResturentController>();
//
//   late ScrollController _scrollController;
//
//   List<ProductModel> items = [];
//
//   int currentPage = 1;
//   int pageSize = 10;
//   bool isLoading = false;
//   bool hasMoreData = true;
//   bool isInitialLoading = true;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//
//     _loadInitialItems();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       if (hasMoreData && !isLoading) {
//         _loadMoreItems();
//       }
//     }
//   }
//
//   Future<void> _loadInitialItems() async {
//     setState(() => isInitialLoading = true);
//
//     try {
//       final newItems = await restController.getRestaurantItems(
//         widget.restaurentId,
//         //1
//         //pageSize,
//       );
//
//       setState(() {
//         items = newItems;
//         currentPage = 1;
//         hasMoreData = newItems.length >= pageSize;
//         isInitialLoading = false;
//       });
//     } catch (e) {
//       setState(() => isInitialLoading = false);
//     }
//   }
//
//   Future<void> _loadMoreItems() async {
//     if (isLoading) return;
//
//     setState(() => isLoading = true);
//
//     try {
//       final newItems = await restController.getRestaurantItems(
//         widget.restaurentId,
//         //currentPage + 1,
//         //pageSize,
//       );
//
//       setState(() {
//         if (newItems.isNotEmpty) {
//           items.addAll(newItems);
//           currentPage++;
//           hasMoreData = newItems.length >= pageSize;
//         } else {
//           hasMoreData = false;
//         }
//       });
//     } catch (e) {} finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         bottomNavigationBar: _buildBottomBar(),
//         body: SafeArea(
//           top: false,
//           child: Stack(
//             children: [
//               CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   CustomAppBar(),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: isInitialLoading
//                           ? SizedBox(
//                         height: 0.7.toHeightPercent(),
//                         child: ProductGridShimmer(itemCount: 10),
//                       )
//                           : items.isEmpty
//                           ? SizedBox(
//                         height: 0.7.toHeightPercent(),
//                         child: Center(
//                             child: Text("No items available")),
//                       )
//                           : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Restaurant Items",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold)),
//                           GridView.builder(
//                             physics:
//                             const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                               childAspectRatio: 0.86,
//                             ),
//                             itemCount: items.length +
//                                 (hasMoreData ? 1 : 0),
//                             itemBuilder: (context, index) {
//                               if (index == items.length) {
//                                 return Center(
//                                     child:
//                                     CircularProgressIndicator());
//                               }
//
//                               return _RestaurantItemCard(
//                                 item: items[index],
//                                 cartController: cartController,
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFF9F9F9),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
//         ],
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       height: 0.1.toHeightPercent(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Obx(() => Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Text("Total Price",
//           //         style:
//           //         TextStyle(fontSize: 16, color: Color(0xFFD9D9D9))),
//           //     // Text("₹${cartController.totalPrice.value.toStringAsFixed(2)}",
//           //     //     style:
//           //     //     TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
//           //   ],
//           // )),
//               Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Total Price",
//                   style:
//                   TextStyle(fontSize: 16, color: Color(0xFFD9D9D9))),
//               // Text("₹${cartController.totalPrice.value.toStringAsFixed(2)}",
//               //     style:
//               //     TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
//             ],
//           ),
//           InkWell(
//             onTap: () async {
//               setState(() => _isLoading = true);
//               await cartController.syncCartWithBackend();
//               setState(() => _isLoading = false);
//             },
//             child: Container(
//               height: 54,
//               width: 0.56.toWidthPercent(),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Color(0xff0A9962),
//                 borderRadius: BorderRadius.circular(27),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 spacing: 8,
//                 children: [
//                   _isLoading
//                       ? SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2.5,
//                       valueColor:
//                       AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                       : SvgPicture.asset(cart_icon),
//                   Text(
//                     _isLoading ? "Processing..." : "Add to Cart",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _RestaurantItemCard extends StatelessWidget {
//   final ProductModel item;
//   final CartController cartController;
//
//   const _RestaurantItemCard({
//     super.key,
//     required this.item,
//     required this.cartController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: AppColors.secondary,
//       ),
//       padding: EdgeInsets.all(4),
//       child: Column(
//         children: [
//           Expanded(
//             child: SafeNetworkImage(url: item.imageUrl?[0] ?? ""),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(/*"item.name"*/item.name ?? "",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
//                 SizedBox(height: 4),
//                 Text(/*"₹{item.price}"*/item?.price?.toStringAsFixed(2) ?? "",
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import '../../../../../../widgets/appbar.dart';
import '../../../../../../widgets/imageHandler.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/features/browseProducts/view/widget/load_products_shimmer.dart';
import '../../../../../widgets/snackBar.dart';
import '../../../../product/view/view_product_screen.dart';
import '../../../../product/view/widgets/uploadPrescriptionDialog.dart';
import '../../restaurent/controller/restaurentController.dart';
import '../../restaurent/model/restaurentItemModel.dart';


class BrowseRestaurentItems extends StatefulWidget {
  final String restaurentId;

  BrowseRestaurentItems({
    required this.restaurentId,
    super.key,
  });

  @override
  State<BrowseRestaurentItems> createState() => _BrowseRestaurentItemsState();
}

class _BrowseRestaurentItemsState extends State<BrowseRestaurentItems> {
  final cartController = Get.find<CartController>();
  final ResturentController restController = Get.find<ResturentController>();

  late ScrollController _scrollController;

  List<ProductModel> items = [];

  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool hasMoreData = true;
  bool isInitialLoading = true;
  bool _isLoading = false;
  String restaurantName = "Restaurant Items";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _loadInitialItems();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (hasMoreData && !isLoading) {
        _loadMoreItems();
      }
    }
  }

  Future<void> _loadInitialItems() async {
    setState(() => isInitialLoading = true);

    try {
      final response = await restController.getRestaurantItems(
        widget.restaurentId,
      );

      // Convert List<dynamic> to List<ProductModel>
      List<ProductModel> newItems = [];
      if (response is List) {
        newItems = response
            .map((item) => item is ProductModel
            ? item
            : ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      print('DEBUG: Loaded ${newItems.length} items');

      setState(() {
        items = newItems;
        currentPage = 1;
        hasMoreData = newItems.length >= pageSize;
        isInitialLoading = false;
        if (newItems.isNotEmpty) {
          restaurantName = newItems.first.name ?? "Restaurant Items";
        }
      });
    } catch (e) {
      print('DEBUG: Error loading items: $e');
      setState(() => isInitialLoading = false);

      if (mounted) {
        AppSnackBar.showError(context, message: 'Failed to load items: $e');
      }
    }
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final response = await restController.getRestaurantItems(
        widget.restaurentId,
      );

      // Convert List<dynamic> to List<ProductModel>
      List<ProductModel> newItems = [];
      if (response is List) {
        newItems = response
            .map((item) => item is ProductModel
            ? item
            : ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      setState(() {
        if (newItems.isNotEmpty) {
          items.addAll(newItems);
          currentPage++;
          hasMoreData = newItems.length >= pageSize;
        } else {
          hasMoreData = false;
        }
      });
    } catch (e) {
      print('DEBUG: Error loading more items: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _onAddToCart(ProductModel product) async {
    try {
      final response = await cartController.syncCartWithBackend();
      AppSnackBar.showSuccess(context,
          message: response ? "Cart Updated" : "Failed to update cart");

      await cartController.fetchCarts();
    } catch (e) {
      AppSnackBar.showError(context, message: "Failed to add to cart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        //bottomNavigationBar: _buildBottomBar(),
        bottomNavigationBar:(items.isEmpty && Get.find<ProductController>().totalPrice.isLowerThan(1))? null : _buildBottomBar(),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  CustomAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: isInitialLoading
                          ? SizedBox(
                        height: 0.7.toHeightPercent(),
                        child: ProductGridShimmer(itemCount: 10),
                      )
                          : items.isEmpty
                          ? SizedBox(
                        height: 0.7.toHeightPercent(),
                        child: Center(
                          child: Text("No items available"),
                        ),
                      )
                          : Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          GridView.builder(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.86,
                            ),
                            itemCount: items.length +
                                (hasMoreData && isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == items.length) {
                                return Center(
                                  child:
                                  CircularProgressIndicator(),
                                );
                              }

                              return _RestaurantItemCard(
                                key: ValueKey(items[index].id),
                                item: items[index],
                                cartController: cartController,
                                onAddToCart: () {
                                  _onAddToCart(items[index]);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!hasMoreData && items.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: SizedBox(),
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
  }

  Widget _buildBottomBar() {
    return Container(
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
              Text(
                "Total Price",
                style: TextStyle(fontSize: 16, color: Color(0xFFD9D9D9)),
              ),
              Obx(() => Text(
                "₹${Get.find<ProductController>().totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ))
            ],
          ),
          InkWell(
            onTap: _isLoading
                ? null
                : () async {
              setState(() => _isLoading = true);
              try {
                final response =
                await cartController.syncCartWithBackend();
                if (response) {
                  AppSnackBar.showSuccess(context,
                      message: "Added to cart successfully");
                } else {
                  AppSnackBar.showError(context,
                      message: "Failed to add to cart");
                }
              } catch (e) {
                AppSnackBar.showError(context, message: "Error: $e");
              } finally {
                if (mounted) {
                  setState(() => _isLoading = false);
                }
              }
            },
            child: Container(
              height: 54,
              width: 0.56.toWidthPercent(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isLoading
                    ? Color(0xff0A9962).withValues(alpha: 0.6)
                    : Color(0xff0A9962),
                borderRadius: BorderRadius.circular(27),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  if (_isLoading)
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    SvgPicture.asset(cart_icon),
                  Text(
                    _isLoading ? "Processing..." : "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RestaurantItemCard extends StatefulWidget {
  final ProductModel item;
  final CartController cartController;
  final VoidCallback onAddToCart;

  const _RestaurantItemCard({
    required Key key,
    required this.item,
    required this.cartController,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<_RestaurantItemCard> createState() => _RestaurantItemCardState();
}

class _RestaurantItemCardState extends State<_RestaurantItemCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        ViewProductScreen(
          product: widget.item,
          qty: widget.cartController.getLocalQuantity(widget.item.id),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.secondary,
        ),
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            // Product Image
            Container(
              alignment: Alignment.topCenter,
              height: 0.128.toHeightPercent(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Container(
                      decoration:
                      BoxDecoration(color: AppColors.background),
                      child: SafeNetworkImage(
                        url: (widget.item.imageUrl != null &&
                            widget.item.imageUrl!.isNotEmpty)
                            ? widget.item.imageUrl!.first
                            : "",
                      ),
                    ),
                  ),
                  // Prescription Badge
                  if (widget.item.isPrescriptionRequired ?? false)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Icon(
                        Icons.health_and_safety,
                        color: AppColors.primary,
                      ),
                    ),
                  // ✅ QUANTITY CONTROLS
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GetBuilder<CartController>(
                      id: widget.item.id,
                      builder: (cartCtrl) {
                        final qty =
                        cartCtrl.getLocalQuantity(widget.item.id);

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // MINUS BUTTON
                              InkWell(
                                onTap: () {
                                  if (qty > 0) {
                                    cartCtrl.decreaseItem(widget.item.id);
                                  }
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 6),

                              // QUANTITY TEXT
                              Text(
                                qty.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 6),

                              // PLUS BUTTON
                              InkWell(
                                onTap: _isLoading
                                    ? null
                                    : () async {
                                  // Handle prescription products
                                  if (widget.item
                                      .isPrescriptionRequired ??
                                      false) {
                                    setState(
                                            () => _isLoading = false);

                                    showPrescriptionDialog(
                                      context,
                                          (File? image) async {
                                        if (image == null) return;

                                        setState(
                                                () => _isLoading = true);

                                        try {
                                          final result = await cartCtrl
                                              .uploadPrescriptionBeforeAddingToCart(
                                              image);

                                          if (result['success'] ==
                                              true) {
                                            final prescriptionUrl =
                                            result['url'];

                                            cartCtrl.increaseItem(
                                              widget.item.id,
                                              requiresPrescription:
                                              true,
                                              prescriptionUrl:
                                              prescriptionUrl,
                                            );

                                            AppSnackBar.showSuccess(
                                              context,
                                              message: result[
                                              'message'] ??
                                                  "Prescription uploaded",
                                            );
                                          } else {
                                            AppSnackBar.showError(
                                              context,
                                              message: result[
                                              'message'] ??
                                                  "Upload failed",
                                            );
                                          }
                                        } catch (e) {
                                          AppSnackBar.showError(
                                            context,
                                            message: "Error: $e",
                                          );
                                        } finally {
                                          if (mounted) {
                                            setState(() =>
                                            _isLoading = false);
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    // Normal product
                                    final current = cartCtrl
                                        .getLocalQuantity(
                                        widget.item.id);

                                    if (current ==
                                        widget.item
                                            .maxOrderQuantity) {
                                      AppSnackBar.show(
                                        context,
                                        message:
                                        "Maximum order quantity reached",
                                      );
                                    } else {
                                      cartCtrl.increaseItem(
                                        widget.item.id,
                                        requiresPrescription:
                                        false,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
                          widget.item.name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${widget.item.weight} ${widget.item.unit == "liter" ? "lit" : widget.item.unit ?? ""}",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
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
                        "₹${widget.item.discountedPrice?.toStringAsFixed(2) ?? widget.item.price?.toStringAsFixed(2) ?? "0.00"}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.item.price != null &&
                          widget.item.discountedPrice != null)
                        Text(
                          "₹${widget.item.price?.toStringAsFixed(2) ?? "0.00"}",
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
}