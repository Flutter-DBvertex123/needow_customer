//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:newdow_customer/features/home/foodSection/view/widgets/retaurent_shimmer.dart';
// // import 'package:newdow_customer/features/home/foodSection/restaurent/view/screens/browseRestaurentItem.dart';
// // import 'package:newdow_customer/features/home/foodSection/restaurent/view/widgets/retaurent_shimmer.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:shimmer/shimmer.dart';
//
// // import '../../../restaurent/controller/restaurentController.dart';
// // import '../../../restaurent/model/restaurentModel.dart';
// import '../../restaurent/controller/restaurentController.dart';
// import '../../restaurent/model/restaurentModel.dart';
// import '../screens/allRestaurentScreen.dart';
// import '../screens/browseRestaurentItem.dart';
//
// class RestaurantSection extends StatelessWidget {
//   RestaurantSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Get.find<ResturentController>().getRestaurents("active"),
//       builder: (context, asyncSnapshot) {
//         List<Restaurant> restaurants = asyncSnapshot.data?.restaurants ?? [];
//         if(asyncSnapshot.connectionState == ConnectionState.waiting){
//           return SliverMainAxisGroup(
//             slivers: [
//               // Header shimmer
//               // SliverToBoxAdapter(
//               //   child: Padding(
//               //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//               //     child: Row(
//               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //       children: [
//               //         shimmerBox(height: 20, width: 150),
//               //         shimmerBox(height: 16, width: 60),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//
//               // Restaurant list shimmer
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: 5,
//                         (context, index) => const RestaurantShimmerCard(),
//                   ),
//                 ),
//               ),
//
//               const SliverToBoxAdapter(child: SizedBox(height: 16)),
//             ],
//           );
//         }
//
//         Widget shimmerBox({required double height, required double width}) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               height: height,
//               width: width,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//           );
//         }
//         if(asyncSnapshot.hasError){
//           return Center(child: Text('Error: ${asyncSnapshot.error}'));
//         }
//         if(restaurants.isEmpty){
//           return const Center(child: Text('No Restaurants Available'));
//         }
//
//         return SliverMainAxisGroup(
//           slivers: [
//             // Header Section
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Open Restaurants',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.to(AllRestaurantsScreen()),
//                       child: const Text(
//                         'See all',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Restaurant List
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                     return RestaurantListCard(
//                       restaurant: restaurants[index],
//                     );
//                   },
//                   childCount: restaurants.length,
//                 ),
//               ),
//             ),
//             // Bottom Spacing
//             const SliverToBoxAdapter(
//               child: SizedBox(height: 16),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
//   @override
//   Widget build(BuildContext context,final Map<String, dynamic> restaurant) {
//     return GestureDetector(
//       onTap: () {
//        Get.to(BrowseRestaurentItems(restaurentId: restaurant['id'],));
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
//             // Image Container with discount badge
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(12),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                     ),
//                     child: Image.network(
//                       "https://plus.unsplash.com/premium_photo-1673108852141-e8c3c22a4a22?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1740" ?? '',
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
//                 ),
//                 // Discount Badge
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       restaurant['discount'] ?? '',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Status Badge (Open/Closed)
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: restaurant['isOpen']
//                           ? Colors.green
//                           : Colors.grey,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       restaurant['isOpen'] ? 'Open' : 'Closed',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Restaurant Info
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     restaurant['name'] ?? '',
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     restaurant['cuisines'] ?? '',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.star, size: 14, color: Colors.amber),
//                           const SizedBox(width: 4),
//                           Text(
//                             '${restaurant['rating']}',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             '(${restaurant['reviews']})',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.schedule, size: 14, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Text(
//                             restaurant['deliveryTime'] ?? '',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/foodSection/view/widgets/retaurent_shimmer.dart';
//
// import '../../../../../utils/apptheme.dart';
// import '../../restaurent/controller/restaurentController.dart';
// import '../../restaurent/model/restaurentModel.dart';
// import '../screens/allRestaurentScreen.dart';
//
// class RestaurantSection extends StatefulWidget {
//   final String? selectedFilter;
//
//   RestaurantSection({Key? key, this.selectedFilter}) : super(key: key);
//
//   @override
//   State<RestaurantSection> createState() => _RestaurantSectionState();
// }
//
// class _RestaurantSectionState extends State<RestaurantSection> {
//   late List<Restaurant> filteredRestaurants;
//
//   @override
//   void initState() {
//     super.initState();
//     filteredRestaurants = [];
//     _applyFilter();
//   }
//
//   @override
//   void didUpdateWidget(RestaurantSection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update filtered restaurants when selected filter changes
//     if (widget.selectedFilter != oldWidget.selectedFilter) {
//       print('🔄 Filter changed from ${oldWidget.selectedFilter} to ${widget.selectedFilter}');
//       _applyFilter();
//     }
//   }
//
//   void _applyFilter() {
//     final controller = Get.find<ResturentController>();
//     final restaurants = controller.restaurantList;
//
//     print('📋 Total restaurants in controller: ${restaurants.length}');
//     print('🔍 Applying filter: ${widget.selectedFilter}');
//
//     setState(() {
//       if (widget.selectedFilter == null || widget.selectedFilter!.isEmpty) {
//         filteredRestaurants = List.from(restaurants);
//         print('✅ No filter - showing ${filteredRestaurants.length} restaurants');
//       } else {
//         filteredRestaurants = restaurants
//             .where((restaurant) {
//           final matches = restaurant.restaurantType == widget.selectedFilter;
//           if (matches) {
//             print('✓ ${restaurant.name} matches filter');
//           }
//           return matches;
//         })
//             .toList();
//         print('✅ Filter applied - showing ${filteredRestaurants.length} restaurants');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Check if restaurants are loaded
//     final controller = Get.find<ResturentController>();
//     final isLoading = controller.restaurantList.isEmpty && controller.filters.isEmpty;
//
//     if (isLoading) {
//       return SliverMainAxisGroup(
//         slivers: [
//           // Header Section
//           SliverToBoxAdapter(
//             child: Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               child: const Text(
//                 'Open Restaurants',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           // Loading shimmer
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 childCount: 5,
//                     (context, index) => const RestaurantShimmerCard(),
//               ),
//             ),
//           ),
//           const SliverToBoxAdapter(child: SizedBox(height: 16)),
//         ],
//       );
//     }
//
//     return SliverMainAxisGroup(
//       slivers: [
//         // Header Section
//         SliverToBoxAdapter(
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Open Restaurants',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => Get.to(AllRestaurantsScreen()),
//                   child: const Text(
//                     'See all',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // Results count
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               '${filteredRestaurants.length} restaurants found',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//         ),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 8)),
//
//         // Restaurant List
//         if (filteredRestaurants.isNotEmpty)
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   return RestaurantListCard(
//                     restaurant: filteredRestaurants[index],
//                   );
//                 },
//                 childCount: filteredRestaurants.length,
//               ),
//             ),
//           ),
//
//         // Empty state when no restaurants match filter
//         if (filteredRestaurants.isEmpty && controller.restaurantList.isNotEmpty)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.restaurant_menu,
//                     size: 48,
//                     color: Colors.grey[300],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     widget.selectedFilter != null
//                         ? 'No restaurants found for "${widget.selectedFilter}"'
//                         : 'No restaurants found',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//         // Bottom Spacing
//         const SliverToBoxAdapter(
//           child: SizedBox(height: 16),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/foodSection/view/widgets/retaurent_shimmer.dart';
//
// import '../../../../../utils/apptheme.dart';
// import '../../restaurent/controller/restaurentController.dart';
// import '../../restaurent/model/restaurentModel.dart';
// import '../screens/allRestaurentScreen.dart';
//
// class RestaurantSection extends StatefulWidget {
//   final String? selectedFilter;
//
//   RestaurantSection({Key? key, this.selectedFilter}) : super(key: key);
//
//   @override
//   State<RestaurantSection> createState() => _RestaurantSectionState();
// }
//
// class _RestaurantSectionState extends State<RestaurantSection> {
//   late RxList<Restaurant> filteredRestaurants;
//
//   @override
//   void initState() {
//     super.initState();
//     filteredRestaurants = <Restaurant>[].obs;
//     _applyFilter();
//   }
//
//   @override
//   void didUpdateWidget(RestaurantSection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update filtered restaurants when selected filter changes
//     if (widget.selectedFilter != oldWidget.selectedFilter) {
//       print('🔄 Filter changed from ${oldWidget.selectedFilter} to ${widget.selectedFilter}');
//       _applyFilter();
//     }
//   }
//
//   void _applyFilter() {
//     final controller = Get.find<ResturentController>();
//     final restaurants = controller.restaurantList;
//
//     print('📋 Total restaurants in controller: ${restaurants.length}');
//     print('🔍 Applying filter: ${widget.selectedFilter}');
//
//     if (widget.selectedFilter == null || widget.selectedFilter!.isEmpty) {
//       filteredRestaurants.assignAll(restaurants);
//       print('✅ No filter - showing ${filteredRestaurants.length} restaurants');
//     } else {
//       final filtered = restaurants
//           .where((restaurant) {
//         final matches = restaurant.restaurantType == widget.selectedFilter;
//         if (matches) {
//           print('✓ ${restaurant.name} matches filter');
//         }
//         return matches;
//       })
//           .toList();
//       filteredRestaurants.assignAll(filtered);
//       print('✅ Filter applied - showing ${filteredRestaurants.length} restaurants');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Check if restaurants are loaded
//     final controller = Get.find<ResturentController>();
//
//     return Obx(
//           () {
//         final isLoading =
//             controller.restaurantList.isEmpty && controller.filters.isEmpty;
//
//         if (isLoading) {
//           return SliverMainAxisGroup(
//             slivers: [
//               // Header Section
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 12.0),
//                   child: const Text(
//                     'Open Restaurants',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               // Loading shimmer
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: 5,
//                         (context, index) => const RestaurantShimmerCard(),
//                   ),
//                 ),
//               ),
//               const SliverToBoxAdapter(child: SizedBox(height: 16)),
//             ],
//           );
//         }
//
//         return SliverMainAxisGroup(
//           slivers: [
//             // Header Section
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Open Restaurants',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.to(AllRestaurantsScreen()),
//                       child: const Text(
//                         'See all',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Results count
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   '${filteredRestaurants.length} restaurants found',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ),
//             ),
//
//             const SliverToBoxAdapter(child: SizedBox(height: 8)),
//
//             // Restaurant List
//             if (filteredRestaurants.isNotEmpty)
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                       return RestaurantListCard(
//                         restaurant: filteredRestaurants[index],
//                       );
//                     },
//                     childCount: filteredRestaurants.length,
//                   ),
//                 ),
//               ),
//
//             // Empty state when no restaurants match filter
//             if (filteredRestaurants.isEmpty &&
//                 controller.restaurantList.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.restaurant_menu,
//                         size: 48,
//                         color: Colors.grey[300],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         widget.selectedFilter != null
//                             ? 'No restaurants found for "${widget.selectedFilter}"'
//                             : 'No restaurants found',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//             // Bottom Spacing
//             const SliverToBoxAdapter(
//               child: SizedBox(height: 16),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/foodSection/view/widgets/retaurent_shimmer.dart';

import '../../../../../utils/apptheme.dart';
import '../../restaurent/controller/restaurentController.dart';
import '../../restaurent/model/restaurentModel.dart';
import '../screens/allRestaurentScreen.dart';

class RestaurantSection extends StatelessWidget {
  RestaurantSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResturentController>();

    return Obx(
          () {
        // Check if restaurants are loaded
        final isLoading =
            controller.restaurantList.isEmpty && controller.filters.isEmpty;

        if (isLoading) {
          return SliverMainAxisGroup(
            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: const Text(
                    'Open Restaurants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Loading shimmer
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 5,
                        (context, index) => const RestaurantShimmerCard(),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        }

        return SliverMainAxisGroup(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Open Restaurants',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(AllRestaurantsScreen()),
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Results count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${controller.filteredRestaurantList.length} restaurants found',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Restaurant List
            if (controller.filteredRestaurantList.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return RestaurantListCard(
                        restaurant: controller.filteredRestaurantList[index],
                      );
                    },
                    childCount: controller.filteredRestaurantList.length,
                  ),
                ),
              ),

            // Empty state when no restaurants match filter
            if (controller.filteredRestaurantList.isEmpty &&
                controller.restaurantList.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
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
                        controller.selectedFilter.value != null
                            ? 'No restaurants found for "${controller.selectedFilter.value}"'
                            : 'No restaurants found',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.applyFilter(null);
                        },
                        child: const Text('Clear Filter'),
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom Spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
          ],
        );
      },
    );
  }
}