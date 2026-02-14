import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/product/view/view_product_screen.dart';

import '../../widgets/navbar.dart';

class DeepLinkService {
  static final AppLinks _appLinks = AppLinks();

  static void init() {
    // Cold start
    _appLinks.getInitialAppLink().then(_handleUri);

    // App already running
    _appLinks.uriLinkStream.listen(_handleUri);
  }

  static void _handleUri(Uri? uri) {
    if (uri == null) return;

    final productId = uri.queryParameters['product'];

    if (productId != null) {
      Get.offAll(() => const CustomBottomNav());

      // Future.delayed(const Duration(milliseconds: 300), () {
      //   Get.to(() => ViewProductScreen(product:  int.parse(productId)));
      // });
    }
  }
}
