import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/view/widgets/recommneded_restaurant_shimmer.dart';
import 'package:newdow_customer/utils/getSize.dart';
import '../../../../utils/apptheme.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/isRestaurantOepn.dart';
import '../../../browseProducts/view/browse_products_screen.dart';
import '../../foodSection/restaurent/model/restaurentModel.dart';
import '../../foodSection/view/screens/allRestaurentScreen.dart';
import '../../foodSection/view/screens/browseRestaurentItem.dart';
import 'controller/recommendedRestaurantsController.dart';



class CompactRecommendedRestaurants extends StatelessWidget {
  CompactRecommendedRestaurants({super.key});

  final RecommendedRestaurantController controller =
  RecommendedRestaurantController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: controller.loadRestaurants(),
      builder: (context, snapshot) {
        /// Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 230,
            child: Center(child: RecommendedRestaurantShimmer()),
          );
        }

        /// Error
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        /// Empty
        final restaurants = snapshot.data ?? [];
        if (restaurants.isEmpty) {
          return const SizedBox.shrink();
        }

        /// Success UI
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Recommended Restaurants",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 0.3.toHeightPercent(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: restaurants.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  //return _RestaurantCard(restaurants[index]);
                 return _RestaurantCard(restaurant: restaurants[index]);}
              )
            ),
          ],
        );
      },
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const _RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  Color getRestaurantTypeColor() {
    switch (restaurant.restaurantType?.toLowerCase()) {
      case 'veg':
      case 'vegetarian':
        return Colors.green;
      case 'non-veg':
      case 'non-vegetarian':
        return Colors.red;
      case 'mixed':
        return Colors.yellow[700] ?? Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BrowseProductsScreen(
            loadFor: LoadProductFor.forRestaurant,
            params: restaurant!.id));

      },
      child: Container(
        height: 0.25.toHeightPercent(),
        width: 0.5.toWidthPercent(),
        margin: const EdgeInsets.only(bottom: 12.0),
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
        child: Stack(

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Container
                Container(
                  alignment: Alignment.center,
                  height: 0.16.toHeightPercent(),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          restaurant.coverImage,
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
                // Restaurant Info
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Name with Type Badge
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.secondary,
                            backgroundImage: NetworkImage(restaurant.logo),
                          ),
                          SizedBox(width: 0.02.toWidthPercent()),
                          Expanded(
                            child: Text(
                              restaurant.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // Type Badge with Color


                        ],
                      ),
                      const SizedBox(height: 8),

                      // Open/Closed Status
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isRestaurantOpen(
                              weeklyOffDay: restaurant.weeklyOffDay,
                              startTime: restaurant.workingHours.start,
                              endTime: restaurant.workingHours.end,
                            )
                                ? 'Open Now'
                                : 'Closed Now',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isRestaurantOpen(
                                weeklyOffDay: restaurant.weeklyOffDay,
                                startTime: restaurant.workingHours.start,
                                endTime: restaurant.workingHours.end,
                              )
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          Text(
                            'Cuisines: ${restaurant.cuisineTypes.isNotEmpty ? restaurant.cuisineTypes.join(', ') : 'N/A'}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        'Prepration Time: ${restaurant.avgPreparationTime.toString()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                     // const SizedBox(height: 6),

                      // Cuisines Row
                      // Text(
                      //   'Cuisines: ${restaurant.cuisineTypes.isNotEmpty ? restaurant.cuisineTypes.join(', ') : 'N/A'}',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey[600],
                      //   ),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      //const SizedBox(height: 4),

                      // // Address
                      // Text(
                      //   'Address: ${restaurant.address ?? 'N/A'}',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey[600],
                      //   ),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      //const SizedBox(height: 12),

                      // Rating, Delivery Time Row
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         child: Row(
                      //           children: [
                      //             const Icon(
                      //               Icons.flash_on_rounded,
                      //               color: Colors.amber,
                      //               size: 16,
                      //             ),
                      //             const SizedBox(width: 4),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Text(
                      //                   "50% OFF",
                      //                   style: TextStyle(fontSize: 11),
                      //                 ),
                      //                 Text(
                      //                   '+ more offers',
                      //                   style: TextStyle(
                      //                     fontSize: 8,
                      //                     color: AppColors.textSecondary,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 1,
                      //       height: 30,
                      //       color: Colors.black.withOpacity(0.2),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8),
                      //         child: Row(
                      //           children: [
                      //             const Icon(
                      //               Icons.star,
                      //               color: AppColors.primary,
                      //               size: 16,
                      //             ),
                      //             const SizedBox(width: 4),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   '${restaurant.rating}',
                      //                   style: const TextStyle(
                      //                     fontSize: 11,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black87,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '(5.2K)',
                      //                   style: TextStyle(
                      //                     fontSize: 8,
                      //                     color: AppColors.textSecondary,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: 1,
                      //       height: 30,
                      //       color: Colors.black.withOpacity(0.2),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8),
                      //         child: Row(
                      //           children: [
                      //             SvgPicture.asset(delivery_vehical, width: 16),
                      //             const SizedBox(width: 4),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   '${restaurant.avgPreparationTime} mins',
                      //                   style: const TextStyle(
                      //                     fontSize: 11,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black87,
                      //                   ),
                      //                 ),
                      //                 const Text(
                      //                   '/free',
                      //                   style: TextStyle(
                      //                     fontSize: 8,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black87,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                    ],
                  ),
                ),
              ],
            ),
        Positioned(
          top:8,
          right: 6,
          child:  Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: getRestaurantTypeColor(),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              restaurant.restaurantType ?? 'Mixed',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: (restaurant.restaurantType?.toLowerCase() ==
                    'mixed' ||
                    restaurant.restaurantType?.toLowerCase() ==
                        'mixed veg')
                    ? Colors.black
                    : Colors.white,
              ),
            ),

          ),)
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/imageHandler.dart';
//
// // Dummy Restaurant Model
//
//
// class CompactRecommendedRestaurants extends StatelessWidget {
//   final List<RestaurantModel> restaurants;
//   final VoidCallback? onSeeAll;
//   final Function(RestaurantModel)? onRestaurantTap;
//
//   const CompactRecommendedRestaurants({
//     Key? key,
//     required this.restaurants,
//     this.onSeeAll,
//     this.onRestaurantTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (restaurants.isEmpty) return const SizedBox.shrink();
//
//     return SliverToBoxAdapter(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Recommended Restaurants",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 if (onSeeAll != null)
//                   InkWell(
//                     onTap: onSeeAll,
//                     child: Text(
//                       "See All",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColors.primary,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 0.23.toHeightPercent(),
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               scrollDirection: Axis.horizontal,
//               itemCount: restaurants.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (context, index) {
//                 final restaurant = restaurants[index];
//                 return _CompactRestaurantCard(
//                   restaurant: restaurant,
//                   onTap: () {
//                     print('Tapped on: ${restaurant.name}');
//                     onRestaurantTap?.call(restaurant);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CompactRestaurantCard extends StatelessWidget {
//   final RestaurantModel restaurant;
//   final VoidCallback? onTap;
//
//   const _CompactRestaurantCard({
//     required this.restaurant,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 140,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(12),
//                   ),
//                   child: Image.network(
//                     restaurant.imageUrl ?? '',
//                     height: 100,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         height: 100,
//                         color: Colors.grey[300],
//                         child: const Icon(
//                           Icons.restaurant,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 if (restaurant.rating != null && restaurant.rating! > 0)
//                   Positioned(
//                     top: 6,
//                     right: 6,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 6,
//                         vertical: 3,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.star, color: Colors.white, size: 10),
//                           const SizedBox(width: 2),
//                           Text(
//                             restaurant.rating!.toStringAsFixed(1),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     restaurant.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   if (restaurant.cuisineType != null &&
//                       restaurant.cuisineType!.isNotEmpty)
//                     Text(
//                       restaurant.cuisineType!.first,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       if (restaurant.deliveryTime != null)
//                         Row(
//                           children: [
//                             Icon(Icons.access_time,
//                                 size: 12, color: Colors.grey[600]),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${restaurant.deliveryTime} min',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       if (restaurant.priceRange != null)
//                         Text(
//                           restaurant.priceRange!,
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }