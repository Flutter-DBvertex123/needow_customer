

import 'package:share_plus/share_plus.dart';

class ReferralShareService {
  static void shareProduct({
    required String productId,
  }) {
    final String packageName = "com.example.needowcustomer";

    final String referralLink =
        "https://api.needdow.graphicsvolume.com/products/referlink/"
        "$packageName?product=$productId";

    final String message = '''
Check out this product on NeedDow 👇

$referralLink

Download the app and order now!
''';

    Share.share(message);
  }
}
