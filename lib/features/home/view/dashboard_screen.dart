// // // main.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:newdow_customer/features/home/view/widgets/categories.dart';
// // import 'package:newdow_customer/features/home/view/widgets/foodSection.dart';
// // import 'package:newdow_customer/features/home/view/widgets/grocerySection.dart';
// // import 'package:newdow_customer/features/home/view/widgets/pharmacySection.dart';
// // import 'package:newdow_customer/features/home/view/widgets/promotionBanner.dart';
// // import 'package:newdow_customer/features/home/view/widgets/searchBar.dart';
// // import 'package:newdow_customer/features/product/controller/productContorller.dart';
// //
// // import '../../../utils/apptheme.dart';
// // import '../../../widgets/appbar.dart';
// //
// // // screens/home_screen.dart
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //
// //   final ScrollController _scrollController = ScrollController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.background,
// //       body: SafeArea(
// //         top: false,
// //         child: CustomScrollView(
// //           controller: _scrollController,
// //           slivers: [
// //              CustomAppBar(),
// //             //const SearchBarWidget(),
// //             const PromoBanner(),
// //             CategorySection(),
// //             const FoodSection(),
// //             const GrocerySection(),
// //             const PharmacySection(),
// //             SliverPadding(padding: EdgeInsets.only(bottom: 20)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }
// // }
// //
// //
// //
// //
// // // widgets/category_item.dart
// //
// //
// //
// //
// //
// // // utils/app_colors.dart
// //
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/view/widgets/categories.dart';
// import 'package:newdow_customer/features/home/view/widgets/foodSection.dart';
// import 'package:newdow_customer/features/home/view/widgets/grocerySection.dart';
// import 'package:newdow_customer/features/home/view/widgets/pharmacySection.dart';
// import 'package:newdow_customer/features/home/view/widgets/promotionBanner.dart';
// import 'package:newdow_customer/features/home/view/widgets/searchBar.dart';
// import 'package:newdow_customer/features/browseProducts/controller/searchController.dart';
// import 'package:newdow_customer/features/product/view/view_product_screen.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/imageHandler.dart';
// import '../../../utils/apptheme.dart';
// import '../../../widgets/appbar.dart';
// import '../../profile/controller/profile_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final ProductSearchController searchController = Get.put(ProductSearchController());
//   final profileCtrl = Get.find<ProfileController>();
//   bool isProfileCompleted = profileCtrl.savedData.value!.isProfileComplete != null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         top: false,
//         child: Stack(
//           children: [
//             /// MAIN DASHBOARD CONTENT
//             CustomScrollView(
//               controller: _scrollController,
//               slivers: [
//                 CustomAppBar(),
//                 // your search bar inside CustomAppBar
//                 const PromoBanner(),
//                 CategorySection(),
//                 const FoodSection(),
//                 const GrocerySection(),
//                 const PharmacySection(),
//                 const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
//               ],
//             ),
//
//             /// SEARCH RESULTS OVERLAY
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
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Overlay builder
//   Widget _buildOverlay(BuildContext context, Widget child) {
//     return Positioned(
//       top: kToolbarHeight + 0.15.toHeightPercent(), // adjust according to your CustomAppBar height
//       left: 2,
//       right: 2,
//       bottom: 0,
//       child: Stack(
//         children: [
//           /// optional background blur for elegance
//
//
//           /// overlay content
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
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';
import 'package:newdow_customer/features/home/view/widgets/categories.dart';
import 'package:newdow_customer/features/home/view/widgets/foodSection.dart';
import 'package:newdow_customer/features/home/view/widgets/grocerySection.dart';
import 'package:newdow_customer/features/home/view/widgets/pharmacySection.dart';
import 'package:newdow_customer/features/home/view/widgets/promotionBanner.dart';
import 'package:newdow_customer/features/home/view/widgets/recmmended_restaurent_section.dart';
import 'package:newdow_customer/features/home/view/widgets/searchBar.dart';
import 'package:newdow_customer/features/browseProducts/controller/searchController.dart';
import 'package:newdow_customer/features/product/view/view_product_screen.dart';
import 'package:newdow_customer/features/profile/model/userModel.dart';
import 'package:newdow_customer/features/profile/view/profile_screen.dart';
import 'package:newdow_customer/features/profile/view/view_profile_screen.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/prefs.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';
import '../../../utils/apptheme.dart';
import '../../../widgets/appbar.dart';
import '../../address/controller/addressController.dart';
import '../../address/model/addressModel.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/bannerController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductSearchController searchController = Get.put(ProductSearchController());
  final AddressController addressCon = Get.find<AddressController>();
  final businessCtrl = Get.find<BusinessController>();
  final profileCtrl = Get.find<ProfileController>();
  late bool isProfileCompleted;
  UserModel? user;


  Future<void> _onRefresh() async {
    try {
      await businessCtrl.loadBusinessTypes();

      if (addressCon.defaultAddress.value != null) {
        await _onAddressChanged(addressCon.defaultAddress.value!);
      }

      await profileCtrl.getProfileData();
    } catch (e) {
      print("Refresh error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
    ever<AddressModel?>(
      addressCon.defaultAddress,
          (address) {
        if (address != null) {
          _onAddressChanged(address);
        }
      },
    );

  }
  Future<void> _onAddressChanged(AddressModel address) async {
    print('Address changed to city: ${address.city}');

    // 1️⃣ Reload business types (based on city)
    await businessCtrl.loadBusinessTypes();

    // 2️⃣ Clear old dashboard data (important)
   /* businessCtrl.clearDashboardData();*/

    // 3️⃣ Reload dashboard sections
    /*await businessCtrl.loadDashboardData(
      city: address.city,
    );*/
  }
  Future<void> _init() async {
    await _getProfile(); // wait for API / shared prefs
    //isProfileCompleted = user?.isProfileComplete ?? false;

    print("Profile status after fetch: $isProfileCompleted");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowProfileDialog();
    });
     addressCon.initializeControllers();
    // Load addresses after initialization
    // Future.delayed(Duration.zero, () {
    //   addressCon.loadAddresses();
    // });
  }

  void _checkAndShowProfileDialog() {
    if (!isProfileCompleted) {
      _showProfileCompletionDialog();
    }
  }

  Future<void> _getProfile() async {
    // user = await profileCtrl.getUser(
    //     await AuthStorage.getUserFromPrefs().then((u) => u?.id ?? "")
    // );
    // print("User status fetched: ${user?.isProfileComplete ?? false}");
    await profileCtrl.getProfileData();
    isProfileCompleted = profileCtrl.savedData.value?.isProfileComplete ?? false;
  }
  void _showProfileCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (optional)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Icon with gradient background
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary.withValues(alpha: 0.1), AppColors.secondary.withValues(alpha: 0.1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 45,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Complete Your Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  "To continue using all the features of the app smoothly, please complete your profile.This helps us personalize your experience and provide better service",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Complete Profile Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to profile edit screen
                      Get.to(() => ViewProfileScreen());
                      // Or use: Get.to(() => EditProfileScreen());
                    },
                    child: const Text(
                      "Complete Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Maybe Later Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Maybe Later",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBenefitItem(String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  // Alternative approach - conditionally render sections

  @override
  Widget build(BuildContext context) {
    print("dgsdsagdj");
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              /// MAIN DASHBOARD CONTENT
              Obx(() {
                // Build sliver list based on state
                final slivers = <Widget>[
                  // CustomAppBar(),
                  // PromoBanner(),
                  // CategorySection(),
                ];

                // Show loading
                if (businessCtrl.isLoading.value) {
                  slivers.add(
                    SliverToBoxAdapter(
                      child: Container(
                        height: 300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                }
                // Check if service is available
                else if (businessCtrl.businessTypes.isNotEmpty) {
                  final userCity = addressCon.defaultAddress.value?.city;
                  /*final hasServiceInCity = userCity != null &&
                      businessCtrl.businessTypes.any(
                            (b) => b.cities.contains(userCity),
                      );*/final hasServiceInCity = userCity != null &&
                      businessCtrl.businessTypes.any(
                            (b) => b.cities.any(
                              (c) => c.city.toLowerCase() == userCity.toLowerCase(),
                        ),
                      );

                  print("jkfdfn $hasServiceInCity");
                  if (hasServiceInCity) {
                    // Add product sections
                    slivers.addAll([
                      CustomAppBar(isInServiceableArea: hasServiceInCity,),
                      PromoBanner(bannerType: BannerType.forHome,),
                      CategorySection(),
                      SliverPadding(padding: EdgeInsets.symmetric(vertical: 8)),
                      // CompactRecommendedRestaurants(restaurants: DummyRestaurantData.getRecommendedRestaurants(),),
                      SliverToBoxAdapter(child: CompactRecommendedRestaurants()),
                      
                      SliverPadding(padding: EdgeInsets.symmetric(vertical: 6)),

                      const FoodSection(),
                      const GrocerySection(),
                      const PharmacySection(),
                    ]);
                  } else {
                    // Show out of service message
                    slivers.addAll([
                      CustomAppBar(),
                      PromoBanner(bannerType: BannerType.forHome,),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
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
                              // Text(
                              //   userCity != null
                              //       ? "Service not available in $userCity"
                              //       : "Please select a delivery address",
                              //   style: const TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.grey,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                            ],
                          ),
                        ),
                      ),]);
                  }
                }

                // Add bottom padding
                slivers.add(
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                );

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: slivers,
                  ),
                );
              }),

              /// SEARCH RESULTS OVERLAY
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
  //
  // @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: (){FocusScope.of(context).unfocus();},
  //     child: Scaffold(
  //       backgroundColor: AppColors.background,
  //       body: SafeArea(
  //         top: false,
  //         child: Stack(
  //           children: [
  //             /// MAIN DASHBOARD CONTENT
  //             CustomScrollView(
  //               controller: _scrollController,
  //               // slivers: [
  //               //   CustomAppBar(),
  //               //   // your search bar inside CustomAppBar
  //               //    PromoBanner(),
  //               //   CategorySection(),
  //               //
  //               //   const FoodSection(),
  //               //   const GrocerySection(),
  //               //   const PharmacySection(),
  //               //   const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
  //               // ],
  //               slivers: [
  //                 CustomAppBar(),
  //                 PromoBanner(),
  //                 CategorySection(),
  //
  //
  //                 /// 🚨 Business types not loaded yet
  //                 if (businessCtrl.businessTypes.isEmpty)
  //                   const SliverToBoxAdapter(
  //                     child: SizedBox.shrink(),
  //                   ),
  //
  //                 /// ✅ Business + address check
  //                 if (businessCtrl.businessTypes.isNotEmpty &&
  //                     addressCon.defaultAddress.value != null &&
  //                     businessCtrl.businessTypes.any(
  //                           (b) => b.cities.contains(addressCon.defaultAddress.value!.city),
  //                     )) ...[
  //                    FoodSection(),
  //                    GrocerySection(),
  //                    PharmacySection(),
  //                 ] else
  //                 /// ❌ Service not available for this address
  //                    SliverToBoxAdapter(
  //                     child: Padding(
  //                       padding: EdgeInsets.all(16),
  //                       child: Column(
  //                         children: [
  //                           Center(
  //                             child: SvgPicture.asset(
  //                               out_of_service_area,
  //                               width: 0.6.toWidthPercent(),
  //                             ),
  //                           ),
  //                           Text("Your are out of service area")
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                 const SliverPadding(
  //                   padding: EdgeInsets.only(bottom: 20),
  //                 ),
  //               ],
  //
  //             ),
  //
  //
  //         /// SEARCH RESULTS OVERLAY
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
  //                   separatorBuilder: (_, __) {
  //                     return Divider(
  //                       height: 5,
  //                       color: AppColors.primary.withValues(alpha: 0.5),
  //                     );
  //                   },
  //                   itemCount: searchController.products.length,
  //                   itemBuilder: (context, index) {
  //                     final product = searchController.products[index];
  //                     return ListTile(
  //                       leading: SafeNetworkImage(
  //                         url: product.imageUrl
  //                             .toString()
  //                             .replaceAll(RegExp(r'[\[\]]'), '') ??
  //                             "",
  //                       ),
  //                       title: Text(product.name ?? 'Unnamed Product'),
  //                       subtitle: Text(
  //                         product.description ?? '',
  //                         maxLines: 2,
  //                         style: TextStyle(color: AppColors.textSecondary),
  //                       ),
  //                       onTap: () {
  //                         FocusScope.of(context).unfocus();
  //                         searchController.searchQuery.value = '';
  //                         searchController.products.clear();
  //                         Get.to(ViewProductScreen(product: product));
  //                       },
  //                     );
  //                   },
  //                 ),
  //               );
  //             }),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// Overlay builder
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