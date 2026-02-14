//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/browseProducts/controller/searchController.dart';
// import 'package:newdow_customer/features/home/controller/categoryAndSubcategoryController.dart';
// import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
// import 'package:newdow_customer/features/product/controller/productContorller.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/constants.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/imageHandler.dart';
//
// import '../../home/model/models/categoryAndSubCategoryModel.dart';
// import '../../home/view/widgets/searchBar.dart';
// import '../../product/view/view_product_screen.dart';
//
// class BrowseCategoryAndSubcategoryScreen extends StatefulWidget {
//   String businessId;
//    BrowseCategoryAndSubcategoryScreen({super.key,required this.businessId});
//
//   @override
//   State<BrowseCategoryAndSubcategoryScreen> createState() => _BrowseCategoryAndSubcategoryScreenState();
// }
//
// class _BrowseCategoryAndSubcategoryScreenState extends State<BrowseCategoryAndSubcategoryScreen> {
//    final categoryAndSubcaregoryCon = Get.find<CategoryAndSubcategoryController>();
//    final ScrollController _scrollController = ScrollController();
//
// final searchController  =  Get.find<ProductSearchController>();
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: false,
//         child: Stack(
//           children: [
//             CustomScrollView(
//               slivers: [
//                 CustomAppBar(),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Column(
//                       children: [
//                         // Top 2 Trending Products
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         //     _topProducts(),
//                         //     _topProducts(),
//                         //   ],
//                         // ),
//                         FutureBuilder<List<CategoryModel>>(
//                             future: categoryAndSubcaregoryCon.getCategories(widget.businessId),
//                             builder: (context, asyncSnapshot) {
//                               final categories = asyncSnapshot.data;
//                               if(asyncSnapshot.hasError){
//                                 return Center(child: Text("Error :- ${asyncSnapshot.error}"),);
//                               }else if(asyncSnapshot.connectionState == ConnectionState.waiting){
//                                 return CircularProgressIndicator();
//                               }else if(asyncSnapshot.data!.isEmpty){
//                                 return Center(child: Text("Categories are no available"),);
//                               }
//                               return GridView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   crossAxisSpacing: 12,
//                                   mainAxisSpacing: 12,
//                                   childAspectRatio: 1.2,
//                                 ),
//                                 itemCount: categories?.length, // Remaining products (20 - 2 top products)
//                                 itemBuilder: (context, index) {
//                                   return _topProducts(categories![index]); // Start from index 2
//                                 },
//                               );
//                             }
//                         ),
//                         const SizedBox(height: 12),
//
//                         // 3-Column Grid for Remaining Products
//                         /*Obx(() => FutureBuilder(
//                           future: categoryAndSubcaregoryCon.getSubCategory(categoryAndSubcaregoryCon.categories[0].id),
//                           builder: (context, asyncSnapshot) {
//                             final subCategories = asyncSnapshot.data;
//                             if(asyncSnapshot.hasError){
//                               return Center(child: Text("Error :- ${asyncSnapshot.error}"),);
//                             }else if(asyncSnapshot.connectionState == ConnectionState.waiting){
//                               return CircularProgressIndicator();
//                             }else if(asyncSnapshot.data!.isEmpty){
//                               return Center(child: Text("Categories are no available"),);
//                             }else if(asyncSnapshot.hasData){
//
//                               return GridView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   crossAxisSpacing: 12,
//                                   mainAxisSpacing: 12,
//                                   childAspectRatio: 0.75,
//                                 ),
//                                 itemCount: subCategories?.length, // Remaining products (20 - 2 top products)
//                                 itemBuilder: (context, index) {
//                                   return _productCard(index + 2,subCategories![index]); // Start from index 2
//                                 },
//                               );
//                             }
//                             return Center(child: Text("Somthing Went wrong while getting subcategory"),);
//
//                           }
//                         ),
//                       ),*/
//                         Obx(() {
//                           if (categoryAndSubcaregoryCon.isLoading.value) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//
//                           if (categoryAndSubcaregoryCon.errorMessage.isNotEmpty) {
//                             return Center(
//                               child: Text("${categoryAndSubcaregoryCon.errorMessage.value}"),
//                             );
//                           }
//
//                           if (categoryAndSubcaregoryCon.subcategories.isEmpty) {
//                             return const Center(child: Text("Categories are not available"));
//                           }
//
//                           return GridView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                               childAspectRatio: 0.85,
//                             ),
//                             itemCount: categoryAndSubcaregoryCon.subcategories.length,
//                             itemBuilder: (context, index) {
//                               return _productCard(index, categoryAndSubcaregoryCon.subcategories[index]);
//                             },
//                           );
//                         })
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Obx(() {
//               if (searchController.searchQuery.isEmpty) return const SizedBox();
//
//               if (searchController.isLoading.value) {
//                 return _buildOverlay(
//                   context,
//                   const Center(child: CircularProgressIndicator()),
//                 );
//               }
//
//               if (searchController.errorMessage.isNotEmpty) {
//                 return _buildOverlay(
//                   context,
//                   Center(child: Text(searchController.errorMessage.value)),
//                 );
//               }
//
//               if (searchController.products.isEmpty) {
//                 return _buildOverlay(
//                   context,
//                   const Center(child: Text('No products found')),
//                 );
//               }
//
//               return _buildOverlay(
//                 context,
//                 ListView.separated(
//                   separatorBuilder: (_,__){return Divider(height: 5,color: AppColors.primary.withValues(alpha: 0.5));},
//                   itemCount: searchController.products.length,
//                   itemBuilder: (context, index) {
//                     final product = searchController.products[index];
//                     return ListTile(
//                       leading: SafeNetworkImage(url: product.imageUrl.toString().replaceAll(RegExp(r'[\[\]]'), '' ?? "")),
//                       title: Text(product.name ?? 'Unnamed Product'),
//                       subtitle: Text(product.description ?? '',maxLines: 2,style: TextStyle(color: AppColors.textSecondary),),
//                       onTap: () {
//                         FocusScope.of(context).unfocus();
//                         searchController.searchQuery.value = '';
//                         searchController.products.clear();
//                         // navigate to product details if needed
//                         Get.to(ViewProductScreen(product: product));
//                       },
//                     );
//                   },
//                 ),
//               );
//             }),
//
//           ],
//
//         ),
//       ),
//     );
//   }
//
//   // Widget _topProducts(int index) {
//   Widget _topProducts(CategoryModel category) {
//     return InkWell(
//       //onTap: () => Get.to(BrowseFoodCategories(loadFor: LoadProductFor.fromSubCategory, params: category.id)),
//
//       onTap: () async {
//         print('category Id :- ${category.id}');
//         await Get.find<CategoryAndSubcategoryController>().getSubCategory(category.id);
//       } ,
//       child: Container(
//           padding: EdgeInsets.only(top: 0.8),
//           height: 0.1.toHeightPercent(),
//           width: 0.43.toWidthPercent(),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: AppColors.primary),
//             color: AppColors.primary,
//           ),
//           child:  Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                   width: 0.7.toWidthPercent(),
//                   decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   height: 0.1.toHeightPercent(),
//                   child: ClipRRect(
//                       borderRadius: BorderRadiusGeometry.circular(10),
//                       //child: Image.asset(productImage))),
//                     child: SafeNetworkImage(
//                       url: (category.imageUrl != null && category.imageUrl!.isNotEmpty)
//                           ? category.imageUrl!.first
//                           : "",
//                     )
//                   )),
//
//               Container(
//                 height: 0.05.toHeightPercent(),
//                 color: AppColors.primary,
//                 alignment: Alignment.center,
//                 child: Text(category.name,style: TextStyle(color: Colors.white),),
//               )
//             ],
//           )
//
//       ),
//     );
//   }
//
//   // Widget _productCard(int index) {
//   Widget _productCard(int index,SubCategoryModel subCategory){
//     return GestureDetector(
//       onTap: () => Get.to(BrowseProductsScreen(loadFor: LoadProductFor.fromSubCategory, params: subCategory.id)),
//       child: Container(
//           height: 0.14.toHeightPercent(),
//           width: 0.1.toWidthPercent(),
//           padding: EdgeInsets.only(top: 0.8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: AppColors.primary),
//             color: AppColors.primary,
//           ),
//           child:  Column(
//             children: [
//               Container(
//                   width: 0.8.toWidthPercent(),
//                   height: 0.1.toHeightPercent(),
//                   decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//
//                   child: ClipRRect(
//                       borderRadius: BorderRadiusGeometry.circular(10),
//                       //child: Image.asset(productImage))),
//                     child: SafeNetworkImage(
//                       url: (subCategory.category?.imageUrl != null && subCategory!.category!.imageUrl!.isNotEmpty)
//                           ? subCategory.category!.imageUrl!.first
//                           : "",
//                     )
//                   )),
//               Center(
//                 child: Container(
//                   //height: 0.05.toHeightPercent(),
//                   margin: EdgeInsets.all(4),
//                   color: AppColors.primary,
//                   alignment: Alignment.center,
//                   child: Text(subCategory.name,style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
//                 ),
//               )
//             ],
//           )
//       ),
//     );
//   }
//    Widget _buildOverlay(BuildContext context, Widget child) {
//      return Positioned(
//        top: kToolbarHeight + 0.15.toHeightPercent(), // adjust according to your CustomAppBar height
//        left: 2,
//        right: 2,
//        bottom: 0,
//        child: Stack(
//          children: [
//            /// optional background blur for elegance
//
//
//            /// overlay content
//            Material(
//              color: Colors.white,
//              elevation: 8,
//              child: child,
//            ),
//          ],
//        ),
//      );
//    }
//
//    @override
//    void dispose() {
//      _scrollController.dispose();
//      super.dispose();
//    }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/browseProducts/controller/searchController.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/features/home/controller/categoryAndSubcategoryController.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
import 'package:newdow_customer/features/product/controller/productContorller.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';
import 'package:shimmer/shimmer.dart';

import '../../home/model/models/buisness_type_model.dart';
import '../../home/model/models/categoryAndSubCategoryModel.dart';
import '../../home/view/widgets/promotionBanner.dart';
import '../../home/view/widgets/searchBar.dart';
import '../../product/view/view_product_screen.dart';

class BrowseCategoryAndSubcategoryScreen extends StatefulWidget {
  String businessId;
  BrowseCategoryAndSubcategoryScreen({super.key, required this.businessId});

  @override
  State<BrowseCategoryAndSubcategoryScreen> createState() =>
      _BrowseCategoryAndSubcategoryScreenState();
}

class _BrowseCategoryAndSubcategoryScreenState
    extends State<BrowseCategoryAndSubcategoryScreen> {
  final categoryAndSubcaregoryCon =
  Get.find<CategoryAndSubcategoryController>();
  final ScrollController _scrollController = ScrollController();
  final searchController = Get.find<ProductSearchController>();
  final businessCon = Get.find<BusinessController>();
  final addressCtrl = Get.find<AddressController>();
  late BannerType bannerType;

  @override
  Widget build(BuildContext context) {
    if (businessCon.businessTypes.length == 0) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    BusinessTypeModel? business = businessCon.businessTypes.firstWhere(
          (b) => b.id == widget.businessId,
    );




    switch (business.code.toLowerCase()) {
      case "food":
        bannerType = BannerType.forRestaurant;
        break;

      case "medicine":
        bannerType = BannerType.forPharmacy;
        break;

      case "grocery":
        bannerType = BannerType.forGrocery;
        break;

      default:
        bannerType = BannerType.forHome;
    }




    final userCity = addressCtrl.defaultAddress.value?.city;
    print("user city$userCity");
    print(business.cities.contains(userCity));
    // final isServiceAvailable =
    //     userCity != null && business.cities.contains(userCity);
    final isServiceAvailable =
        userCity != null &&
            business.cities.any(
                  (c) => c.city.toLowerCase() == userCity.toLowerCase(),
            );

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CustomAppBar(isInServiceableArea: isServiceAvailable,),
                PromoBanner(bannerType: bannerType),
                isServiceAvailable ?
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        //PromoBanner(bannerType: BannerType.forHome,),
                        // Categories Grid

                        FutureBuilder<List<CategoryModel>>(
                          future: categoryAndSubcaregoryCon.getCategories(widget.businessId),
                          builder: (context, asyncSnapshot) {
                            final categories = asyncSnapshot.data;
                            if (asyncSnapshot.hasError) {
                              return Center(
                                child: Text("Error :- ${asyncSnapshot.error}"),
                              );
                            } else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                              return _buildCategoriesShimmer(); // ✅ Use shimmer instead of CircularProgressIndicator
                            } else if (asyncSnapshot.data!.isEmpty) {
                              return Center(
                                child: Text("Categories are not available"),
                              );
                            }
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Categories", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                SizedBox(height: 22),
                                SizedBox(
                                  height: 0.18.toHeightPercent(),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(width: 12);
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return _topProducts(categories![index]);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text("Subcategories", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Obx(() {
                                  if (categoryAndSubcaregoryCon.isLoading.value) {
                                    return _buildSubcategoriesShimmer(); // ✅ Use shimmer for subcategories
                                  }

                                  if (categoryAndSubcaregoryCon.errorMessage.isNotEmpty) {
                                    return SizedBox(
                                      height: 0.3.toHeightPercent(),
                                      child: Center(
                                        child: Text(
                                          "${categoryAndSubcaregoryCon.errorMessage.value}",
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  }

                                  if (categoryAndSubcaregoryCon.subcategories.isEmpty) {
                                    return SizedBox(
                                      height: 0.3.toHeightPercent(),
                                      child: const Center(
                                        child: Text(
                                          "Select a category to view subcategories",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  }

                                  return GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.85,
                                    ),
                                    itemCount:
                                    categoryAndSubcaregoryCon.subcategories.length,
                                    itemBuilder: (context, index) {
                                      return _productCard(
                                        index,
                                        categoryAndSubcaregoryCon.subcategories[index],
                                      );
                                    },
                                  );
                                }),
                              ],
                            );
                          },
                        )
                        /*FutureBuilder<List<CategoryModel>>(
                          future: categoryAndSubcaregoryCon
                              .getCategories(widget.businessId),
                          builder: (context, asyncSnapshot) {
                            final categories = asyncSnapshot.data;
                            if (asyncSnapshot.hasError) {
                              return Center(
                                child: Text("Error :- ${asyncSnapshot.error}"),
                              );
                            } else if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(height: 1.toWidthPercent(),width: 1.toWidthPercent(),
                                  child: Center(child: _buildCategoriesShimmer()));
                            } else if (asyncSnapshot.data!.isEmpty) {
                              return Center(
                                child: Text("Categories are not available"),
                              );
                            }
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Categories",style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                                SizedBox(height: 22,),
                                SizedBox(
                                  height: 0.16.toHeightPercent(), // give any height you need
                                  child: ListView.separated(
                                    separatorBuilder: (context,index){
                                      return SizedBox(width: 12,);
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return _topProducts(categories![index]);
                                    },
                                  ),
                                ),
                                // ),GridView.builder(
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   shrinkWrap: true,
                                //   gridDelegate:
                                //   const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisCount: 2,
                                //     crossAxisSpacing: 12,
                                //     mainAxisSpacing: 12,
                                //     childAspectRatio: 1.2,
                                //   ),
                                //   itemCount: categories?.length,
                                //   itemBuilder: (context, index) {
                                //     return _topProducts(categories![index]);
                                //   },
                                // ),
                                const SizedBox(height: 20),

                                // Subcategories Grid with Loading State
                                Row(
                                  children: [
                                    Text("Subcategories",style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                                Obx(() {
                                  // Show loading indicator only when subcategories are being fetched
                                  if (categoryAndSubcaregoryCon.isLoading.value) {
                                    return SizedBox(
                                      height: 0.5.toHeightPercent(),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                            const SizedBox(height: 12),
                                            const Text('Loading subcategories...'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  // Show error message if there's an error
                                  if (categoryAndSubcaregoryCon
                                      .errorMessage.isNotEmpty) {
                                    return SizedBox(
                                      height: 0.3.toHeightPercent(),
                                      child: Center(
                                        child: Text(
                                          "${categoryAndSubcaregoryCon.errorMessage.value}",
                                          style:
                                          const TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  }

                                  // Show message if no subcategories available yet
                                  if (categoryAndSubcaregoryCon
                                      .subcategories.isEmpty) {
                                    return SizedBox(
                                      height: 0.3.toHeightPercent(),
                                      child: const Center(
                                        child: Text(
                                          "Select a category to view subcategories",
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  }

                                  // Show subcategories grid
                                  return GridView.builder(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.85,
                                    ),
                                    itemCount: categoryAndSubcaregoryCon
                                        .subcategories.length,
                                    itemBuilder: (context, index) {
                                      return _productCard(
                                        index,
                                        categoryAndSubcaregoryCon
                                            .subcategories[index],
                                      );
                                    },
                                  );
                                }),
                              ],
                            );
                          },
                        )*/
                      ],
                    ),
                  ),
                ) : SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            out_of_service_area,
                            width: 0.6.toWidthPercent(),
                          ),
                        ),
                        Text("Your are out of service area")
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search Overlay
            Obx(() {
              if (searchController.searchQuery.isEmpty) {
                return const SizedBox();
              }

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
                        url: product.imageUrl
                            .toString()
                            .replaceAll(RegExp(r'[\[\]]'), '') ??
                            "",
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
    );
  }

  Widget _topProducts(CategoryModel category) {
    return InkWell(
      onTap: () async {
        print('category Id :- ${category.id}');
        // This will trigger the loading state in the Obx below
        await categoryAndSubcaregoryCon.getSubCategory(category.id);
      },
      child: Container(
        //padding: EdgeInsets.only(top: 0.8),
        height: 0.1.toHeightPercent(),
        //width: 0.43.toWidthPercent(),
        width: 0.43.toWidthPercent(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.primary,
            width: 4
          ),
          color: AppColors.primary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 0.7.toWidthPercent(),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 0.1.toHeightPercent(),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: SafeNetworkImage(
                  url: (category.imageUrl != null &&
                      category.imageUrl!.isNotEmpty)
                      ? category.imageUrl!.first
                      : "",
                ),
              ),
            ),
            Container(
              height: 0.05.toHeightPercent(),
              color: AppColors.primary,
              alignment: Alignment.center,
              child: Text(
                category.name,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _productCard(int index, SubCategoryModel subCategory) {
    return GestureDetector(
      onTap: () => Get.to(BrowseProductsScreen(
        loadFor: LoadProductFor.fromSubCategory,
        params: subCategory.id,
      )),
      child: Container(
        height: 0.14.toHeightPercent(),
        width: 0.1.toWidthPercent(),
        //padding: EdgeInsets.only(top: 0.6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary,
            width: 3
          ),
          color: AppColors.primary,
        ),
        child: Column(
          children: [
            Container(
              width: 0.8.toWidthPercent(),
              height: 0.1.toHeightPercent(),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: SafeNetworkImage(
                  url: (subCategory?.imageUrl != null &&
                      subCategory!.imageUrl.isNotEmpty &&
                      subCategory.imageUrl.first.isNotEmpty)
                      ? subCategory.imageUrl.first
                      : "",
                ),

              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(4),
                color: AppColors.primary,
                alignment: Alignment.center,
                child: Text(
                  subCategory.name,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context, Widget child) {
    return Positioned(
      top: kToolbarHeight + 0.15.toHeightPercent(),
      left: 2,
      right: 2,
      bottom: 0,
      child: Stack(
        children: [
          Material(
            color: Colors.white,
            elevation: 8,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Widget _buildCategoriesShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Row(
            children: [
              Text("Categories", style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 22),
          SizedBox(
            height: 0.16.toHeightPercent(),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 12);
              },
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Show 5 placeholder categories
              itemBuilder: (context, index) {
                return _buildCategoryShimmerCard();
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text("Subcategories", style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryShimmerCard() {
    return Container(
      padding: EdgeInsets.only(top: 0.8),
      height: 0.1.toHeightPercent(),
      width: 0.43.toWidthPercent(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 0.7.toWidthPercent(),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 0.1.toHeightPercent(),
          ),
          Container(
            height: 0.05.toHeightPercent(),
            color: Colors.grey[300],
            alignment: Alignment.center,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _buildSubcategoriesShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: 9, // Show 9 placeholder cards (3x3 grid)
        itemBuilder: (context, index) {
          return _buildSubcategoryShimmerCard();
        },
      ),
    );
  }

  Widget _buildSubcategoryShimmerCard() {
    return Container(
      height: 0.14.toHeightPercent(),
      width: 0.1.toWidthPercent(),
      padding: EdgeInsets.only(top: 0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.grey[300],
      ),
      child: Column(
        children: [
          Container(
            width: 0.8.toWidthPercent(),
            height: 0.1.toHeightPercent(),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(4),
              color: Colors.grey[300],
              alignment: Alignment.center,
              height: 0.03.toHeightPercent(),
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }


}