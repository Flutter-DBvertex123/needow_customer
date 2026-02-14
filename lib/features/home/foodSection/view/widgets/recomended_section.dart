import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/product/view/view_product_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';

import '../../../../browseProducts/view/browse_category_and_subcategory_screen.dart';
import '../../../../product/controller/productContorller.dart';
import '../../../../product/models/model/ProductModel.dart';
import '../../../view/widgets/productShemmer.dart';
import '../../restaurent/controller/recomendedProductContrller.dart';

// import '../../../../../browseProducts/view/browse_category_and_subcategory_screen.dart';

// class RecommendedSection extends StatelessWidget {
//   String businessId;
//    RecommendedSection({Key? key,required this.businessId}) : super(key: key);
//   final prodouctController = Get.find<ProductController>();
//   @override
//   Widget build(BuildContext context) {
//     final products = [
//       {'name': 'South Indian', 'image': 'https://via.placeholder.com/250?text=South+Indian'},
//       {'name': 'Indian Thai', 'image': 'https://via.placeholder.com/250?text=Indian+Thai'},
//       {'name': 'Biryani', 'image': 'https://via.placeholder.com/250?text=Biryani'},
//       {'name': 'Dosa', 'image': 'https://via.placeholder.com/250?text=Dosa'},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Recommended for you',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Get.to(BrowseCategoryAndSubcategoryScreen(businessId: "",)),
//                 child: const Text(
//                   'See all',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // SizedBox(
//         //   height: 0.22.toHeightPercent(),
//         //   child: ListView.separated(
//         //     shrinkWrap: true,
//         //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //     scrollDirection: Axis.horizontal,
//         //     // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         //     //   crossAxisCount: 2,
//         //     //   crossAxisSpacing: 12,
//         //     //   mainAxisSpacing: 12,
//         //     //   childAspectRatio: 0.85,
//         //     // ),
//         //     separatorBuilder: (context,index){
//         //       return SizedBox(width: 12,);
//         //     },
//         //     itemCount: products.length,
//         //     itemBuilder: (context, index) {
//         //       return RecommendedProductCard(
//         //         product: products[index],
//         //       );
//         //     },
//         //   ),
//         // ),
//         FutureBuilder<List<ProductModel>>(
//           future: prodouctController.getProductByBusinessType(
//             businessId,
//             5,
//             1,
//           ),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return SizedBox(
//                 height: 0.22.toHeightPercent(),
//                 child: const Productshemmer(),
//               );
//             }
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return SizedBox(
//                 height: 0.22.toHeightPercent(),
//                 child: const Center(child: Text("No products found")),
//               );
//             }
//
//             List<ProductModel> recomendedProducts = snapshot.data!.where((product) => product.isRecommended == true).toList();
//             return SizedBox(
//               height: 0.22.toHeightPercent(),
//               child: ListView.separated(
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   scrollDirection: Axis.horizontal,
//                   // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   //   crossAxisCount: 2,
//                   //   crossAxisSpacing: 12,
//                   //   mainAxisSpacing: 12,
//                   //   childAspectRatio: 0.85,
//                   // ),
//                   separatorBuilder: (context,index){
//                     return SizedBox(width: 12,);
//                   },
//                   itemCount: recomendedProducts.length,
//                   itemBuilder: (context, index) {
//                     return RecommendedProductCard(
//                       product: recomendedProducts[index],
//                     );
//                   },
//                 ),
//             );
//           },
//         ),
//          SizedBox(height: 16),
//       ],
//     );
//   }
// }
class RecommendedSection extends StatefulWidget {
  final String businessId;
   RecommendedSection({Key? key, required this.businessId})
      : super(key: key);

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  final productController = Get.find<RecomendedProductController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    productController.reset();
    productController.loadRecommendedProducts(widget.businessId);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        productController.loadRecommendedProducts(widget.businessId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // GestureDetector(
              //   onTap: () => Get.to(
              //     BrowseCategoryAndSubcategoryScreen(businessId: ""),
              //   ),
              //   child: const Text(
              //     'See all',
              //     style: TextStyle(fontSize: 14, color: AppColors.primary),
              //   ),
              // ),
            ],
          ),
        ),

        /// Products
        SizedBox(
          height: 0.22.toHeightPercent(),
          child: Obx(() {
            if (productController.recommendedProducts.isEmpty &&
                productController.isLoading.value) {
              return const Productshemmer();
            }

            return ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: productController.recommendedProducts.length +
                  (productController.hasMore.value ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (index ==
                    productController.recommendedProducts.length) {
                  return const SizedBox(
                    width: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return RecommendedProductCard(
                  product: productController.recommendedProducts[index],
                );
              },
            );
          }),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}


class RecommendedProductCard extends StatelessWidget {
  final ProductModel product;

  const RecommendedProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ViewProductScreen(product: product));
      },
      child: Container(
        width: 0.2.toHeightPercent(),
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
            // Image Container with fixed constraints
            Expanded(
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  maxHeight: 160,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                       product.imageUrl?[0] ?? '',
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
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  /*Row(
                    children: [
                      const Icon(Icons.star, size: 13, color: Colors.amber),
                      const SizedBox(width: 3),
                      const Text(
                        '4.5',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(250)',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}