// import 'package:get/get.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
// import 'package:newdow_customer/features/cart/view/chekout_screen.dart';
//
// import '../../address/controller/addressController.dart';
//
// class CheckoutController extends GetxController {
//
//   Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
//
//
//   void changeAddress(selectedIndex) {
//     selectedAddress.value = addressCon.usersAddress[selectedIndex];
//   }
// }
/*import 'package:get/get.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';

class CheckoutController extends GetxController {


  Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);


 void setDefaultAddress(AddressModel defaultAddress){
   selectedAddress.value = defaultAddress;
 }

  void changeAddress(AddressModel address) {
    selectedAddress.value = address;
  }
}*/
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:newdow_customer/features/cart/model/models/cartCheckOutModel.dart';

import '../../address/model/addressModel.dart';

class CheckoutController extends GetxController {
  Rxn<AddressModel> selectedAddress = Rxn<AddressModel>();
  TextEditingController customerNote = TextEditingController();
  Rxn<CartGroup> groceryCart =  Rxn<CartGroup>();
  Rxn<CartGroup> foodCart =  Rxn<CartGroup>();
  Rxn<CartGroup> medicineCart =  Rxn<CartGroup>();

  void setDefaultAddress(AddressModel defaultAddress) {
    selectedAddress.value = defaultAddress;
  }


  void changeAddress(AddressModel address) {
    selectedAddress.value = address;
  }
}
