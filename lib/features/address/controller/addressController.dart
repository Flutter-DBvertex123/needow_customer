// lib/controllers/address_controller.dart

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../model/creatCreateAddressModel.dart';
//
//
// class AddressController extends GetxController {
//   // Observable variables
//   final Rx<CreateAddressModel> currentAddress = CreateAddressModel.empty().obs;
//   final RxList<CreateAddressModel> addresses = <CreateAddressModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isSaving = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxInt selectedAddressIndex = (-1).obs;
//
//   // Text editing controllers
//   late TextEditingController streetController;
//   late TextEditingController cityController;
//   late TextEditingController stateController;
//   late TextEditingController pincodeController;
//   late TextEditingController countryController;
//   late TextEditingController landmarkController;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeControllers();
//     loadAddresses();
//   }
//
//   @override
//   void onClose() {
//     _disposeControllers();
//     super.onClose();
//   }
//
//   /// Initialize text editing controllers
//   void _initializeControllers() {
//     streetController = TextEditingController();
//     cityController = TextEditingController();
//     stateController = TextEditingController();
//     pincodeController = TextEditingController();
//     countryController = TextEditingController();
//     landmarkController = TextEditingController();
//   }
//
//   /// Dispose text editing controllers
//   void _disposeControllers() {
//     streetController.dispose();
//     cityController.dispose();
//     stateController.dispose();
//     pincodeController.dispose();
//     countryController.dispose();
//     landmarkController.dispose();
//   }
//
//   /// Load all addresses
//   Future<void> loadAddresses() async {
//     try {
//       isLoading(true);
//       errorMessage('');
//
//       // TODO: Replace with actual API call
//       // final response = await addressService.getAddresses();
//       // addresses.assignAll(response);
//
//       // Mock data for testing
//       addresses.assignAll([
//         CreateAddressModel.defaultAddress(),
//         CreateAddressModel(
//           id: '2',
//           street: '10 Downing Street',
//           city: 'London',
//           state: 'Greater London',
//           pincode: 'SW1A 2AA',
//           country: 'UK',
//           type: 'work',
//           landmark: 'Near Westminster',
//           latitude: 51.5033,
//           longitude: -0.1276,
//           isDefault: false,
//         ),
//       ]);
//     } catch (e) {
//       errorMessage('Error loading addresses: $e');
//       Get.snackbar('Error', 'Failed to load addresses', snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   /// Set current address for editing
//   void setCurrentAddress(CreateAddressModel address) {
//     currentAddress(address);
//     _updateControllers(address);
//   }
//
//   /// Update controllers with address data
//   void _updateControllers(CreateAddressModel address) {
//     streetController.text = address.street;
//     cityController.text = address.city;
//     stateController.text = address.state;
//     pincodeController.text = address.pincode;
//     countryController.text = address.country;
//     landmarkController.text = address.landmark;
//   }
//
//   /// Clear all controllers
//   void clearControllers() {
//     streetController.clear();
//     cityController.clear();
//     stateController.clear();
//     pincodeController.clear();
//     countryController.clear();
//     landmarkController.clear();
//   }
//
//   /// Update current address field
//   void updateAddressField(String field, dynamic value) {
//     final updated = currentAddress.value.copyWith(
//       street: field == 'street' ? value : currentAddress.value.street,
//       city: field == 'city' ? value : currentAddress.value.city,
//       state: field == 'state' ? value : currentAddress.value.state,
//       pincode: field == 'pincode' ? value : currentAddress.value.pincode,
//       country: field == 'country' ? value : currentAddress.value.country,
//       landmark: field == 'landmark' ? value : currentAddress.value.landmark,
//       type: field == 'type' ? value : currentAddress.value.type,
//       isDefault: field == 'isDefault' ? value : currentAddress.value.isDefault,
//       latitude: field == 'latitude' ? value : currentAddress.value.latitude,
//       longitude: field == 'longitude' ? value : currentAddress.value.longitude,
//     );
//     currentAddress(updated);
//   }
//
//   /// Update address location from map
//   void updateAddressLocation(double latitude, double longitude) {
//     updateAddressField('latitude', latitude);
//     updateAddressField('longitude', longitude);
//   }
//
//   /// Change address type
//   void changeAddressType(String type) {
//     updateAddressField('type', type);
//   }
//
//   /// Toggle default address
//   void toggleDefaultAddress(bool value) {
//     updateAddressField('isDefault', value);
//   }
//
//   /// Save address (create or update)
//   Future<void> saveAddress() async {
//     try {
//       if (!_validateAddress()) {
//         return;
//       }
//
//       isSaving(true);
//       errorMessage('');
//
//       // Update current address from controllers
//       final updated = currentAddress.value.copyWith(
//         street: streetController.text,
//         city: cityController.text,
//         state: stateController.text,
//         pincode: pincodeController.text,
//         country: countryController.text,
//         landmark: landmarkController.text,
//       );
//
//       // TODO: Replace with actual API call
//       // if (updated.id != null) {
//       //   await addressService.updateAddress(updated);
//       // } else {
//       //   await addressService.createAddress(updated);
//       // }
//
//       // Mock save
//       if (updated.id != null) {
//         final index = addresses.indexWhere((a) => a.id == updated.id);
//         if (index != -1) {
//           addresses[index] = updated;
//         }
//       } else {
//         addresses.add(updated.copyWith(id: DateTime.now().toString()));
//       }
//
//       currentAddress(updated);
//       Get.snackbar('Success', 'Address saved successfully', snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       errorMessage('Error saving address: $e');
//       Get.snackbar('Error', 'Failed to save address', snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isSaving(false);
//     }
//   }
//
//   /// Delete address
//   Future<void> deleteAddress(String addressId) async {
//     try {
//       isLoading(true);
//       errorMessage('');
//
//       // TODO: Replace with actual API call
//       // await addressService.deleteAddress(addressId);
//
//       addresses.removeWhere((a) => a.id == addressId);
//       Get.snackbar('Success', 'Address deleted successfully', snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       errorMessage('Error deleting address: $e');
//       Get.snackbar('Error', 'Failed to delete address', snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   /// Set default address
//   Future<void> setDefaultAddress(String addressId) async {
//     try {
//       isLoading(true);
//       errorMessage('');
//
//       // Reset all addresses isDefault to false
//       final updatedAddresses = addresses.map((a) {
//         return a.copyWith(isDefault: a.id == addressId);
//       }).toList();
//
//       addresses.assignAll(updatedAddresses);
//
//       // TODO: Replace with actual API call
//       // await addressService.setDefaultAddress(addressId);
//
//       Get.snackbar('Success', 'Default address updated', snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       errorMessage('Error updating default address: $e');
//       Get.snackbar('Error', 'Failed to update default address', snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   /// Get default address
//   CreateAddressModel? getDefaultAddress() {
//     try {
//       return addresses.firstWhere((a) => a.isDefault);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   /// Get addresses by type
//   List<CreateAddressModel> getAddressesByType(String type) {
//     return addresses.where((a) => a.type == type).toList();
//   }
//
//   /// Search addresses
//   List<CreateAddressModel> searchAddresses(String query) {
//     return addresses
//         .where((a) =>
//     a.street.toLowerCase().contains(query.toLowerCase()) ||
//         a.city.toLowerCase().contains(query.toLowerCase()) ||
//         a.landmark.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
//
//   /// Get address count
//   int getAddressCount() {
//     return addresses.length;
//   }
//
//   /// Validate address
//   bool _validateAddress() {
//     final address = currentAddress.value;
//
//     if (address.street.isEmpty) {
//       errorMessage('Street address is required');
//       Get.snackbar('Validation Error', 'Street address is required', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     if (address.city.isEmpty) {
//       errorMessage('City is required');
//       Get.snackbar('Validation Error', 'City is required', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     if (address.state.isEmpty) {
//       errorMessage('State is required');
//       Get.snackbar('Validation Error', 'State is required', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     if (address.pincode.isEmpty) {
//       errorMessage('Pincode is required');
//       Get.snackbar('Validation Error', 'Pincode is required', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     if (address.country.isEmpty) {
//       errorMessage('Country is required');
//       Get.snackbar('Validation Error', 'Country is required', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     if (address.latitude == 0.0 || address.longitude == 0.0) {
//       errorMessage('Please select location on map');
//       Get.snackbar('Validation Error', 'Please select location on map', snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     return true;
//   }
//
//   /// Reset form
//   void resetForm() {
//     currentAddress(CreateAddressModel.empty());
//     clearControllers();
//     errorMessage('');
//   }
//
//   /// Get address by ID
//   CreateAddressModel? getAddressById(String id) {
//     try {
//       return addresses.firstWhere((a) => a.id == id);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   /// Duplicate address
//   void duplicateAddress(String addressId) {
//     final address = getAddressById(addressId);
//     if (address != null) {
//       final newAddress = address.copyWith(
//         id: null,
//         isDefault: false,
//       );
//       setCurrentAddress(newAddress);
//     }
//   }
//
//   /// Calculate distance between two addresses
//   double calculateDistance(String addressId1, String addressId2) {
//     final addr1 = getAddressById(addressId1);
//     final addr2 = getAddressById(addressId2);
//
//     if (addr1 == null || addr2 == null) {
//       return 0.0;
//     }
//
//     return addr1.getDistanceFrom(addr2);
//   }
// }
// lib/controllers/address_controller.dart

