//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/address/controller/addressController.dart';
// import 'package:newdow_customer/features/home/controller/buisnessController.dart';
// import 'package:newdow_customer/utils/getSize.dart';
//
// import '../../../../../../utils/apptheme.dart';
// import '../../../../../../utils/constants.dart';
// import '../../../../../../widgets/appbar.dart';
// import '../../../view/widgets/promotionBanner.dart';
// import '../../restaurent/controller/restaurentController.dart';
// import '../widgets/filtter.dart';
// import '../widgets/food_categories_section.dart';
// import '../widgets/recomended_section.dart';
// import '../widgets/restorent_section.dart';
//
// class FoodHomeScreen extends StatefulWidget {
//   String businessTypeId;
//   FoodHomeScreen({Key? key, required this.businessTypeId}) : super(key: key);
//
//   @override
//   State<FoodHomeScreen> createState() => _FoodHomeScreenState();
// }
//
// class _FoodHomeScreenState extends State<FoodHomeScreen> {
//   final addressCtrl = Get.find<AddressController>();
//   final businessCon = Get.find<BusinessController>();
//   final restaurantCtrl = Get.find<ResturentController>();
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize restaurants and filters ONCE on screen load
//     _initializeRestaurants();
//   }
//
//   Future<void> _initializeRestaurants() async {
//     try {
//       print('🍽️ Initializing restaurants...');
//       await restaurantCtrl.getRestaurents("active");
//       print('✅ Restaurants initialized');
//       print('📊 Filters: ${restaurantCtrl.filters}');
//       print('🏢 Restaurant count: ${restaurantCtrl.restaurantList.length}');
//     } catch (e) {
//       print('❌ Error initializing restaurants: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (businessCon.businessTypes.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         top: false,
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             CustomAppBar(isFromFoodDashboard: true,isInServiceableArea: true,),
//             PromoBanner(),
//
//             /// ✅ Service-based rendering
//             Obx(() {
//               final city = addressCtrl.defaultAddress.value?.city;
//
//               if (businessCon.businessTypes.isEmpty) {
//                 return const SliverToBoxAdapter(child: SizedBox.shrink());
//               }
//
//               final business = businessCon.businessTypes.first;
//               final isServiceAvailable =
//                   city != null && business.cities.contains(city);
//
//               if (!isServiceAvailable) {
//                 return SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           out_of_service_area,
//                           width: 0.6.toWidthPercent(),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           "You are out of service area",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           city != null
//                               ? "Service not available in $city"
//                               : "Please select a delivery address",
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }
//
//               /// ✅ MULTIPLE SLIVERS
//               return SliverMainAxisGroup(
//                 slivers: [
//                   // Food Categories
//                   FoodCategorySection(
//                     businessTypeId: widget.businessTypeId,
//                   ),
//
//                   // Restaurant Filters
//                   RestaurantFilterSection(
//                     filters: restaurantCtrl.filters,
//                     selectedFilter: restaurantCtrl.selectedFilter,
//                     onFilterChanged: (filter) {
//                       print('🔍 Filter chip tapped: $filter');
//                       restaurantCtrl.applyFilter(filter);
//                     },
//                   ),
//
//                   // Recommended Section
//                   SliverToBoxAdapter(
//                     child: RecommendedSection(businessId: widget.businessTypeId,),
//                   ),
//
//                   // Restaurant Section
//                   RestaurantSection(),
//                 ],
//               );
//             }),
//
//             const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/home/controller/bannerController.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../../../../utils/apptheme.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../widgets/appbar.dart';
import '../../../../../widgets/imageHandler.dart';
import '../../../../browseProducts/controller/searchController.dart';
import '../../../../product/view/view_product_screen.dart';
import '../../../view/widgets/promotionBanner.dart';
import '../../restaurent/controller/restaurentController.dart';
import '../widgets/filtter.dart';
import '../widgets/food_categories_section.dart';
import '../widgets/recomended_section.dart';
import '../widgets/restorent_section.dart';

class FoodHomeScreen extends StatefulWidget {
  String businessTypeId;
  FoodHomeScreen({Key? key, required this.businessTypeId}) : super(key: key);

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  final addressCtrl = Get.find<AddressController>();
  final businessCon = Get.find<BusinessController>();
  final restaurantCtrl = Get.find<ResturentController>();
  final ScrollController _scrollController = ScrollController();
  final ProductSearchController searchController = Get.put(ProductSearchController());

  @override
  void initState() {
    super.initState();
    // Initialize restaurants and filters ONCE on screen load
    _initializeRestaurants();
  }

  Future<void> _initializeRestaurants() async {
    try {
      print('🍽️ Initializing restaurants...');
      await restaurantCtrl.getRestaurents("active");
      print('✅ Restaurants initialized');
      print('📊 Filters: ${restaurantCtrl.filters}');
     // await Get.find<BannerController>().getHomeBanners();
      print('🏢 Restaurant count: ${restaurantCtrl.restaurantList.length}');
    } catch (e) {
      print('❌ Error initializing restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (businessCon.businessTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          top: false,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  CustomAppBar(isFromFoodDashboard: true,isInServiceableArea: true,),
                  PromoBanner(bannerType: BannerType.forRestaurant,),

                  /// ✅ Service-based rendering
                  Obx(() {
                    final city = addressCtrl.defaultAddress.value?.city;

                    if (businessCon.businessTypes.isEmpty) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }

                    final business = businessCon.businessTypes.first;
                    // final isServiceAvailable =
                    //     city != null && business.cities.contains(city);
                    final isServiceAvailable =
                        city != null &&
                            business.cities.any(
                                  (c) => c.city.toLowerCase() == city.toLowerCase(),
                            );

                    if (!isServiceAvailable) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                out_of_service_area,
                                width: 0.6.toWidthPercent(),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "You are out of service area",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                city != null
                                    ? "Service not available in $city"
                                    : "Please select a delivery address",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    /// ✅ MULTIPLE SLIVERS
                    return SliverMainAxisGroup(
                      slivers: [
                        // Food Categories
                        FoodCategorySection(
                          businessTypeId: widget.businessTypeId,
                        ),

                        // Restaurant Filters
                        RestaurantFilterSection(
                          filters: restaurantCtrl.filters,
                          selectedFilter: restaurantCtrl.selectedFilter,
                          onFilterChanged: (filter) {
                            print('🔍 Filter chip tapped: $filter');
                            restaurantCtrl.applyFilter(filter);
                          },
                        ),

                        // Recommended Section
                        SliverToBoxAdapter(
                          child: RecommendedSection(businessId: widget.businessTypeId,),
                        ),

                        // Restaurant Section
                        RestaurantSection(),
                      ],
                    );
                  }),

                  const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                ],
              ),
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
          /// optional background blur for elegance
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
}