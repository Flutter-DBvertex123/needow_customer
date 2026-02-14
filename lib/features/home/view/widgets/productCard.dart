import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/home/model/models/categoryAndSubCategoryModel.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/features/product/view/view_product_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/imageHandler.dart';

import '../../../product/controller/productContorller.dart';
import '../../controller/buisnessController.dart';
import '../../controller/categoryAndSubcategoryController.dart';
import '../dashboard_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

   ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ViewProductScreen(product: product,)),
      child: Container(
          height: 0.12.toHeightPercent(),
          width: 0.12.toHeightPercent(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary),
            color: AppColors.primary,
          ),
          child:  Column(
            children: [
              Container(
                alignment: Alignment.center,
                  width: 0.8.toWidthPercent(),
                  height: 0.08.toHeightPercent(),
                  decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          //child: Image.asset(productImage)
                         child:  SafeNetworkImage(
                            url: (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                                ? product.imageUrl![0]
                                : "",
                          )
                        //child: Image.network(product.imageUrl[0]),
                      ),
                      product.isPrescriptionRequired ?? false ? Positioned(
                        top: 4,
                        left: 4,
                          child: Icon(Icons.health_and_safety,color: AppColors.primary,)) : SizedBox(),
                    ],
                  )),
              Container(
                height: 0.03.toHeightPercent(),
                color: AppColors.primary,
                alignment: Alignment.center,
                child: Text(product?.name ?? "",style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
              )
            ],
          )
      ),
      // child: Container(
      //   width: 0.27.toWidthPercent(),
      //   decoration: BoxDecoration(
      //
      //     border: Border.all(
      //       color: AppColors.primary,
      //       width: 3,
      //     ),
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   child: Column(
      //     children: [
      //       Container(
      //         alignment: Alignment.center,
      //           //height: 74.15,
      //         child: ClipRRect(
      //           borderRadius: BorderRadiusGeometry.circular(4),
      //           child: Image.asset(
      //             productImage,
      //             fit: BoxFit.fill,
      //
      //           ),
      //             //child: SafeNetworkImage(url: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png")
      //           //child: Image.network("https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png",fit: BoxFit.fill,),
      //         ),
      //       ),
      //       //SafeNetworkImage(url: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png")
      //       SizedBox(height: 8),
      //       Container(
      //         alignment: Alignment.center,
      //         height: 40,
      //         width: 1.toWidthPercent(),
      //         color: AppColors.primary,
      //         child: Text(
      //           product.name,
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //             fontSize: 12,
      //             color: Colors.white,
      //             fontWeight: FontWeight.w600,
      //           ),
      //           maxLines: 2,
      //           overflow: TextOverflow.ellipsis,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}


// class CategoryCard extends StatelessWidget {
//   final CategoryModel product;
//
//    CategoryCard({Key? key, required this.product}) : super(key: key);
//   final businessCon = Get.find<BusinessController>();
//   final categoryCon = Get.find<CategoryAndSubcategoryController>();
//
//   Future<List<CategoryModel>> _getCategory() async {
//     String type = await businessCon.getBusinessAllTypes().then((value) => value[0].id);
//     return categoryCon.getCategories(type);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => {},//Get.to(ViewProductScreen(product: product,)),
//       child: Container(
//           height: 0.12.toHeightPercent(),
//           width: 0.12.toHeightPercent(),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: AppColors.primary),
//             color: AppColors.primary,
//           ),
//           child:  Column(
//             children: [
//               Container(
//                   width: 0.8.toWidthPercent(),
//                   height: 0.08.toHeightPercent(),
//                   decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//
//                   child: ClipRRect(
//                       borderRadius: BorderRadiusGeometry.circular(10),
//                       child: Image.asset(productImage))),
//               Container(
//                 height: 0.03.toHeightPercent(),
//                 color: AppColors.primary,
//                 alignment: Alignment.center,
//                 child: Text(product.name,style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
//               )
//             ],
//           )
//       ),
//       // child: Container(
//       //   width: 0.27.toWidthPercent(),
//       //   decoration: BoxDecoration(
//       //
//       //     border: Border.all(
//       //       color: AppColors.primary,
//       //       width: 3,
//       //     ),
//       //     borderRadius: BorderRadius.circular(8),
//       //   ),
//       //   child: Column(
//       //     children: [
//       //       Container(
//       //         alignment: Alignment.center,
//       //           //height: 74.15,
//       //         child: ClipRRect(
//       //           borderRadius: BorderRadiusGeometry.circular(4),
//       //           child: Image.asset(
//       //             productImage,
//       //             fit: BoxFit.fill,
//       //
//       //           ),
//       //             //child: SafeNetworkImage(url: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png")
//       //           //child: Image.network("https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png",fit: BoxFit.fill,),
//       //         ),
//       //       ),
//       //       //SafeNetworkImage(url: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png")
//       //       SizedBox(height: 8),
//       //       Container(
//       //         alignment: Alignment.center,
//       //         height: 40,
//       //         width: 1.toWidthPercent(),
//       //         color: AppColors.primary,
//       //         child: Text(
//       //           product.name,
//       //           textAlign: TextAlign.center,
//       //           style: TextStyle(
//       //             fontSize: 12,
//       //             color: Colors.white,
//       //             fontWeight: FontWeight.w600,
//       //           ),
//       //           maxLines: 2,
//       //           overflow: TextOverflow.ellipsis,
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }