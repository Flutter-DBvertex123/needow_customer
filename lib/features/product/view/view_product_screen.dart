import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
import 'package:newdow_customer/features/cart/view/my_cart_screen.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/controller/fillterAllRestaurntScreenController.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/controller/restaurentController.dart';
import 'package:newdow_customer/features/home/model/models/categoryAndSubCategoryModel.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/features/product/view/widgets/uploadPrescriptionDialog.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/app_services/ShareProduct.dart';
import '../../../utils/apptheme.dart';
import '../../../widgets/appbutton.dart';
import '../../address/model/addressModel.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/model/models/cartModel.dart';
import '../../home/controller/categoryAndSubcategoryController.dart';

class ViewProductScreen extends StatefulWidget {
  final ProductModel product;
  final int? qty;
  ViewProductScreen({super.key, required this.product, this.qty});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final productController = Get.find<ProductController>();

  final cartController = Get.find<CartController>();
  late RxInt localQty;

  final subCategoryProductCon  = Get.find<ProductController>();
  // Add this to your State class
  bool _isLoading = false;
RxDouble addOnTotalPrice = 0.0.obs;
  @override
  void activate() {
    // TODO: implement activate
    //localQty = 1.obs;
    super.activate();
  }
  @override
  void initState() {
    // final item = cartController.cartList
    //     .expand((cart) => cart.items)
    //     .firstWhere(
    //       (item) => item.product?.id == widget.product.id,
    //   orElse: () => CartItem.empty()
    // );

    final item = cartController.cartList.firstWhere((item) => item.product?.id == widget.product.id,orElse: () => CartItem.empty());
    //productController.productQuantity.value = (item.quantity == 0 ? 1 : item.quantity).toInt();
    //productController.increase(widget.product.id);
    //productController.productQuantity.value = 1;
    //cartController.addOrUpdateLocalCartItem(widget.product.id,productController.productQuantity.value = (item.quantity == 0 ? 1 : item.quantity).toInt() );
    final cartQty =
    Get.find<ProductController>().getQuantity(widget.product.id);


    // 👇 KEY LOGIC
    //localQty = (cartQty > 0 ? cartQty : 1).obs;
    //localQty.value = ((widget.qty != null && widget.qty != 0) ? widget.qty  : 1)!;
    localQty = RxInt(
        (widget.qty != null && widget.qty! > 0)
            ? widget.qty!
            :  1
    );
    //localQty = 1.obs;
    /* if (!cartController.cartList.any(
            (e) => e.product?.id == widget.product.id  )) {
      productController.increase(widget.product.id, null);
    }*/

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // print("add on ${widget.product.addons?.first.qty ?? "no addons"}");
    print("restaurent name ${widget.product.restaurant} ??");
    //localQty.value = ((widget.qty != null && widget.qty != 0) ? widget.qty  : 1)!;
    return SafeArea(
      top: false,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.background,
        //   automaticallyImplyLeading: false,
        //   surfaceTintColor: AppColors.background,
        //
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: CircleAvatar(
        //           backgroundColor: AppColors.secondary,
        //           radius: 20,
        //           child: Icon(
        //             Icons.arrow_back_sharp,
        //             color: Colors.green,
        //             size: 25,
        //             weight: 800,
        //           ),
        //         ),
        //       ),
        //       Container(
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             IconButton(
        //                 onPressed: (){},
        //                 icon: CircleAvatar(
        //                     backgroundColor: AppColors.secondary,
        //                     radius: 20,
        //                     child: Icon(Icons.favorite_border,color: AppColors.primary,)
        //                 )
        //             ),
        //             IconButton(
        //                 onPressed: (){},
        //                 icon: CircleAvatar(
        //                   backgroundColor: AppColors.secondary,
        //                   radius: 20,
        //                   child: Icon(Icons.share_outlined,
        //                     color: AppColors.primary,),
        //                 )
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
          alignment: Alignment.center,
          height: 0.1.toHeightPercent(),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Total Price",style: TextStyle(fontSize: 16,color: Color(0xFFD9D9D9)),),
              //     Obx(() => Text(
              //       "₹${productController.totalPrice.toStringAsFixed(2)}",
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              //     ))
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Price", style: TextStyle(fontSize: 16, color: Color(0xFFD9D9D9))),
                  // Obx(() => Text(
                  //   //"₹${productController.getSingleProductPrice(widget.product, productController.productQuantity.value).toStringAsFixed(2)}",
                  //   "₹${(productController.getSingleProductPrice(widget.product, (productController.getQuantity(widget.product.id) == 0) ? (productController.getQuantity(widget.product.id)+1) : productController.getQuantity(widget.product.id),)).toStringAsFixed(2)}",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  // ))
                  Obx(() => Text(
                    //"₹${productController.getSingleProductPrice(widget.product, productController.productQuantity.value).toStringAsFixed(2)}",
                    "₹${(productController.getSingleProductPrice(widget.product,  localQty.value)+addOnTotalPrice.value).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ))
                ],
              ),
              InkWell(
                onTap: _isLoading ? null : () async {
                  setState(() => _isLoading = true);
                  try {
                    print(
                        "add on total price :- ${widget.product.addons
                            ?.map((e) => e.price * e.setQty.value)
                            .fold(0.0, (prev, element) => prev + element)}"
                    );
                    print("data");
                    // for (int i = 0; i < localQty.value; i++) {
                    //   //productController.increase(widget.product.id, null);
                    //   //localQty++;
                    // }
                    print("data");
                    if(widget.product.isPrescriptionRequired ?? false){
                      // Close loading state before showing dialog
                      setState(() => _isLoading = false);

                      showPrescriptionDialog(context, (File? image) async {
                        if (image != null) {
                          setState(() => _isLoading = true);

                          try {
                            // Upload prescription

                            final result = await cartController.uploadPrescriptionBeforeAddingToCart(image);
                            print('Upload Result: $result');
                            if (result['success'] == true) {
                              final prescriptionUrl = result['url'];
                              print('Prescription URL: $prescriptionUrl');

                              print(
                                  "add on total price :- ${widget.product.addons
                                      ?.map((e) => e.price * e.setQty.value)
                                      .fold(0.0, (prev, element) => prev + element)}"
                              );
                              // Proceed with adding to cart with prescription URL
                              final response = await cartController.addOrUpdateProductInCart(
                                widget.product.id,
                                //productController.getQuantity(widget.product.id),
                                localQty.value,
                                prescriptionUrl, // Pass URL to cart
                              );
                              AppSnackBar.showSuccess(
                                context,
                                message: result['message'] ?? "Prescription uploaded & cart updated",
                              );
                              response ? localQty.value = 1 : localQty.value;
                              if (mounted) {
                                Get.to(CartScreen(
                                  isFromBottamNav: false,
                                  selectedCategory: widget.product.productType,
                                ));
                              }
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
                        }
                      });
                    } else {
                      // No prescription required - proceed normally
                      final response = await cartController.addOrUpdateProductInCart(
                          widget.product.id,
                          //productController.getQuantity(widget.product.id),
                          localQty.value,
                          null
                      );
                      response ? localQty.value = 1 : localQty.value;
                      AppSnackBar.showSuccess(
                          context,
                          message: response ? "Cart Updated" : "Failed to update cart"
                      );

                      if (mounted) {
                        Get.to(CartScreen(
                          isFromBottamNav: false,
                          selectedCategory: widget.product.productType,
                        ));
                      }
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
                    color: _isLoading ? Color(0xff0A9962).withValues(alpha: 0.6) : Color(0xff0A9962),
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
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 16,),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.secondary
                  ),
                  height: 0.45.toHeightPercent(),
                  width: 1.toWidthPercent(),
                  //padding: EdgeInsets.symmetric(vertical: 40,horizontal: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      SafeNetworkImage(url: (widget.product.imageUrl != null && widget.product.imageUrl!.isNotEmpty) ? widget.product.imageUrl![0] : "" ),
                      Positioned(
                        top: 30,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: CircleAvatar(
                                backgroundColor: AppColors.secondary,
                                radius: 20,
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  color: AppColors.primary,
                                  size: 25,
                                  weight: 800,
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // IconButton(
                                  //     onPressed: (){},
                                  //     icon: CircleAvatar(
                                  //         backgroundColor: AppColors.secondary,
                                  //         radius: 20,
                                  //         child: Icon(Icons.favorite_border,color: AppColors.primary,)
                                  //     )
                                  // ),
                                  IconButton(
                                      onPressed: (){
                                        ReferralShareService.shareProduct(
                                          productId: widget.product.id!,
                                        );
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: AppColors.secondary,
                                        radius: 20,
                                        child: Icon(Icons.share_outlined,
                                          color: AppColors.primary,),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.product.name} """,style: TextStyle(fontSize: 18),),

                        widget.product.productType == "food" ? Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: widget.product.isVeg ?? true ? Color(0xFFC8FACC) : Color(0xFFFFC8C8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.product.isVeg ?? true ? "Veg" : "Non-Veg",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (widget.product.isVeg ?? true )
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 0.004.toWidthPercent(),),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE5B4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "Spicy : ${widget.product.spiceLevel ?? "N/A"}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (widget.product.isVeg ?? true )
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ) : SizedBox.shrink(),
                      ],
                    ),
                    widget.product.restaurant != null ? Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            widget.product.restaurant?.logo ?? "",
                          ),),
                        SizedBox(width: 8,),
                        Text("${widget.product.restaurant?.name ?? "Unknown Restaurant"} """ ,
                          style: TextStyle( fontSize: 16,
                            color: Colors.black.withOpacity(0.3),),),
                      ],
                    ) : SizedBox.shrink(),
                    widget.product.preparationTime != null ? Text("Preparation Time: ${widget.product.preparationTime} mins",
                      style: TextStyle( fontSize: 16,
                        color: Colors.black.withOpacity(0.3),),) : SizedBox.shrink(),
                    //SizedBox(height: 8,),
                    _buildProductRatingWidget(widget.product.rating!.toInt()),
                    //Text("Ingredients",style: TextStyle(fontSize: 18),),
                    //SizedBox(height: 8,),
                    //Text(widget.product.ingredients!.isEmpty ? "Ingredients not available": widget.product.ingredients![0],style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.3)),),
                    //Text(widget.product.ingredients!.isEmpty ? "Ingredients not available": widget.product.ingredients!.join(", "),style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.3)),),

                    SizedBox(height: 8,),
                    Text("Description",style: TextStyle(fontSize: 18,),),
                    SizedBox(height: 8,),
                    //Text("${widget.product?.description ?? "Deatail not avaliable"}",style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.3)),),
                    ReadMoreText(
                      widget.product?.description ?? "Detail not available",
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: " Read more",
                      trimExpandedText: " Show less",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 10,),
                    widget.product.productType == "food" &&
                        widget.product.addons != null &&
                        widget.product.addons!.isNotEmpty
                        ? Text("Addons",style: TextStyle(fontSize: 18,),): SizedBox.shrink(),
                    widget.product.productType == "food" &&
                        widget.product.addons != null &&
                        widget.product.addons!.isNotEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.product.addons!
                          .map(
                            (addon) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addon.name,
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Unit ${addon.qty ?? "N/A"}",
                              style: const TextStyle(fontSize: 14),
                            ),

                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        if(addon.setQty.value > 0 ){
                                          //addon.totalPrice.value = addon.price * (addon.setQty.value - 1);
                                          addon.setQty.value--;
                                          addOnTotalPrice.value = widget.product.addons?.fold<double>(
                                            0.0,
                                                (sum, e) => sum + (e.price * e.setQty.value),
                                          ) ??
                                              0.0;
                                          print("add on total price ondcrease ${addOnTotalPrice.value}");
                                          //productController.addOnTotalPrice.value = productController.addOnTotalPrice.value - addon.price;
                                        }

                                        },
                                      icon: Icon(Icons.remove_circle_outline,color: AppColors.primary,)),

                                  SizedBox(width: 4,),
                                  Obx(() =>  Text(
                                      "${addon.setQty.value ?? 0}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    //addon.totalPrice.value = addon.price * (addon.setQty.value + 1);
                                     addon.setQty.value++;
                                     addOnTotalPrice.value = widget.product.addons?.fold<double>(
                                       0.0,
                                           (sum, e) => sum + (e.price * e.setQty.value),
                                     ) ??
                                         0.0;
                                     print("add on total price ${addOnTotalPrice.value}");
                                    //productController.addOnTotalPrice.value = productController.addOnTotalPrice.value + addon.price;
                                    }, icon: Icon(Icons.add_circle_outline,color: AppColors.primary,
                                  )),
                                ],
                              ),
                            ),

                            Text(
                              "₹${addon.price.toInt()}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                          .toList(),
                    )
                        : const SizedBox.shrink(),

                    SizedBox(height: 8,),
                    Text(widget.product.productType == "food"? "Serving Size" :"Weight",style: TextStyle(fontSize: 18,),),
                    SizedBox(height: 8,),
                    Text(widget.product.productType == "food"? widget.product.servingSize.toString():"${widget.product.quantity} ${widget.product.unit}",style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.3)),),
                    //_buildItemParamteter(["10 ${widget.product.unit}","20 ${widget.product.unit}","30 ${widget.product.unit}","40 ${widget.product.unit}","50 ${widget.product.unit}"]),
                    SizedBox(height: 8,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("Recommended For You",style: TextStyle(fontSize: 18),),
                    //     InkWell(
                    //       onTap: () => Get.to(BrowseProductsScreen(loadFor: LoadProductFor.fromSubCategory, params: widget.product.subCategory?.id ?? "")),
                    //         child: Text("see All",style: TextStyle(fontSize: 16,color: AppColors.primary),)),
                    //   ],
                    // ),
                    // SizedBox(height: 8,),
                    // _buildRecomandationList(widget.product?.subCategory?.id ?? ""),
                    // SizedBox(height: 8,),
                    FutureBuilder<List<ProductModel>>(
                      future: /*(widget.product.productType == "food") ? Get.find<ResturentController>().getRestaurantItems(widget.product.restaurant?.id ?? "") :*/ subCategoryProductCon
                          .getProductBySubCategory(widget.product?.subCategory?.id ?? ""),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }

                        final products = snapshot.data!
                            .where((e) => e.id != widget.product.id)
                            .toList();

                        // ❌ No recommended products → hide section completely
                        if (products.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        // ✅ Products available → show section
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Recommended For You",
                                  style: TextStyle(fontSize: 18),
                                ),
                                InkWell(
                                  onTap: () => Get.to(
                                    BrowseProductsScreen(
                                      loadFor: LoadProductFor.fromSubCategory,
                                      params: widget.product.subCategory?.id ?? "",
                                    ),
                                  ),
                                  child: Text(
                                    "See All",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 0.4.toWidthPercent(),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return InkWell(
                                    // onTap: () {
                                    //   print("Tapped product: ${product.name}, ID: ${product.id}");
                                    //   Get.off(() => ViewProductScreen(product: product),
                                    //   );
                                    // },
                                    onTap: () async {
                                      print("Tapped product: ${product.name}, ID: ${product.id}");

                                      // Pop current screen first
                                      Navigator.pop(context);

                                      // Small delay to ensure pop completes
                                      //await Future.delayed(Duration(microseconds: 10));

                                      // Push new screen
                                      Get.to(() => ViewProductScreen(product: product));
                                    },
                                    child: Container(
                                      width: 0.4.toWidthPercent(),
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: SafeNetworkImage(
                                          url: product.imageUrl != null &&
                                              product.imageUrl!.isNotEmpty
                                              ? product.imageUrl!.first
                                              : "",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );

  }

  Widget _buildProductRatingWidget(int rating) {
    return Row(
      children: [
        // SizedBox(
        //   height: 50,
        //   width: 0.40.toWidthPercent(),
        //   child: ListView.separated(
        //     physics: NeverScrollableScrollPhysics(),
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //       return SvgPicture.asset(rating_star,colorFilter: ColorFilter.mode(rating>index ? AppColors.primary : Color(0xFFF9A31E),BlendMode.srcIn));
        //       },//Icon(Icons.star_rate_sharp,color: rating>index ? AppColors.primary : Color(0xFFF9A31E),size: 25,),
        //       separatorBuilder: (context, index) => SizedBox(width: 0.008.toWidthPercent(),),
        //       itemCount: 5),
        // ),
        // Text("($rating)",style: TextStyle(fontSize: 18,color: Colors.black.withOpacity(0.5)),),
        Spacer(),

        // IconButton(
        //   onPressed: () {
        //     productController.decrease(widget.product.id);
        //
        //   },
        //   icon: CircleAvatar(
        //     child: Icon(Icons.remove, color: AppColors.primary),
        //     backgroundColor: AppColors.primary.withValues(alpha: 0.5),
        //   ),
        // ),
        IconButton(
          onPressed: () {
            if (localQty.value > 1) {
              localQty.value--;
            }
          },
          icon: CircleAvatar(
            child: Icon(Icons.remove, color: AppColors.primary),
            backgroundColor: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),


        const SizedBox(width: 6),

        /// ---- QUANTITY TEXT ----

        // Obx(() {
        //
        //   final qty = productController.getQuantity(widget.product.id);
        //   return Text(
        //     "${productController.getQuantity(widget.product.id) == 0 ? productController.getQuantity(widget.product.id) : productController.getQuantity(widget.product.id)}",
        //     style: const TextStyle(fontSize: 18, color: Colors.green));
        //
        // }),
        Obx(() => Text(
          localQty.value.toString(),
          style: const TextStyle(fontSize: 18, color: Colors.green),
        ),
        ),

        const SizedBox(width: 6),

        /// ---- PLUS BUTTON ----
        // IconButton(
        //     onPressed: () {
        //       productController.increase(
        //         widget.product.id,
        //         null, // prescription (if needed)
        //       );
        //     },
        //     icon: CircleAvatar(child: Icon(Icons.add),)
        // ),
        IconButton(
          onPressed: () {
            if(widget.product.maxOrderQuantity != null && localQty.value >= widget.product.maxOrderQuantity!) {
              AppSnackBar.showError(context, message: "Maximum order quantity reached");

            }else{
              localQty.value++;
            }

          },
          icon: const CircleAvatar(child: Icon(Icons.add)),
        ),

      ],
    );
  }

  Widget _buildItemParamteter(List<String> params)  {
    return SizedBox(
      width: 1.toWidthPercent(),
      height: 0.05.toHeightPercent(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                productController.updateIteamByParams(index);
              },
              child: Obx(() =>
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index == productController.selectedParams.value? Color(0xFFF9A31E):AppColors.primary
                    ),
                    child: Text(params[index],style: TextStyle(color: Colors.white),),
                  ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemCount: params.length
      ),
    );
  }

  Widget _buildRecomandationList(String subCategoryId) {
    return SizedBox(
        height: 0.4.toWidthPercent(),
        width: 1.toWidthPercent(),
        child: FutureBuilder<List<ProductModel>>(
            future: subCategoryProductCon.getProductBySubCategory(subCategoryId),
            builder: (context, asyncSnapshot) {
              final products = asyncSnapshot.data
                  ?.where((e) => e.id != widget.product.id)
                  .toList();
              if(products == null || products!.isEmpty){
                return Center(child: Text("Products not available for Recommendation "));
              }
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) {
                    return InkWell(
                      onTap:()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProductScreen(product: products![index])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,

                        ),
                        height: 0.4.toWidthPercent(),
                        width: 0.4.toWidthPercent(),
                        //color: AppColors.secondary,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(06),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: [
                              SafeNetworkImage(url: (products?[index].imageUrl != null && products![index].imageUrl!.isNotEmpty) ? products![index].imageUrl![0] : "" ),
                              //Image.asset(productImage),
                              // Positioned(
                              //   right: 1,
                              //     top: 2,
                              //     child: IconButton(
                              //         onPressed: (){},
                              //         icon: CircleAvatar(
                              //           backgroundColor: Colors.white,
                              //           radius: 12,
                              //           child: Icon(Icons.favorite_border,color: AppColors.primary,size: 20,),
                              //         )
                              //     )
                              // ),
                              // Positioned(
                              //   bottom: 0,
                              //   left: 0,
                              //   right: 0,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.end,
                              //       children: [
                              //         InkWell(
                              //           onTap: () async {
                              //             //final response = await cartController.addToCart(widget.product,productController.productQuantity.value);
                              //             final response = await cartController.syncCartWithBackend();
                              //             AppSnackBar.showSuccess(context, message: response? "Cart Updated" : "Failed to update cart");
                              //             cartController.fetchCarts();
                              //           },
                              //           child: Container(
                              //             padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                              //             decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //               borderRadius: BorderRadius.circular(04)
                              //             ),
                              //             // child: Row(
                              //             //   spacing: 8,
                              //             //   mainAxisSize: MainAxisSize.min,
                              //             //   children: [
                              //             //     Text("Add"),
                              //             //     Icon(Icons.add_circle_outlined,color: AppColors.primary,)
                              //             //   ],
                              //             // ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index) => SizedBox(width: 12,),
                  itemCount: products?.length ?? 0);
            }
        )
    );
  }

}
