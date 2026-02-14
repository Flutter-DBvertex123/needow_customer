// import 'package:get/get.dart';
//
// import '../model/addressModel.dart';
//
// class PickDefaultAddressController extends GetxController {
//   Rxn<AddressModel> selectedAddress = Rxn<AddressModel>();
//
//
//   void setDefaultAddress(AddressModel defaultAddress) {
//     selectedAddress.value = defaultAddress;
//   }
//
//   void changeAddress(AddressModel address) {
//     selectedAddress.value = address;
//   }
// }
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/home/controller/buisnessController.dart';

import 'addressController.dart';

class PickDefaultAddressController extends GetxController {
  final Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeWithDefaultAddress();
  }

  /// Initialize with the default address from AddressController
  void initializeWithDefaultAddress() {
    try {
      final addressController = Get.find<AddressController>();
      final defaultAddr = addressController.defaultAddress.value;

      if (defaultAddr != null) {
        selectedAddress(defaultAddr);
        print('✅ Initialized with default address: ${defaultAddr.street}');
      } else {
        print('⚠️ No default address found');
      }
    } catch (e) {
      print('❌ Error initializing default address: $e');
    }
  }

  /// Change selected address
  void changeAddress(AddressModel address) async {
    selectedAddress(address);
    print('📍 Selected address changed to: ${address.street}');
    await Get.find<BusinessController>().getBusinessAllTypes();
  }

  /// Reset to default address
  void resetToDefault() {
    try {
      final addressController = Get.find<AddressController>();
      final defaultAddr = addressController.defaultAddress.value;
      selectedAddress(defaultAddr);
    } catch (e) {
      print('❌ Error resetting to default: $e');
    }
  }
}