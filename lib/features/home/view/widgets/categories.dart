

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/home/controller/bannerController.dart';
import 'package:shimmer/shimmer.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_category_and_subcategory_screen.dart';
// import 'package:newdow_customer/features/home/foodSection/restaurent/view/screens/food_dashboard_screen.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/constants.dart';

import '../../../../utils/apptheme.dart';
import '../../../address/controller/addressController.dart';
import '../../controller/buisnessController.dart';
import '../../foodSection/view/screens/food_dashboard_screen.dart';
import '../../model/models/buisness_type_model.dart';
class BusinessCategoryConfig {
  final String name;
  final String icon;
  final VoidCallback? onTap;

  const BusinessCategoryConfig({
    required this.name,
    required this.icon,
    this.onTap,
  });
}
class CategorySection extends StatefulWidget {
  CategorySection({Key? key}) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final addressController =  Get.find<AddressController>();
  final businessCtrl = Get.find<BusinessController>();
  int selectedCategory = 0;
  List<Map<String, dynamic>> categories = [
    {
      'name': 'Food',
      'icon': food_categorie_icon,
    },
    {
      'name': 'Grocery',
      'icon': grocery_categorie_icon,
    },
    {
      'name': 'Medicine',
      'icon': pharmacy_categorie_icon,
    }
  ];
  BusinessCategoryConfig? getCategoryConfig(String name) {
    return categoryConfigMap[name.toLowerCase()];
  }
  final Map<String, BusinessCategoryConfig> categoryConfigMap = {
    'food': BusinessCategoryConfig(
      name: 'Food',
      icon: food_categorie_icon,
    ),
    'grocery': BusinessCategoryConfig(
      name: 'Grocery',
      icon: grocery_categorie_icon,
    ),
    'medicine': BusinessCategoryConfig(
      name: 'Medicine',
      icon: pharmacy_categorie_icon,
    ),
  };


