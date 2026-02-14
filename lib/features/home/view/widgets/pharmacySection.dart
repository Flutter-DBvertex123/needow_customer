//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/home/view/widgets/productCard.dart';
// import 'package:newdow_customer/utils/getSize.dart';
//
// import '../../../product/controller/productContorller.dart';
// import '../../../product/models/model/ProductModel.dart';
// import '../dashboard_screen.dart';
// import 'foodSection.dart';
//
// class PharmacySection extends StatefulWidget {
//   const PharmacySection({Key? key}) : super(key: key);
//
//   @override
//   State<PharmacySection> createState() => _PharmacySectionState();
// }
//
// class _PharmacySectionState extends State<PharmacySection> {
//   final prodouctController = Get.find<ProductController>();
//
//
//   @override
//   Widget build(BuildContext context) {
//    // final pharmacyProducts = DummyData.pharmacyProducts;
//
//     return SliverToBoxAdapter(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Pharmacy',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'See All',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             constraints: BoxConstraints(maxHeight: 0.14.toHeightPercent()),
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: SliverToBoxAdapter(
//               child: FutureBuilder(
//                 future: prodouctController.getProducts(3, 1,""),
//                 builder: (context, asyncSnapshot) {
//                   final data = asyncSnapshot.data!;
//                   return ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: data.length,
//                     separatorBuilder: (context,index) => SizedBox(width: 14),
//                     itemBuilder: (context, index) {
//                       return ProductCard(product: data![index]);
//                     },
//                   );
//                 }
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
import 'package:newdow_customer/features/home/view/widgets/productCard.dart';
import 'package:newdow_customer/features/home/view/widgets/productShemmer.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/apptheme.dart';

import '../../../address/controller/addressController.dart';
import '../../../product/controller/productContorller.dart';
import '../../../product/models/model/ProductModel.dart';
import '../../controller/buisnessController.dart';
import '../../controller/categoryAndSubcategoryController.dart';
import '../../model/models/categoryAndSubCategoryModel.dart';

/*
class PharmacySection extends StatefulWidget {
  const PharmacySection({Key? key}) : super(key: key);

  @override
  State<PharmacySection> createState() => _PharmacySectionState();
}

class _PharmacySectionState extends State<PharmacySection> {
  final prodouctController = Get.find<ProductController>();
  final businessCon = Get.find<BusinessController>();
  final categoryCon = Get.find<CategoryAndSubcategoryController>();

  Future<List<ProductModel>> _getCategory() async {
    String type = await businessCon.getBusinessAllTypes().then((
        value) => value[2].id);
    return await prodouctController.getProductByBusinessType(type,5,1);

  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pharmacy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(BrowseProductsScreen(loadFor: LoadProductFor.fromBusinessType, params: businessCon.businessTypes[2].id,));
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Products List (FutureBuilder)
             Container(
               height: 0.12.toHeightPercent(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<List<ProductModel>>(
                //future: prodouctController.getProducts(5, "medicine"),
                future: _getCategory(),
                builder: (context, snapshot) {
                  print("right here ${snapshot.data?.length}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Productshemmer());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No products found"));
                  }
            
                  final data = snapshot.data!;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    separatorBuilder: (context, index) => SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      return ProductCard(product: data[index]);
                    },
                  );
                },
              ),
            ),

        ],
      ),
    );
  }

}
*/
class PharmacySection extends StatefulWidget {
  const PharmacySection({Key? key}) : super(key: key);

  @override
  State<PharmacySection> createState() => _PharmacySectionState();
}

class _PharmacySectionState extends State<PharmacySection> {
  final prodouctController = Get.find<ProductController>();
  final businessCon = Get.find<BusinessController>();
  final addressCtrl = Get.find<AddressController>();

  Future<List<ProductModel>> _getPharmacyProducts(String businessId) async {
    return await prodouctController.getProductByBusinessType(
      businessId,
      5,
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 🚨 SAFETY CHECK (index 2 required)
    if (businessCon.businessTypes.length < 2) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    final business = businessCon.businessTypes.where((b) => b.name.toLowerCase() == 'medicine').first;
    //final business = businessCon.businessTypes[1];
    final userCity = addressCtrl.defaultAddress.value?.city;

    // final isServiceAvailable =
    //     userCity != null && business.cities.contains(userCity);
    final isServiceAvailable =
        userCity != null &&
            business.cities.any(
                  (c) => c.city.toLowerCase() == userCity.toLowerCase(),
            );
    if (businessCon.businessTypes.length < 3) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
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
                  'Pharmacy',
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
                  ) : SizedBox(),
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
              future: _getPharmacyProducts(business.id),
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

                final data = snapshot.data!;

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return ProductCard(product: data[index]);
                  },
                );
              },
            )
                : Center(
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
