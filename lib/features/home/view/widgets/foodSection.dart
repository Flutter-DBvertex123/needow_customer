/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/home/view/widgets/productCard.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../product/controller/productContorller.dart';
import '../dashboard_screen.dart';

class FoodSection extends StatefulWidget {
  const FoodSection({Key? key}) : super(key: key);

  @override
  State<FoodSection> createState() => _FoodSectionState();
}
final prodouctController = Get.find<ProductController>();
List<ProductModel>? products;
@override

class _FoodSectionState extends State<FoodSection> {
  @override
  Widget build(BuildContext context) {
    final foodProducts = DummyData.foodProducts;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
                constraints: BoxConstraints(maxHeight: 0.14.toHeightPercent()),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SliverToBoxAdapter(
                  child: FutureBuilder(
                    future: prodouctController.getProducts(3, 1, ""),
                    builder: (context, asyncSnapshot) {
                      final data = asyncSnapshot.data!;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: data![index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(width: 14),
                      );
                    }
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_category_and_subcategory_screen.dart';
import 'package:newdow_customer/features/home/controller/categoryAndSubcategoryController.dart';
import 'package:newdow_customer/features/home/model/models/buisness_type_model.dart';
import 'package:newdow_customer/features/home/view/widgets/productCard.dart';
import 'package:newdow_customer/features/home/view/widgets/productShemmer.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../../utils/apptheme.dart';
import '../../../../utils/constants.dart';
import '../../../browseProducts/view/browse_products_screen.dart';
import '../../../product/controller/productContorller.dart';
import '../../controller/buisnessController.dart';
import '../../model/models/categoryAndSubCategoryModel.dart';

class FoodSection extends StatefulWidget {
 const  FoodSection({Key? key}) : super(key: key);

  @override
  State<FoodSection> createState() => _FoodSectionState();
}

class _FoodSectionState extends State<FoodSection> {

  final prodouctController = Get.find<ProductController>();
  final businessCon = Get.find<BusinessController>();
  final categoryCon = Get.find<CategoryAndSubcategoryController>();
  final addressCtrl = Get.find<AddressController>();

  Future<List<ProductModel>> _getCategory() async {
    // String type = await businessCon.getBusinessAllTypes().then((
    //     value) => value[0].id);
    String type = await businessCon.businessTypes.value.first.id;
    print("getting to fetch $type");
    final data = await prodouctController.getProductByBusinessType(type,5,1);
    print("data of product of grocery ${data[0].name}");
    return data;
  }
  @override
  Widget build(BuildContext context) {
    // 🚨 SAFETY CHECK
    if (businessCon.businessTypes.length == 0) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    final business = businessCon.businessTypes.value.first;

    final userCity = addressCtrl.defaultAddress.value?.city;
    print("user city$userCity");
    print(business.cities.contains(userCity));
    final isServiceAvailable =
        userCity != null && business.cities.contains(userCity);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Food',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(
                    BrowseProductsScreen(
                      loadFor: LoadProductFor.fromBusinessType,
                      params: business.id,
                    ),
                  ),

                  child: isServiceAvailable ? Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ) : SizedBox()
                ),
              ],
            ),
          ),

          /// CONTENT
          Container(
            height: 0.12.toHeightPercent(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: isServiceAvailable
                ? FutureBuilder<List<ProductModel>>(
              future: prodouctController
                  .getProductByBusinessType(business.id, 5, 1),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Productshemmer();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No products found"),
                  );
                }

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: snapshot.data![index],
                    );
                  },
                );
              },
            )
                :  Center(
              child: Column(
                children: [
                  SvgPicture.asset(out_of_service_area,height: 0.08.toHeightPercent(),width: 300,),
                  Text("Your are out of service")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
import 'package:newdow_customer/features/home/foodSection/view/screens/allRestaurentScreen.dart';
import 'package:newdow_customer/features/home/foodSection/view/screens/food_dashboard_screen.dart';
import 'package:newdow_customer/features/home/view/widgets/productCard.dart';
import 'package:newdow_customer/features/home/view/widgets/productShemmer.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import '../../../product/controller/productContorller.dart';
import '../../controller/buisnessController.dart';

class FoodSection extends StatelessWidget {
  const FoodSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodouctController = Get.find<ProductController>();
    final businessCon = Get.find<BusinessController>();
    final addressCtrl = Get.find<AddressController>();

    return SliverToBoxAdapter(
      child: Obx(() {
        // 🚨 SAFETY CHECK - wait for business types to load
        if (businessCon.businessTypes.isEmpty) {
          return const SizedBox.shrink();
        }

        final business = businessCon.businessTypes.where((b) => b.name.toLowerCase() == 'food').first;
        final userCity = addressCtrl.defaultAddress.value?.city;
        // final isServiceAvailable =
        //     userCity != null && business.cities.contains(userCity);
        final isServiceAvailable =
            userCity != null &&
                business.cities.any(
                      (c) => c.city.toLowerCase() == userCity.toLowerCase(),
                );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Food',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.to(
                      // BrowseProductsScreen(
                      //   loadFor: LoadProductFor.fromBusinessType,
                      //   params: business.id,
                      // ),
                      //AllRestaurantsScreen()
                      FoodHomeScreen(businessTypeId: business.id)
                    ),
                    child: isServiceAvailable
                        ? Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),

            /// CONTENT
            Container(
              height: 0.12.toHeightPercent(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isServiceAvailable
                  ? FutureBuilder<List<ProductModel>>(
                future: prodouctController.getProductByBusinessType(
                  business.id,
                  5,
                  1,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Productshemmer();
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No products found"),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: snapshot.data![index],
                      );
                    },
                  );
                },
              )
                  : Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      out_of_service_area,
                      height: 0.08.toHeightPercent(),
                      width: 300,
                    ),
                    const Text("You are out of service area")
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}