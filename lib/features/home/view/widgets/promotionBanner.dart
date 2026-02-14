
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

import '../../../../utils/apptheme.dart';
import '../../controller/bannerController.dart';
import '../../model/models/banner_model.dart';
import 'package:newdow_customer/utils/constants.dart';

class PromoBanner extends StatefulWidget {
  final BannerType bannerType;

  const PromoBanner({
    Key? key,
    required this.bannerType,
  }) : super(key: key);

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  final bannerController = Get.find<BannerController>();

  @override
  void initState() {
    print("load");
    super.initState();
    _loadAndFilterBanners();
  }

  /// 📥 Load banners, filter by type, and sort by priority
  Future<void> _loadAndFilterBanners() async {
    // Step 1: Fetch all banners from backend
    await bannerController.getHomeBanners();

    // Step 2: Filter banners by type
    final  filterType =
    widget.bannerType == BannerType.forRestaurant
        ? "Restaurant"
        : widget.bannerType == BannerType.forPharmacy
        ? "Medicines"
        : widget.bannerType == BannerType.forGrocery
        ? "Grocery"
        : "Home";


    if (mounted) {
      bannerController.filterBannersByType(filterType);

      // Step 3: Sort by priority (handled in filterBannersByType)
      print("✅ Banners loaded, filtered, and sorted by priority");

      _startAutoSlide();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// 🎠 Auto slide carousel
  void _startAutoSlide() {
    ever(bannerController.filterdBanner, (_) {
      if (bannerController.filterdBanner.isEmpty) return;

      _timer?.cancel();

      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        final maxPage = bannerController.filterdBanner.length - 1;

        if (_currentPage < maxPage) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        final list = bannerController.filterdBanner;

        // ⏳ Show loading state while data is empty
        if (list.isEmpty) {
          return _buildShimmerLoader();
        }

        // ✅ Show banners when data is available
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              height: 200,
              child: Card(
                elevation: 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: list.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildBannerItem(list[index]);
                  },
                ),
              ),
            ),
            CarouselIndicator(
              count: list.length,
              currentIndex: _currentPage,
            ),
            // 📊 Debug info showing banner priorities
            // if (list.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       '${list[_currentPage].title} (Priority: ${list[_currentPage].priority})',
            //       style: TextStyle(
            //         fontSize: 12,
            //         color: Colors.grey[600],
            //       ),
            //     ),
            //   ),
          ],
        );
      }),
    );
  }

  /// 🎨 Build individual banner item
  Widget _buildBannerItem(BannerModel banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼️ Banner image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              banner.imageUrl,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          // 📝 Title
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Text(
                banner.title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // 🛒 Shop Now button
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                print(
                  '🛍️ Shop Now tapped for: ${banner.title} (Priority: ${banner.priority})',
                );
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                alignment: Alignment.center,
                fixedSize: WidgetStatePropertyAll(Size(140, 45)),
                backgroundColor: WidgetStatePropertyAll(Color(0xFFF9A31E)),
              ),
              child: Text(
                "Shop Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ⏳ Shimmer loading placeholder
  Widget _buildShimmerLoader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      height: 200,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🎯 Carousel indicator dots
class CarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const CarouselIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'dart:async';
//
// import '../../../../utils/apptheme.dart';
// import '../../controller/bannerController.dart';
// import '../../model/models/banner_model.dart';
// import 'package:newdow_customer/utils/constants.dart';
//
// class PromoBanner extends StatefulWidget {
//   final BannerType bannerType;
//
//   const PromoBanner({
//     Key? key,
//     required this.bannerType,
//   }) : super(key: key);
//
//   @override
//   State<PromoBanner> createState() => _PromoBannerState();
// }
//
// class _PromoBannerState extends State<PromoBanner> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   Timer? _timer;
//   final bannerController = Get.find<BannerController>();
//   late String _currentFilterType;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentFilterType = widget.bannerType == BannerType.forRestaurant
//         ? "Restaurant"
//         : "Home";
//
//     print("🎯 PromoBanner init for type: $_currentFilterType");
//     // Clear previous filtered banners to prevent stale data
//     bannerController.clearFilteredBanners();
//     _loadAndFilterBanners();
//   }
//
//   /// 🔄 Called when widget properties change (e.g., navigation back)
//   @override
//   void didUpdateWidget(PromoBanner oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     final newFilterType = widget.bannerType == BannerType.forRestaurant
//         ? "Restaurant"
//         : "Home";
//
//     // If bannerType changed, reload and refilter
//     if (newFilterType != _currentFilterType) {
//       print("🔄 Banner type changed from $_currentFilterType to $newFilterType");
//       _currentFilterType = newFilterType;
//       _currentPage = 0;
//
//       // Clear old filtered banners
//       bannerController.clearFilteredBanners();
//
//       // Reset page controller
//       if (_pageController.hasClients) {
//         _pageController.jumpToPage(0);
//       }
//
//       // Reload and refilter
//       _loadAndFilterBanners();
//     }
//   }
//
//   /// 📥 Load banners, filter by type, and sort by priority
//   Future<void> _loadAndFilterBanners() async {
//     try {
//       print("📥 Starting banner load for type: $_currentFilterType");
//
//       // Step 1: Always fetch/refresh banners
//       await bannerController.getHomeBanners();
//       print("✅ Banners fetched: ${bannerController.banners.length} total");
//
//       // Step 2: Filter banners by the current screen's type
//       if (mounted) {
//         bannerController.filterBannersByType(_currentFilterType);
//         print("✅ Banners filtered for: $_currentFilterType, count: ${bannerController.filterdBanner.length}");
//
//         // Reset carousel to first page
//         _currentPage = 0;
//         if (_pageController.hasClients) {
//           _pageController.jumpToPage(0);
//         }
//
//         _isInitialized = true;
//         if (bannerController.filterdBanner.isNotEmpty) {
//           _startAutoSlide();
//         }
//       }
//     } catch (e) {
//       print("❌ Error loading banners: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   /// 🎠 Auto slide carousel
//   void _startAutoSlide() {
//     ever(bannerController.filterdBanner, (_) {
//       print("🔄 Filtered banner list changed, count: ${bannerController.filterdBanner.length}");
//
//       if (bannerController.filterdBanner.isEmpty) {
//         print("⚠️ Filtered banners empty, stopping auto-slide");
//         return;
//       }
//
//       _timer?.cancel();
//
//       _timer = Timer.periodic(const Duration(seconds: 4), (_) {
//         if (!mounted) return;
//
//         final maxPage = bannerController.filterdBanner.length - 1;
//
//         if (_currentPage < maxPage) {
//           _currentPage++;
//         } else {
//           _currentPage = 0;
//         }
//
//         if (_pageController.hasClients) {
//           _pageController.animateToPage(
//             _currentPage,
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeInOut,
//           );
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Obx(() {
//         final list = bannerController.filterdBanner;
//
//         print("🎨 Build called - List count: ${list.length}, Type: $_currentFilterType");
//
//         // ⏳ Show loading state while data is empty
//         if (!_isInitialized || list.isEmpty) {
//           print("⏳ Showing shimmer loader");
//           return _buildShimmerLoader();
//         }
//
//         // ✅ Show banners when data is available
//         print("✅ Showing ${list.length} banners");
//         return Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//               height: 200,
//               child: Card(
//                 elevation: 3,
//                 child: PageView.builder(
//                   controller: _pageController,
//                   itemCount: list.length,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentPage = index;
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     return _buildBannerItem(list[index]);
//                   },
//                 ),
//               ),
//             ),
//             CarouselIndicator(
//               count: list.length,
//               currentIndex: _currentPage,
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//   /// 🎨 Build individual banner item
//   Widget _buildBannerItem(BannerModel banner) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // 🖼️ Banner image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               banner.imageUrl,
//               fit: BoxFit.fill,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.image_not_supported),
//                 );
//               },
//             ),
//           ),
//           // 📝 Title
//           Positioned(
//             top: 20,
//             left: 20,
//             child: SizedBox(
//               height: 100,
//               width: 100,
//               child: Text(
//                 banner.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   shadows: [
//                     Shadow(
//                       offset: Offset(2.0, 2.0),
//                       blurRadius: 3.0,
//                       color: Colors.black45,
//                     ),
//                   ],
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           // 🛒 Shop Now button
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 print(
//                   '🛍️ Shop Now tapped for: ${banner.title} (Priority: ${banner.priority})',
//                 );
//               },
//               style: ButtonStyle(
//                 shape: const WidgetStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(24)),
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 fixedSize: const WidgetStatePropertyAll(Size(140, 45)),
//                 backgroundColor: const WidgetStatePropertyAll(Color(0xFFF9A31E)),
//               ),
//               child: const Text(
//                 "Shop Now",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// ⏳ Shimmer loading placeholder
//   Widget _buildShimmerLoader() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//       height: 200,
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.white,
//         child: Card(
//           elevation: 3,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     color: Colors.grey[300],
//                   ),
//                 ),
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   child: Container(
//                     height: 40,
//                     width: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 20,
//                   child: Container(
//                     height: 45,
//                     width: 140,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// 🎯 Carousel indicator dots
// class CarouselIndicator extends StatelessWidget {
//   final int count;
//   final int currentIndex;
//
//   const CarouselIndicator({
//     Key? key,
//     required this.count,
//     required this.currentIndex,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(
//           count,
//               (index) => AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             width: currentIndex == index ? 24 : 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: currentIndex == index
//                   ? AppColors.primary
//                   : Colors.grey[300],
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