/*
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/address/model/services/addressServices.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import '../model/creatAddressModel.dart';



class AddressController extends GetxController {
  // API Service


  // Observable variables
  final Rx<CreateAddressModel> currentAddress = CreateAddressModel.empty().obs;
  final RxList<CreateAddressModel> addresses = <CreateAddressModel>[].obs;
  final RxList<AddressModel> usersAddress = <AddressModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt selectedAddressIndex = (-1).obs;
  final RxList<AddressModel> allAddresses = <AddressModel>[].obs;

  // Text editing controllers
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController pincodeController;
  late TextEditingController countryController;
  late TextEditingController landmarkController;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    loadAddresses();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  /// Initialize text editing controllers
  void _initializeControllers() {
    streetController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    pincodeController = TextEditingController();
    countryController = TextEditingController();
    landmarkController = TextEditingController();
  }

  /// Dispose text editing controllers
  void _disposeControllers() {
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    countryController.dispose();
    landmarkController.dispose();
  }

  /// Load all addresses from API
  Future<void> loadAddresses() async {
    try {
      isLoading(true);
      errorMessage('');

      // Call API to get addresses
      // //final response = await addressService.getAddresses();
      // addresses.assignAll(response);
      //
      // print('✅ Loaded ${response.length} addresses');
    } catch (e) {
      errorMessage('Error loading addresses: $e');
      Get.snackbar('Error', 'Failed to load addresses', snackPosition: SnackPosition.BOTTOM);
      print('❌ Error loading addresses: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Set current address for editing
  void setCurrentAddress(CreateAddressModel address) {
    currentAddress(address);
    _updateControllers(address);
  }

  /// Update controllers with address data
  void _updateControllers(CreateAddressModel address) {
    streetController.text = address.street;
    cityController.text = address.city;
    stateController.text = address.state;
    pincodeController.text = address.pincode;
    countryController.text = address.country;
    landmarkController.text = address.landmark;
  }

  /// Clear all controllers
  void clearControllers() {
    streetController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    countryController.clear();
    landmarkController.clear();
  }

  /// Update current address field
  void updateAddressField(String field, dynamic value) {
    final updated = currentAddress.value.copyWith(
      street: field == 'street' ? value : currentAddress.value.street,
      city: field == 'city' ? value : currentAddress.value.city,
      state: field == 'state' ? value : currentAddress.value.state,
      pincode: field == 'pincode' ? value : currentAddress.value.pincode,
      country: field == 'country' ? value : currentAddress.value.country,
      landmark: field == 'landmark' ? value : currentAddress.value.landmark,
      type: field == 'type' ? value : currentAddress.value.type,
      isDefault: field == 'isDefault' ? value : currentAddress.value.isDefault,
      latitude: field == 'latitude' ? value : currentAddress.value.latitude,
      longitude: field == 'longitude' ? value : currentAddress.value.longitude,
    );
    currentAddress(updated);
  }

  /// Update address location from map
  void updateAddressLocation(double latitude, double longitude) {
    updateAddressField('latitude', latitude);
    updateAddressField('longitude', longitude);
  }

  /// Change address type
  void changeAddressType(String type) {
    updateAddressField('type', type);
  }

  /// Toggle default address
  void toggleDefaultAddress(bool value) {
    updateAddressField('isDefault', value);
  }

  /// Save address (create or update)
  Future<void> saveAddress() async {
    try {
      if (!_validateAddress()) {
        return;
      }

      isSaving(true);
      errorMessage('');

      // Update current address from controllers
      final updated = currentAddress.value.copyWith(
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pincodeController.text,
        country: countryController.text,
        landmark: landmarkController.text,
      );

      // Check if creating new or updating existing
      if (updated.id != null && updated.id!.isNotEmpty) {

        //final response = await addressService.updateAddress(updated.id!, updated);

        // final index = addresses.indexWhere((a) => a.id == updated.id);
        // if (index != -1) {
        //   addresses[index] = response;
        // }

        //currentAddress(response);
        Get.snackbar('Success', 'Address updated successfully', snackPosition: SnackPosition.BOTTOM);
        //print('✅ Address updated: ${response.id}');
      } else {
        // Create new address
        final response = await Get.find<AddressService>().createAddress(updated);
        usersAddress.add(response);

        //usersAddress(response);
        Get.snackbar('Success', 'Address created successfully', snackPosition: SnackPosition.TOP,backgroundColor: AppColors.primary);
        print('✅ Address created: ${response.id}');
      }
    } catch (e) {
      errorMessage('Error saving address: $e');
      Get.snackbar('Error', 'Failed to save address', snackPosition: SnackPosition.BOTTOM);
      print('❌ Error saving address: $e');
    } finally {
      isSaving(false);
    }
  }

  /// Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      isLoading(true);
      errorMessage('');

      //await addressService.deleteAddress(addressId);
      addresses.removeWhere((a) => a.id == addressId);

      Get.snackbar('Success', 'Address deleted successfully', snackPosition: SnackPosition.BOTTOM);
      print('✅ Address deleted: $addressId');
    } catch (e) {
      errorMessage('Error deleting address: $e');
      Get.snackbar('Error', 'Failed to delete address', snackPosition: SnackPosition.BOTTOM);
      print('❌ Error deleting address: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Set default address
  Future<void> setDefaultAddress(String addressId) async {
    try {
      isLoading(true);
      errorMessage('');

      // Reset all addresses isDefault to false
      final updatedAddresses = addresses.map((a) {
        return a.copyWith(isDefault: a.id == addressId);
      }).toList();

      addresses.assignAll(updatedAddresses);

      // TODO: Replace with actual API call
      // await addressService.setDefaultAddress(addressId);

      Get.snackbar('Success', 'Default address updated', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      errorMessage('Error updating default address: $e');
      Get.snackbar('Error', 'Failed to update default address', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  /// Get default address
  CreateAddressModel? getDefaultAddress() {
    try {
      return addresses.firstWhere((a) => a.isDefault);
    } catch (e) {
      return null;
    }
  }

  /// Get addresses by type
  List<CreateAddressModel> getAddressesByType(String type) {
    return addresses.where((a) => a.type == type).toList();
  }

  Future<void> getAddresses() async {
    allAddresses.value = await Get.find<AddressService>().getAddresses();
  }

  /// Search addresses
  List<CreateAddressModel> searchAddresses(String query) {
    return addresses
        .where((a) =>
    a.street.toLowerCase().contains(query.toLowerCase()) ||
        a.city.toLowerCase().contains(query.toLowerCase()) ||
        a.landmark.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Get address count
  int getAddressCount() {
    return addresses.length;
  }

  /// Validate address
  bool _validateAddress() {
    final address = currentAddress.value;

    if (address.street.isEmpty) {
      errorMessage('Street address is required');
      Get.snackbar('Validation Error', 'Street address is required', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.city.isEmpty) {
      errorMessage('City is required');
      Get.snackbar('Validation Error', 'City is required', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.state.isEmpty) {
      errorMessage('State is required');
      Get.snackbar('Validation Error', 'State is required', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.pincode.isEmpty) {
      errorMessage('Pincode is required');
      Get.snackbar('Validation Error', 'Pincode is required', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.country.isEmpty) {
      errorMessage('Country is required');
      Get.snackbar('Validation Error', 'Country is required', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.latitude == 0.0 || address.longitude == 0.0) {
      errorMessage('Please select location on map');
      Get.snackbar('Validation Error', 'Please select location on map', snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }

  /// Reset form
  void resetForm() {
    currentAddress(CreateAddressModel.empty());
    clearControllers();
    errorMessage('');
  }

  /// Get address by ID
  CreateAddressModel? getAddressById(String id) {
    try {
      return addresses.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Duplicate address
  void duplicateAddress(String addressId) {
    final address = getAddressById(addressId);
    if (address != null) {
      final newAddress = address.copyWith(
        id: null,
        isDefault: false,
      );
      setCurrentAddress(newAddress);
    }
  }

  /// Calculate distance between two addresses
  double calculateDistance(String addressId1, String addressId2) {
    final addr1 = getAddressById(addressId1);
    final addr2 = getAddressById(addressId2);

    if (addr1 == null || addr2 == null) {
      return 0.0;
    }

    return addr1.getDistanceFrom(addr2);
  }
}*/
// lib/controllers/address_controller.dart