  // @override
  // Widget build(BuildContext context) {
  //   return SliverToBoxAdapter(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Category',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           height: 100,
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           child: FutureBuilder(
  //             future: Get.find<BusinessController>().getBusinessAllTypes(),
  //             builder: (context, asyncSnapshot) {
  //               print("getting b type in category Section ${asyncSnapshot.data!.length}");
  //               // 🔹 Loading state
  //               if (asyncSnapshot.connectionState == ConnectionState.waiting) {
  //                 return _buildShimmerLoader();
  //               }
  //
  //               // 🔹 Error state
  //               if (asyncSnapshot.hasError) {
  //                 return Center(child: Text("Something went wrong"));
  //               }
  //
  //               // 🔹 No Data
  //               if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
  //                 return Center(child: Text("No categories found"));
  //               }
  //
  //               final businessType = asyncSnapshot.data!;
  //               if(addressController.defaultAddress != null && addressController.defaultAddress != AddressModel.empty()){
  //                 return ListView.separated(
  //                   shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount: businessType.length,
  //                   separatorBuilder: (context, index) => SizedBox(width: 25),
  //                   itemBuilder: (context, index) {
  //                     if (index == 0) {
  //                       return Container(
  //                         margin: const EdgeInsets.only(right: 16),
  //                         child: Column(
  //                           children: [
  //                             InkWell(
  //                               onTap: () async {
  //                                 //await Future.delayed(Duration(microseconds: 1000));
  //                                 Get.to(FoodHomeScreen(businessTypeId: businessType![index].id,));
  //                               },
  //                               splashColor: AppColors.primary,
  //                               child: CircleAvatar(
  //                                 backgroundColor: Color(0x4DD9D9D9),
  //                                 radius: 30,
  //                                 child: SvgPicture.asset(
  //                                   categories[0]["icon"],
  //                                   height: 40,
  //                                   width: 40,
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(height: 8),
  //                             Text(
  //                               businessType[index].name,
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     } else {
  //                       return catagoryIcon(businessType![index], index);
  //                     }
  //                   },
  //                 );
  //               }else{
  //                 return Text("No address found");
  //               }
  //
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        final address = addressController.defaultAddress.value;

        if (businessCtrl.isLoading.value) {
          return _buildShimmerLoader();
        }

        if (address == null) {
          return Text("No address found");
        }

        if (businessCtrl.businessTypes.isEmpty) {
          return Text("No categories available");
        }

        return _categoryList(businessCtrl.businessTypes);
      }),
    );
  }
  Widget _categoryList(List<BusinessTypeModel> businessTypes) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: businessTypes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 25),
        itemBuilder: (context, index) {
          final businessType = businessTypes[index];
          final config = getCategoryConfig(businessType.name);
          final  addressCtrl = Get.find<AddressController>();
          final business = businessCtrl.businessTypes.firstWhere(
                (b) => b.name.toLowerCase() == businessType.name.toLowerCase(),
          );
          // final business = businessCon.businessTypes.where((b) => b.name.toLowerCase() == 'food').first;
          final userCity = addressCtrl.defaultAddress.value?.city;
          // final isServiceAvailable =
          //     userCity != null && business.cities.contains(userCity);
          final isServiceAvailable =
              userCity != null &&
                  business.cities.any(
                        (c) => c.city.toLowerCase() == userCity.toLowerCase(),
                  );
          return isServiceAvailable ? _categoryItem(
            businessType: businessType,
            config: config
          ) : SizedBox();
        },
      ),
    );
  }
  Widget _categoryItem({
    required BusinessTypeModel businessType,
    BusinessCategoryConfig? config,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              final type = businessType.name.toLowerCase();

              if (type == 'food') {
                Get.to(() => FoodHomeScreen(
                  businessTypeId: businessType.id,
                ))?.then((_) {
                  Get.find<BannerController>().resetToHomeBanners();
                });
              } else {
                Get.to(() => BrowseCategoryAndSubcategoryScreen(
                  businessId: businessType.id,
                ));
              }
            },
            child: CircleAvatar(
              backgroundColor: const Color(0x4DD9D9D9),
              radius: 30,
              child: SvgPicture.asset(
                config?.icon ?? "",
                height: 40,
                width: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            businessType.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _categoryList(List<BusinessTypeModel> businessTypes) {
  //   return SizedBox(
  //     height: 100,
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       itemCount: businessTypes.length,
  //       separatorBuilder: (_, __) => const SizedBox(width: 25),
  //       // itemBuilder: (context, index) {
  //       //   print("buisness type in category section ${businessTypes[index].name}");
  //       //   final category = businessTypes[index];
  //       //   if(index == 0) {
  //       //     return Container(
  //       //       margin: const EdgeInsets.only(right: 16),
  //       //       child: Column(
  //       //         children: [
  //       //           InkWell(
  //       //             onTap: () async {
  //       //               //await Future.delayed(Duration(microseconds: 1000));
  //       //               //Get.to(FoodHomeScreen(businessTypeId: category.id,));
  //       //               Get.to(() => FoodHomeScreen(businessTypeId: category.id,))?.then((_) {
  //       //                 Get.find<BannerController>().resetToHomeBanners();
  //       //               });
  //       //               },
  //       //             splashColor: AppColors.primary,
  //       //             child: CircleAvatar(
  //       //               backgroundColor: Color(0x4DD9D9D9),
  //       //               radius: 30,
  //       //               child: SvgPicture.asset(
  //       //                 categories[0]["icon"],
  //       //                 height: 40,
  //       //                 width: 40,
  //       //               ),
  //       //             ),
  //       //           ),
  //       //           SizedBox(height: 8),
  //       //           Text(
  //       //             businessTypes[index].name,
  //       //             style: TextStyle(
  //       //               fontSize: 12,
  //       //               fontWeight: FontWeight.w500,
  //       //             ),
  //       //           ),
  //       //         ],
  //       //       ),
  //       //     );
  //       //   }
  //       //   return catagoryIcon(category, index);
  //       // },
  //       itemBuilder: (context, index) {
  //         final category = businessTypes[index];
  //
  //         print("business type: ${category.name}");
  //
  //         return Container(
  //           margin: const EdgeInsets.only(right: 16),
  //           child: Column(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   if (category.name.toLowerCase() == "food") {
  //                     Get.to(() => FoodHomeScreen(
  //                       businessTypeId: category.id,
  //                     ))?.then((_) {
  //                       Get.find<BannerController>().resetToHomeBanners();
  //                     });
  //                   }
  //                 },
  //                 child: CircleAvatar(
  //                   backgroundColor: const Color(0x4DD9D9D9),
  //                   radius: 30,
  //                   child: SvgPicture.asset(
  //                     getCategoryIcon(category.name),
  //                     height: 40,
  //                     width: 40,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 category.name,
  //                 style: const TextStyle(
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //
  //
  //     ),
  //   );
  // }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 25),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 30,
                ),
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget catagoryIcon(BusinessTypeModel category, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(BrowseCategoryAndSubcategoryScreen(
                businessId: category.id,
              ));
            },
            child: CircleAvatar(
              backgroundColor: Color(0x4DD9D9D9),
              radius: 30,
              child: SvgPicture.asset(
                categories[index]['icon'],
                height: 40,
                width: 40,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
