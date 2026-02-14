import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';

import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';

import '../../../../../../utils/constants.dart';
import '../../../../../utils/isRestaurantOepn.dart';
import '../../restaurent/controller/fillterAllRestaurntScreenController.dart';
import '../../restaurent/model/restaurentModel.dart';
import '../widgets/allRestaurentFillterWidget.dart';
import '../widgets/retaurent_shimmer.dart';
import 'browseRestaurentItem.dart';


class AllRestaurantsScreen extends StatefulWidget {
  String? cuisine;
  AllRestaurantsScreen({Key? key,this.cuisine}) : super(key: key);

  @override
  State<AllRestaurantsScreen> createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  late AllRestaurantsFilterController filterController;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    // Create or get the controller
    filterController = Get.put(AllRestaurantsFilterController());

    // Load restaurants based on categoryId
    print('📱 AllRestaurantsScreen initialized');
    print('📂 Category ID: ${widget.cuisine ?? "None"}');

    if (widget.cuisine != null && widget.cuisine!.isNotEmpty) {
      print("🔍 Loading restaurants for cuisine: ${widget.cuisine}");
      await filterController.loadRestaurantsByCuisine(widget.cuisine ?? "");
    } else {
      print("📂 Loading all restaurants");
      await filterController.loadRestaurants();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "All Restaurants", isFormBottamNav: false),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Widget
                  AllRestaurantsFilterWidget(controller: filterController),

                  const SizedBox(height: 12),

                  // Restaurant List
                  Obx(
                        () {
                      // Loading state
                      if (filterController.isLoading.value) {
                        return SizedBox(
                          height: 0.75.toHeightPercent(),
                          child: ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return const RestaurantShimmerCard();
                            },
                          ),
                        );
                      }

                      // Empty state
                      if (filterController.filteredRestaurants.isEmpty &&
                          filterController.allRestaurants.isNotEmpty) {
                        return SizedBox(
                          height: 0.75.toHeightPercent(),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_menu,
                                  size: 48,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  filterController.selectedFilter.value != null
                                      ? 'No restaurants found for "${filterController.selectedFilter.value}"'
                                      : 'No restaurants found',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    filterController.applyFilter(null);
                                  },
                                  child: const Text('Clear Filter'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // Restaurant List
                      return SizedBox(
                        height: 0.75.toHeightPercent(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount:
                          filterController.filteredRestaurants.length,
                          itemBuilder: (context, index) {
                            return RestaurantListCard(
                              restaurant: filterController
                                  .filteredRestaurants[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class RestaurantListCard extends StatelessWidget {
//   final Restaurant restaurant;
//
//   const RestaurantListCard({
//     Key? key,
//     required this.restaurant,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         //Get.to(BrowseRestaurentItems(restaurentId: restaurant.id!));
//         Get.to(() => BrowseProductsScreen(loadFor: LoadProductFor.forRestaurant, params: restaurant!.id));
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Image Container
//             Container(
//               alignment: Alignment.center,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       restaurant.coverImage,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey[300],
//                           child: const Center(
//                             child: Icon(Icons.image_not_supported),
//                           ),
//                         );
//                       },
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           color: Colors.grey[200],
//                           child: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Restaurant Info
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: AppColors.secondary,
//                         backgroundImage: NetworkImage(restaurant.logo),
//                       ),
//                       SizedBox(
//                         width: 0.02.toWidthPercent(),
//                       ),
//                       Text(
//                         restaurant.name ?? '',
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                   isRestaurantOpen(
//                   weeklyOffDay: restaurant.weeklyOffDay,
//                     startTime: restaurant.workingHours.start,
//                     endTime: restaurant.workingHours.end,
//                   ) ? 'Open Now' : 'Closed Now',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                           restaurant.cuisineTypes.isNotEmpty
//                               ? restaurant.cuisineTypes.first ?? ''
//                               : '',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             '${restaurant.restaurantType ?? ''}',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         ' • ${restaurant.address ?? ''}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   // Rating, Delivery Time Row
//                   Row(
//                     children: [
//                       Container(
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.flash_on_rounded,
//                               color: Colors.amber,
//                             ),
//                             Column(
//                               children: [
//                                 const Text("50% OFF"),
//                                 Text(
//                                   '+ more offers',
//                                   style: TextStyle(
//                                     fontSize: 8,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                       Container(
//                         width: 2,
//                         height: 30,
//                         color: Colors.black.withOpacity(0.6),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.star,
//                               color: AppColors.primary,
//                             ),
//                             const SizedBox(width: 4),
//                             Column(
//                               children: [
//                                 Text(
//                                   '${restaurant.rating}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Text(
//                                   '(5.2K)',
//                                   style: TextStyle(
//                                     fontSize: 8,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Container(
//                         width: 2,
//                         height: 30,
//                         color: Colors.black.withOpacity(0.6),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
//                         child: Row(
//                           children: [
//                             SvgPicture.asset(delivery_vehical),
//                             const SizedBox(width: 4),
//                             Column(
//                               children: [
//                                 Text(
//                                   '${restaurant.avgPreparationTime} mins',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const Text(
//                                   '/free',
//                                   style: TextStyle(
//                                     fontSize: 8,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
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
class RestaurantListCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListCard({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Container
            Container(
              alignment: Alignment.center,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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
                        backgroundColor: AppColors.secondary,
                        backgroundImage: NetworkImage(restaurant.logo),
                      ),
                      SizedBox(width: 0.02.toWidthPercent()),
                      Expanded(
                        child: Text(
                          restaurant.name ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Type Badge with Color
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Open/Closed Status
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
                  const SizedBox(height: 6),

                  // Cuisines Row
                  Text(
                    'Cuisines: ${restaurant.cuisineTypes.isNotEmpty ? restaurant.cuisineTypes.join(', ') : 'N/A'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Address
                  Text(
                    'Address: ${restaurant.address ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

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
      ),
    );
  }
}