// lib/controllers/address_controller.dart

// lib/controllers/address_controller.dart

// lib/controllers/address_controller.dart
// lib/controllers/address_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/address/model/services/addressServices.dart';
import 'package:newdow_customer/utils/apptheme.dart';

class AddressController extends GetxController {
  // API Service
  final addressService = Get.find<AddressService>();

  // Observable variables
  final Rx<AddressModel?> defaultAddress = Rx<AddressModel?>(null);
  final RxList<AddressModel> usersAddress = <AddressModel>[].obs;
  final Rx<AddressModel> currentAddress = AddressModel
      .empty()
      .obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool setAsDefaultCheckbox = false.obs;
  final Rx<AddressModel?> selectedDeliveryAddress = Rx<AddressModel?>(null);

  // Text editing controllers
  final TextEditingController searchLocationController = TextEditingController();

  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController pincodeController;
  late TextEditingController countryController;
  late TextEditingController landmarkController;


  @override
  void onInit() {
    super.onInit();
    // _initializeControllers();
    // // Load addresses after initialization
    // Future.delayed(Duration.zero, () {
       loadAddresses();
    initializeControllers();
    // });
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void toggleSetAsDefaultCheckbox(bool value) {
    setAsDefaultCheckbox(value);
  }

  /// Reset checkbox
  void resetCheckbox() {
    setAsDefaultCheckbox(false);
  }

  /// Initialize text editing controllers
  void initializeControllers() {
    streetController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    pincodeController = TextEditingController();
    countryController = TextEditingController();
    landmarkController = TextEditingController();
  }

  /// Dispose text editing controllers
  void _disposeControllers() {
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    countryController.dispose();
    landmarkController.dispose();
  }

  /// Load all addresses from API
  Future<void> loadAddresses() async {
    try {
      isLoading(true);
      errorMessage('');

      // Call API to get addresses
      final response = await addressService.getAddresses();
      print("address response ${response.length}");
      usersAddress.assignAll(response);
      print("address of user ${usersAddress.length}");
      // Find and set default address
      final defaultAddr = response.firstWhereOrNull((a) => a.isDefault);
      defaultAddress(defaultAddr);
      selectedDeliveryAddress(defaultAddr);

      print('✅ Loaded ${response.length} addresses');
      print('✅ Default address: ${defaultAddr?.street}');
    } catch (e) {
      errorMessage('Error loading addresses: $e');
      // Get.snackbar('Error', 'Failed to load addresses',
      //     snackPosition: SnackPosition.BOTTOM);
      print('❌ Error loading addresses: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Set current address for editing (used in update screen)
  void setCurrentAddress(AddressModel address) {
    currentAddress(address);
    _updateControllers(address);
  }

  /// Update controllers with address data
  void _updateControllers(AddressModel address) {
    streetController.text = address.street;
    cityController.text = address.city;
    stateController.text = address.state;
    pincodeController.text = address.pincode;
    countryController.text = address.country;
    landmarkController.text = address.landmark;
  }

  /// Clear all controllers
  void clearControllers() {
    streetController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    countryController.clear();
    landmarkController.clear();
  }

  /// Update current address field
  void updateAddressField(String field, dynamic value) {
    final updated = currentAddress.value.copyWith(
      street: field == 'street' ? value : currentAddress.value.street,
      city: field == 'city' ? value : currentAddress.value.city,
      state: field == 'state' ? value : currentAddress.value.state,
      pincode: field == 'pincode' ? value : currentAddress.value.pincode,
      country: field == 'country' ? value : currentAddress.value.country,
      landmark: field == 'landmark' ? value : currentAddress.value.landmark,
      type: field == 'type' ? value : currentAddress.value.type,
      isDefault: field == 'isDefault' ? value : currentAddress.value.isDefault,
      latitude: field == 'latitude' ? value : currentAddress.value.latitude,
      longitude: field == 'longitude' ? value : currentAddress.value.longitude,
    );
    currentAddress(updated);
  }

  /// Update address location from map
  void updateAddressLocation(double latitude, double longitude) {
    updateAddressField('latitude', latitude);
    updateAddressField('longitude', longitude);
  }

  /// Change address type
  void changeAddressType(String type) {
    updateAddressField('type', type);
  }

  /// Toggle default address
  void toggleDefaultAddress(bool value) {
    updateAddressField('isDefault', value);
  }

  /// Validate address
  bool _validateAddress() {
    final address = currentAddress.value;

    if (address.street.isEmpty) {
      errorMessage('Street address is required');
      Get.snackbar('Validation Error', 'Street address is required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.city.isEmpty) {
      errorMessage('City is required');
      Get.snackbar('Validation Error', 'City is required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.state.isEmpty) {
      errorMessage('State is required');
      Get.snackbar('Validation Error', 'State is required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.pincode.isEmpty) {
      errorMessage('Pincode is required');
      Get.snackbar('Validation Error', 'Pincode is required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.country.isEmpty) {
      errorMessage('Country is required');
      Get.snackbar('Validation Error', 'Country is required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (address.latitude == 0.0 || address.longitude == 0.0) {
      errorMessage('Please select location on map');
      Get.snackbar('Validation Error', 'Please select location on map',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }

  /// Create Address
  /// Create Address
  /// If created address is default, it resets the previous default
  Future<AddressModel?> createAddress({bool setAsDefault = false}) async {
    try {
      if (!_validateAddress()) {
        return null;
      }

      isSaving(true);
      errorMessage('');

      // Update current address from controllers
      final addressToCreate = currentAddress.value.copyWith(
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pincodeController.text,
        country: countryController.text,
        landmark: landmarkController.text,
        isDefault: setAsDefault, // Set based on parameter
      );

      print('📤 Creating address: ${addressToCreate.street}');

      // Create address via API
      final createdAddress = await addressService.createAddress(
          addressToCreate);

      // Add to list
      usersAddress.add(createdAddress);

      // If setAsDefault is true, update default address and reset others
      if (setAsDefault && createdAddress.id != null) {
        print('🔄 Setting new address as default...');

        // Get current default address
        final currentDefaultAddress = defaultAddress.value;

        try {
          // If there's a current default address, set it to false
          if (currentDefaultAddress != null &&
              currentDefaultAddress.id != null) {
            print('Resetting old default address (${currentDefaultAddress
                .id}) to false');
            await addressService.updateDefaultAddress(
              currentDefaultAddress.id!,
              false,
            );
          }

          // Set new address as default
          print(
              'Setting new address (${createdAddress.id}) as default to true');
          final response = await addressService.updateDefaultAddress(
            createdAddress.id!,
            true,
          );

          if (response) {
            // Update local state
            defaultAddress(createdAddress);

            // Update the address in the list
            final index = usersAddress.indexWhere((a) =>
            a.id == createdAddress.id);
            if (index != -1) {
              usersAddress[index] = createdAddress.copyWith(isDefault: true);
            }

            // Reset other addresses to non-default
            usersAddress.forEach((addr) {
              if (addr.id != createdAddress.id) {
                final idx = usersAddress.indexWhere((a) => a.id == addr.id);
                if (idx != -1) {
                  usersAddress[idx] = addr.copyWith(isDefault: false);
                }
              }
            });

            print('✅ New address set as default successfully');
          }
        } catch (e) {
          print('❌ Error setting default address: $e');
          // Don't rethrow - address was created successfully, just default setting failed
          Get.snackbar(
            'Warning',
            'Address created but failed to set as default',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }

      // Get.snackbar(
      //   'Success',
      //   setAsDefault
      //       ? 'Address created and set as default'
      //       : 'Address created successfully',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: AppColors.primary,
      // );
      print('✅ Address created: ${createdAddress.id}');

      return createdAddress;
    } catch (e) {
      errorMessage('Error creating address: $e');
      Get.snackbar(
        'Error',
        'Failed to create address: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('❌ Error creating address: $e');
      return null;
    } finally {
      isSaving(false);
    }
  }

  /// Called when creating a new default address
  Future<void> _resetDefaultAddress(String newDefaultId) async {
    try {
      print('🔄 Resetting default address...');

      // Set all addresses isDefault to false except the new one
      final updatedAddresses = usersAddress.map((a) {
        return a.copyWith(isDefault: a.id == newDefaultId);
      }).toList();

      usersAddress.assignAll(updatedAddresses);

      // Update the new default address
      final newDefault = usersAddress.firstWhereOrNull((a) =>
      a.id == newDefaultId);

      defaultAddress(newDefault);

      print('✅ Default address updated');
    } catch (e) {
      print('❌ Error resetting default address: $e');
    }
  }

  /// Delete Address
  Future<bool> deleteAddress(String addressId) async {
    try {
      isLoading(true);
      errorMessage('');

      //await addressService.deleteAddress(addressId);
      usersAddress.removeWhere((a) => a.id == addressId);

      // If deleted address was default, clear default address
      // if (defaultAddress.value?.id == addressId) {
      //   defaultAddress(null);
      // }
      bool response = await addressService.deleteAddress(addressId);
      return response;
    } catch (e) {
      errorMessage('Error deleting address: $e');
      Get.snackbar(
        'Error',
        'Failed to delete address',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('❌ Error deleting address: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  /// Reset form
  void resetForm() {
    currentAddress(AddressModel.empty());
    clearControllers();
    errorMessage('');
  }

  /// Get address count
  int getAddressCount() {
    return usersAddress.length;
  }


  /// Get addresses by type
  List<AddressModel> getAddressesByType(String type) {
    return usersAddress.where((a) => a.type == type).toList();
  }

  /// Search addresses
  List<AddressModel> searchAddresses(String query) {
    return usersAddress
        .where((a) =>
    a.street.toLowerCase().contains(query.toLowerCase()) ||
        a.city.toLowerCase().contains(query.toLowerCase()) ||
        a.landmark.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Get address by ID
  AddressModel? getAddressById(String id) {
    try {
      return usersAddress.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if address list is empty
  bool get isAddressListEmpty => usersAddress.isEmpty;

  /// Check if default address exists
  bool get hasDefaultAddress => defaultAddress.value != null;

  /// Get default address landmark
  String get defaultAddressLandmark =>
      defaultAddress.value?.landmark ?? 'Select Address';

  /// Get default address city
  String get defaultAddressCity =>
      defaultAddress.value?.city ?? 'Select City';

  /// Get full address display
  String get fullAddressDisplay =>
      "${defaultAddressCity} - ${defaultAddressLandmark}";

  /// Refresh addresses list
  Future<void> refreshAddresses() async {
    await loadAddresses();
  }

  // Alternative: With error recovery - if second call fails, revert first
  // Future<bool> switchDefaultAddressWithRollback(
  //     String oldAddressId,
  //     String newAddressId,
  //     ) async {
  //   try {
  //     // Step 1: Set old address as non-default
  //     print('Setting old address ($oldAddressId) to default: false');
  //     if(oldAddressId == null){
  //       await addressService.updateDefaultAddress(oldAddressId, true);
  //
  //     }else{
  //       try {
  //         // Step 2: Set new address as default
  //         print('Setting new address ($newAddressId) to default: true');
  //         final response =  await addressService.updateDefaultAddress(newAddressId, true);
  //         if(response){
  //           defaultAddress.value = getAddressById(newAddressId);
  //         }
  //
  //       } catch (e) {
  //         // Rollback: If second call fails, revert the first change
  //         print('Second call failed, rolling back first change...');
  //         await addressService.updateDefaultAddress(oldAddressId, false);
  //         rethrow;
  //       }
  //     }
  //
  //     print('Default address switched successfully');
  //     return true;
  //   } catch (e) {
  //     print('Error switching default address: $e');
  //     rethrow;
  //   }
  // }
  // Future<bool> switchDefaultAddressWithRollback(
  //     String oldAddressId,
  //     String newAddressId,
  //     ) async {
  //   try {
  //     // If user selects the same address, do nothing
  //     if (oldAddressId == newAddressId) {
  //       print('Selected address is already default');
  //       return true;
  //     }
  //
  //     // Step 1: Set old default address to false
  //     print('Setting old address ($oldAddressId) to default: false');
  //     await addressService.updateDefaultAddress(oldAddressId, false);
  //
  //     try {
  //       // Step 2: Set new address as default
  //       print('Setting new address ($newAddressId) to default: true');
  //       final response =
  //       await addressService.updateDefaultAddress(newAddressId, true);
  //
  //       if (response) {
  //         defaultAddress.value = getAddressById(newAddressId);
  //       }
  //
  //       print('Default address switched successfully');
  //       return true;
  //     } catch (e) {
  //       // Rollback if new default fails
  //       print('New default failed, rolling back old address...');
  //       await addressService.updateDefaultAddress(oldAddressId, true);
  //       rethrow;
  //     }
  //   } catch (e) {
  //     print('Error switching default address: $e');
  //     rethrow;
  //   }
  // }
  Future<bool> switchDefaultAddressWithRollback({
    String? oldAddressId,
    required String newAddressId,
  }) async {
    try {
      // Case 1: Selected address is already default
      if (oldAddressId != null && oldAddressId == newAddressId) {
        print('Selected address already default');
        return true;
      }

      // Step 1: Disable old default ONLY if it exists
      if (oldAddressId != null && oldAddressId.isNotEmpty) {
        print('Setting old address ($oldAddressId) to default: false');
        await addressService.updateDefaultAddress(oldAddressId, false);
      }

      try {
        // Step 2: Enable new default
        print('Setting new address ($newAddressId) to default: true');
        final response =
        await addressService.updateDefaultAddress(newAddressId, true);

        if (response) {
          defaultAddress.value = getAddressById(newAddressId);
        }

        print('Default address switched successfully');
        return true;
      } catch (e) {
        // Rollback ONLY if old default existed
        if (oldAddressId != null && oldAddressId.isNotEmpty) {
          print('Rolling back old default...');
          await addressService.updateDefaultAddress(oldAddressId, true);
        }
        rethrow;
      }
    } catch (e) {
      print('Error switching default address: $e');
      rethrow;
    }
  }


}
