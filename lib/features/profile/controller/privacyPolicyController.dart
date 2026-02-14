import 'package:get/get.dart';
import 'package:newdow_customer/features/profile/model/privacyPolicyModel.dart';

import '../../cart/model/models/couponModel.dart';
import '../../cart/model/services/couponServices.dart';
import '../model/services/privacyPolicyService.dart';

class Privacypolicycontroller extends GetxController{

  Future<Privacypolicymodel>getPrivacyPolicy() async {
    final data  = await Get.find<PrivacyPolciyService>().getPrivacyPolicy();
    print("privacy ploicy data inCon ${data.content}");
    return data;
  }
}