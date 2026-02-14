// import 'package:get/get.dart';
// import 'package:newdow_customer/features/home/model/bannerService/banner_service.dart';
// import 'package:newdow_customer/features/home/model/models/banner_model.dart';
//
// class BannerController extends GetxController {
//
//   // RxList<BannerModel> banners = <BannerModel>[].obs;
//   //
//   //
//   // Future<List<BannerModel?>> getHomeBanners() async {
//   //   print("calling banner");
//   //   final data = await Get.find<BannerService>().getHomeBanner();
//   //   banners.assignAll(data);
//   //   print("after banner $data");
//   //   return data;
//   // }
//   RxList<BannerModel> banners = <BannerModel>[].obs;
//   RxList<BannerModel> filterdBanner = <BannerModel>[].obs;
//
//   Future<void> getHomeBanners() async {
//     print("calling banner");
//
//     final List<BannerModel> data = await Get.find<BannerService>().getHomeBanner();
//     banners.assignAll(data);
//     print("banners obx $banners");
//     print("after banner $data");
//
//   }
// }

// 📁 banner_controller.dart
/*
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/model/bannerService/banner_service.dart';
import 'package:newdow_customer/features/home/model/models/banner_model.dart';

class BannerController extends GetxController {
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<BannerModel> filterdBanner = <BannerModel>[].obs;

  /// 📥 Fetch banners from backend
  Future<void> getHomeBanners() async {
    try {
      print("📥 Calling banner API...");
      final List<BannerModel> data = await Get.find<BannerService>().getHomeBanner();
      banners.assignAll(data);
      print("✅ Banners loaded: ${banners.length} items");
    } catch (e) {
      print("❌ Error fetching banners: $e");
    }
  }

  /// 🔍 Filter banners by type
  void filterBannersByType(String type) {
    print("🔍 Filtering banners by type: $type");

    final filtered = banners.where((banner) => banner.type == type).toList();
    filterdBanner.assignAll(filtered);

    print("✅ Filtered banners: ${filterdBanner.length} items");
  }

  /// 🔄 Clear filtered banners
  void clearFilteredBanners() {
    filterdBanner.clear();
  }
}*/
// 📁 banner_controller.dart
import 'package:get/get.dart';
import 'package:newdow_customer/features/home/model/bannerService/banner_service.dart';
import 'package:newdow_customer/features/home/model/models/banner_model.dart';

class BannerController extends GetxController {
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<BannerModel> filterdBanner = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    getHomeBanners().then((_) {
      resetToHomeBanners();
    });
  }

  /// 📥 Fetch banners from backend
  Future<void> getHomeBanners() async {
    try {
      print("📥 Calling banner API...");
      final List<BannerModel> data = await Get.find<BannerService>().getHomeBanner();

      // ✅ Sort by priority (highest first) immediately after fetching
      data.sort((a, b) => b.priority.compareTo(a.priority));

      banners.assignAll(data);
      print("✅ Banners loaded: ${banners.length} items (sorted by priority)");
    } catch (e) {
      print("❌ Error fetching banners: $e");
    }
  }

  /// 🔍 Filter banners by type AND sort by priority
  void filterBannersByType(String type) {
    print("🔍 Filtering banners by type: $type");

    // ✅ Filter AND sort in one go
    final filtered = banners
        .where((banner) => banner.isOfType(type))
        .toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));

    filterdBanner.assignAll(filtered);
    print("✅ Filtered & sorted banners: ${filterdBanner.length} items");
  }

  /// 🔄 Sort filtered banners by priority (descending - highest first)
  void sortByPriorityDesc() {
    print("📊 Sorting by priority (DESC)...");
    final sorted = List<BannerModel>.from(filterdBanner)
      ..sort((a, b) => b.priority.compareTo(a.priority));
    filterdBanner.assignAll(sorted);
  }

  /// 🔄 Sort filtered banners by priority (ascending - lowest first)
  void sortByPriorityAsc() {
    print("📊 Sorting by priority (ASC)...");
    final sorted = List<BannerModel>.from(filterdBanner)
      ..sort((a, b) => a.priority.compareTo(b.priority));
    filterdBanner.assignAll(sorted);
  }

  /// 🔄 Sort by display order
  void sortByDisplayOrder() {
    print("📊 Sorting by display order...");
    final sorted = List<BannerModel>.from(filterdBanner)
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    filterdBanner.assignAll(sorted);
  }

  /// 🔄 Sort by creation date (newest first)
  void sortByDateDesc() {
    print("📊 Sorting by date (newest first)...");
    final sorted = List<BannerModel>.from(filterdBanner)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    filterdBanner.assignAll(sorted);
  }

  /// 🔄 Sort by creation date (oldest first)
  void sortByDateAsc() {
    print("📊 Sorting by date (oldest first)...");
    final sorted = List<BannerModel>.from(filterdBanner)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    filterdBanner.assignAll(sorted);
  }

  /// 🔄 Clear filtered banners
  void clearFilteredBanners() {
    filterdBanner.clear();
  }

  void resetToHomeBanners() {
    print("🏠 Resetting banners to HOME");

    final homeBanners = banners
      //   .where((banner) => banner.isOfType("Home"))


        .where((banner) =>
    banner.isOfType("home") ||
        banner.isOfType("homepage"))
      .toList()
    ..sort((a, b) => b.priority.compareTo(a.priority));
    filterdBanner.assignAll(homeBanners);
  }



}