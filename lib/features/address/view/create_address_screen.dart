//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:newdow_customer/features/address/model/addressModel.dart';
// import 'package:newdow_customer/features/address/view/widgets/addressSearchBar.dart';
// import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
// import 'package:newdow_customer/features/cart/view/my_cart_screen.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/navbar.dart';
// import '../../../widgets/snackBar.dart';
// import '../controller/addressController.dart';
//
// class AddAddressScreen extends StatefulWidget {
//   final AddressModel? initialAddress;
//   bool isFromSelectDeliveryAddress;
//   final LatLng? searchedLocation;
//   final String? searchedAddress;
//
//    AddAddressScreen({
//     Key? key,
//     this.initialAddress,
//     this.isFromSelectDeliveryAddress = false,
//     this.searchedLocation,
//     this.searchedAddress,
//   }) : super(key: key);
//
//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }
//
// class _AddAddressScreenState extends State<AddAddressScreen> {
//   late AddressController controller;
//   bool showMapView = true;
//   GoogleMapController? _mapController;
//   LatLng? currentLatLng;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find<AddressController>();
//     print("print initila address ${widget.initialAddress?.country}");
//
//     // Route 1: From search location widget
//     if (widget.searchedLocation != null) {
//       // Set currentLatLng BEFORE addPostFrameCallback
//       currentLatLng = widget.searchedLocation;
//
//       if (kDebugMode) {
//         print("Route 1 - Searched Location");
//         print("currentLatLng: $currentLatLng");
//       }
//
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.updateAddressLocation(
//           widget.searchedLocation!.latitude,
//           widget.searchedLocation!.longitude,
//         );
//
//         if (widget.searchedAddress != null &&
//             widget.searchedAddress!.isNotEmpty) {
//           controller.streetController.text = widget.searchedAddress!;
//           controller.updateAddressField('street', widget.searchedAddress!);
//         }
//
//         // Fetch complete address details from coordinates
//         _getAddressFromCoordinates(
//           widget.searchedLocation!.latitude,
//           widget.searchedLocation!.longitude,
//         );
//
//         setState(() {}); // Force rebuild
//       });
//     }
//     // Route 2: Direct navigation with initial address
//     else if (widget.initialAddress != null) {
//       currentLatLng = LatLng(
//         widget.initialAddress!.latitude ?? 28.6139,
//         widget.initialAddress!.longitude ?? 77.2090,
//       );
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.setCurrentAddress(widget.initialAddress!);
//       });
//     }
//     // Route 3: Default - use user's default address
//     else {
//       controller.resetForm();
//       controller.setCurrentAddress(AddressModel.empty());
//
//       // Get default address from controller
//       final defaultAddr = controller.defaultAddress.value;
//
//       if (defaultAddr != null &&
//           defaultAddr.latitude != null &&
//           defaultAddr.longitude != null) {
//         // Set currentLatLng BEFORE addPostFrameCallback
//         currentLatLng = LatLng(
//           defaultAddr.latitude!,
//           defaultAddr.longitude!,
//         );
//
//         if (kDebugMode) {
//           print("Route 3 - Default Address");
//           print("currentLatLng: $currentLatLng");
//         }
//
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           // Pre-fill fields with default address
//           controller.streetController.text = defaultAddr.street ?? "";
//           controller.cityController.text = defaultAddr.city ?? "";
//           controller.stateController.text = defaultAddr.state ?? "";
//           controller.pincodeController.text = defaultAddr.pincode ?? "";
//           controller.countryController.text = defaultAddr.country ?? "";
//           controller.landmarkController.text = defaultAddr.landmark ?? "";
//
//           controller.updateAddressLocation(
//             defaultAddr.latitude!,
//             defaultAddr.longitude!,
//           );
//
//           setState(() {}); // Force rebuild
//         });
//       } else {
//         // Fallback to Delhi if no default address
//         currentLatLng = const LatLng(28.6139, 77.2090);
//
//         if (kDebugMode) {
//           print("Route 3 - Fallback Delhi");
//           print("currentLatLng: $currentLatLng");
//         }
//
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _getAddressFromCoordinates(28.6139, 77.2090);
//         });
//       }
//     }
//   }
//
//   void _switchToFormView() {
//     setState(() {
//       showMapView = false;
//     });
//   }
//
//   void _switchToMapView() {
//     setState(() {
//       showMapView = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.offAll(() => CustomBottomNav());
//         return false;
//       },
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               showMapView ? 'Select Location' : 'Add Address Details',
//               style: const TextStyle(fontSize: 22),
//             ),
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             centerTitle: true,
//             elevation: 0,
//           ),
//           body: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return showMapView
//                 ? _buildMapView(context)
//                 : _buildFormView(context);
//           }),
//         ),
//       ),
//     );
//   }
//
//   // MAP VIEW
//   Widget _buildMapView(BuildContext context) {
//     return Stack(
//       children: [
//         GoogleMap(
//           onMapCreated: (controller) => _mapController = controller,
//           initialCameraPosition: CameraPosition(
//             target: currentLatLng ?? const LatLng(28.6139, 77.2090),
//             zoom: 16,
//           ),
//           markers: currentLatLng != null
//               ? {
//             Marker(
//               markerId: const MarkerId("currentLocation"),
//               position: currentLatLng!,
//             ),
//           }
//               : {},
//           myLocationEnabled: true,
//           myLocationButtonEnabled: true,
//           onCameraMove: (position) {
//             setState(() {
//               currentLatLng = position.target;
//             });
//           },
//           onCameraIdle: () {
//             if (currentLatLng != null) {
//               _getAddressFromCoordinates(
//                 currentLatLng!.latitude,
//                 currentLatLng!.longitude,
//               );
//             }
//           },
//         ),
//         Positioned(
//           top: 10,
//           left: 16,
//           right: 16,
//           child: TextField(
//             onTap: () => Get.to(() => SearchAddressScreen(isFromAddressMannully: true,address: widget.initialAddress,isFromSelectDeliveryAddress: widget.isFromSelectDeliveryAddress,)),
//             readOnly: true,
//             decoration: InputDecoration(
//               hintText: "Search location...",
//               prefixIcon: const Icon(Icons.search),
//               filled: true,
//               fillColor: Colors.grey.shade200,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               contentPadding: const EdgeInsets.symmetric(vertical: 10),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 10,
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Selected Address Preview
//                   Obx(() {
//                     final address = controller.currentAddress.value;
//                     final street = controller.streetController.text;
//                     final city = controller.cityController.text;
//                     final state = controller.stateController.text;
//
//                     return Container(
//                       width: 1.toWidthPercent(),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: AppColors.secondary,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: AppColors.primary,
//                           width: 1,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Selected Location',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             street.isNotEmpty
//                                 ? '$street, $city, $state'
//                                 : 'Select a location on map',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             controller.resetForm();
//                             Get.offAll(() => CustomBottomNav());
//                           },
//                           style: OutlinedButton.styleFrom(
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (controller.streetController.text.isEmpty) {
//                               AppSnackBar.showError(context,
//                                   message:
//                                   'Please select a location on the map');
//                               return;
//                             }
//                             _switchToFormView();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             'Continue',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   Future<void> _getAddressFromCoordinates(double lat, double lng) async {
//     try {
//       final addressCtrl = Get.find<AddressController>();
//
//       // Use geocoding package directly
//       List<Placemark> placemarks = [];
//
//       try {
//         placemarks = await placemarkFromCoordinates(lat, lng);
//       } catch (e) {
//         if (kDebugMode) print("Geocoding error: $e");
//       }
//
//       // Check if placemarks list is not empty
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//
//         // Update text controllers
//         addressCtrl.streetController.text = place.street ?? "";
//         addressCtrl.landmarkController.text = place.subLocality ?? "";
//         addressCtrl.cityController.text = place.locality ?? "";
//         addressCtrl.stateController.text = place.administrativeArea ?? "";
//         addressCtrl.pincodeController.text = place.postalCode ?? "";
//         addressCtrl.countryController.text = place.country ?? "India";
//
//         // Update controller fields
//         addressCtrl.updateAddressField('street', place.street ?? "");
//         addressCtrl.updateAddressField('landmark', place.subLocality ?? "");
//         addressCtrl.updateAddressField('city', place.locality ?? "");
//         addressCtrl.updateAddressField('state', place.administrativeArea ?? "");
//         addressCtrl.updateAddressField('pincode', place.postalCode ?? "");
//         addressCtrl.updateAddressField('country', place.country ?? "India");
//         addressCtrl.updateAddressLocation(lat, lng);
//
//         setState(() {});
//       } else {
//         if (kDebugMode) print("No placemarks found for coordinates");
//       }
//     } catch (e) {
//       if (kDebugMode) print("Error getting address: $e");
//     }
//   }
//
//   // FORM VIEW
//   Widget _buildFormView(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(color: AppColors.background),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Error Message Display
//               if (controller.errorMessage.value.isNotEmpty)
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   margin: const EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.red[100],
//                     border: Border.all(color: Colors.red),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     controller.errorMessage.value,
//                     style: TextStyle(
//                       color: Colors.red[800],
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//
//               // Change Location Button
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton.icon(
//                   onPressed: _switchToMapView,
//                   icon: const Icon(Icons.location_on),
//                   label: const Text('Change Location from Map'),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // Address Type Selection
//               const Text(
//                 'Address Type',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Obx(
//                     () => Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: ['home', 'work']
//                       .map((type) {
//                     return Expanded(
//                       child: Padding(
//                         padding:
//                         const EdgeInsets.symmetric(horizontal: 4.0),
//                         child: ElevatedButton(
//                           onPressed: () =>
//                               controller.changeAddressType(type),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: controller
//                                 .currentAddress
//                                 .value
//                                 .type ==
//                                 type
//                                 ? AppColors.primary
//                                 : AppColors.secondary,
//                             foregroundColor: controller
//                                 .currentAddress
//                                 .value
//                                 .type ==
//                                 type
//                                 ? Colors.white
//                                 : Colors.grey[700],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             elevation: controller.currentAddress
//                                 .value.type ==
//                                 type
//                                 ? 2
//                                 : 0,
//                           ),
//                           child: Text(
//                             type[0].toUpperCase() + type.substring(1),
//                           ),
//                         ),
//                       ),
//                     );
//                   })
//                       .toList(),
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // Form Card
//               Card(
//                 color: AppColors.secondary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       // Street Address
//                       _buildTextField(
//                         label: 'Street Address',
//                         controller: controller.streetController,
//                         hint: "Enter street address",
//                         onChanged: (value) =>
//                             controller.updateAddressField('street', value),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // City and State
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(
//                               label: 'City',
//                               controller: controller.cityController,
//                               hint: "Enter city",
//                               onChanged: (value) =>
//                                   controller.updateAddressField(
//                                       'city', value),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildTextField(
//                               label: 'State',
//                               controller: controller.stateController,
//                               hint: "Enter state",
//                               onChanged: (value) =>
//                                   controller.updateAddressField(
//                                       'state', value),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Pincode and Country
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(
//                               label: 'Pincode',
//                               controller: controller.pincodeController,
//                               hint: "Enter pincode",
//                               onChanged: (value) =>
//                                   controller.updateAddressField(
//                                       'pincode', value),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildTextField(
//                               label: 'Country',
//                               controller: controller.countryController,
//                               hint: "Enter country",
//                               onChanged: (value) =>
//                                   controller.updateAddressField(
//                                       'country', value),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Landmark
//                       _buildTextField(
//                         label: 'Landmark (Optional)',
//                         controller: controller.landmarkController,
//                         hint: "Enter landmark",
//                         onChanged: (value) =>
//                             controller.updateAddressField('landmark', value),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Set as Default
//                       Obx(
//                             () => Row(
//                           children: [
//                             Checkbox(
//                               value: controller.setAsDefaultCheckbox.value,
//                               onChanged: (value) => controller
//                                   .toggleSetAsDefaultCheckbox(value ?? false),
//                               activeColor: AppColors.primary,
//                             ),
//                             const Text(
//                               'Set as default address',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // Action Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         controller.resetForm();
//                         Get.offAll(() => CustomBottomNav());
//                       },
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Cancel',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     // child: Obx(() {
//                     //   return ElevatedButton(
//                     //     onPressed:
//                     //       controller.isSaving.value
//                     //         ? null
//                     //         : () async {
//                     //       final createdAddress =
//                     //       await controller.createAddress(
//                     //         setAsDefault:
//                     //         controller.setAsDefaultCheckbox.value,
//                     //       );
//                     //
//                     //       if (createdAddress != null &&
//                     //           controller.errorMessage.value.isEmpty) {
//                     //         controller.resetCheckbox();
//                     //         Get.to(CustomBottomNav());
//                     //         AppSnackBar.showSuccess(context,
//                     //             message:
//                     //             "Address created successfully");
//                     //       }
//                     //     },
//                     //     style: ElevatedButton.styleFrom(
//                     //       backgroundColor: AppColors.primary,
//                     //       disabledBackgroundColor:
//                     //       AppColors.primary.withOpacity(0.5),
//                     //       padding: const EdgeInsets.symmetric(vertical: 14),
//                     //       shape: RoundedRectangleBorder(
//                     //         borderRadius: BorderRadius.circular(8),
//                     //       ),
//                     //     ),
//                     //
//                     //     child: controller.isSaving.value
//                     //         ? const SizedBox(
//                     //       height: 20,
//                     //       width: 20,
//                     //       child: CircularProgressIndicator(
//                     //         strokeWidth: 2,
//                     //         valueColor: AlwaysStoppedAnimation<Color>(
//                     //             Colors.white),
//                     //       ),
//                     //     )
//                     //         :  Text( widget.initialAddress == null ? "Confirm Address" :
//                     //       'Save Address',
//                     //       style: TextStyle(
//                     //         fontSize: 16,
//                     //         fontWeight: FontWeight.w600,
//                     //         color: Colors.white,
//                     //       ),
//                     //     ),
//                     //   );
//                     // }),
//                     child: Obx(() {
//                       final bool isCheckoutFlow = widget.isFromSelectDeliveryAddress;
//                       final bool wantsToSaveAddress = widget.initialAddress != null;
//
//                       return ElevatedButton(
//                         // onPressed:  controller.isSaving.value
//                         //     ? null
//                         //     : () async {
//                         //
//                         //   // CASE 1: Creating new address
//                         //   print("is initial address avail${widget.initialAddress != null}");
//                         //   if (widget.initialAddress != null && widget.isFromSelectDeliveryAddress == false) {
//                         //     final createdAddress =
//                         //     await controller.createAddress(
//                         //       setAsDefault:
//                         //       controller.setAsDefaultCheckbox.value,
//                         //     );
//                         //
//                         //     if (createdAddress != null &&
//                         //         controller.errorMessage.value.isEmpty) {
//                         //       controller.resetCheckbox();
//                         //       Get.to(() => CustomBottomNav());
//                         //       AppSnackBar.showSuccess(
//                         //         context,
//                         //         message: "Address created successfully",
//                         //       );
//                         //     }
//                         //   }
//                         //
//                         //   // CASE 2: Selecting address from map
//                         //   else {
//                         //     if (controller.currentAddress.value != null) {
//                         //       controller.selectedDeliveryAddress.value =
//                         //           controller.currentAddress.value;
//                         //       await Get.find<CartController>().calculateCheckout(controller.selectedDeliveryAddress?.value ?? AddressModel.empty());
//                         //
//                         //       Get.to(() => CartScreen(isFromBottamNav: false)); // close map / bottom sheet
//                         //     } else {
//                         //       controller.selectedDeliveryAddress.value =
//                         //           controller.defaultAddress.value;
//                         //       AppSnackBar.showInfo(
//                         //         context,
//                         //         message: "Please select a location",
//                         //       );
//                         //     }
//                         //   }
//                         //},
//                         onPressed: controller.isSaving.value
//                             ? null
//                             : () async {
//
//                           // ===============================
//                           // CHECKOUT FLOW (NO SAVE REQUIRED)
//                           // ===============================
//                           if (isCheckoutFlow) {
//                             if (controller.currentAddress.value == null) {
//                               AppSnackBar.showInfo(
//                                 context,
//                                 message: "Please select a delivery location",
//                               );
//                               return;
//                             }
//
//                             // Use TEMPORARY address for checkout
//                             controller.selectedDeliveryAddress.value =
//                                 controller.currentAddress.value;
//
//                             await Get.find<CartController>().calculateCheckout(
//                               controller.selectedDeliveryAddress.value!,
//                             );
//
//                             Get.to(() => CartScreen(isFromBottamNav: false));
//                             return;
//                           }
//
//                           // ===============================
//                           // ADDRESS CREATION FLOW (OPTIONAL)
//                           // ===============================
//                           final createdAddress = await controller.createAddress(
//                             setAsDefault: controller.setAsDefaultCheckbox.value,
//                           );
//
//                           if (createdAddress != null &&
//                               controller.errorMessage.value.isEmpty) {
//                             controller.resetCheckbox();
//
//                             AppSnackBar.showSuccess(
//                               context,
//                               message: "Address saved successfully",
//                             );
//
//                             Get.to(() => CustomBottomNav());
//                           }
//                         },
//
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           disabledBackgroundColor:
//                           AppColors.primary.withOpacity(0.5),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: controller.isSaving.value
//                             ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                             AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                             : Text(
//                           //widget.initialAddress == null
//                           // (widget.initialAddress != null && widget.isFromSelectDeliveryAddress)
//                           //     ? "Confirm Address"
//                           //     : "Save Address",
//                           widget.isFromSelectDeliveryAddress
//                               ? "Confirm Address"
//                               : "Save Address",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       );
//                     }),
//
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//     required ValueChanged<String> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           onChanged: onChanged,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: AppColors.textSecondary),
//             filled: true,
//             fillColor: AppColors.background,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide:
//               const BorderSide(color: AppColors.primary, width: 2),
//             ),
//             contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/address/view/widgets/addressSearchBar.dart';
import 'package:newdow_customer/features/cart/controller/cart_controller.dart';
import 'package:newdow_customer/features/cart/view/my_cart_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/navbar.dart';
import '../../../widgets/snackBar.dart';
import '../controller/addressController.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? initialAddress;
  bool isFromSelectDeliveryAddress;
  final LatLng? searchedLocation;
  final String? searchedAddress;

  AddAddressScreen({
    Key? key,
    this.initialAddress,
    this.isFromSelectDeliveryAddress = false,
    this.searchedLocation,
    this.searchedAddress,
  }) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late AddressController controller;
  bool showMapView = true;
  GoogleMapController? _mapController;
  LatLng? currentLatLng;

  @override
  void initState() {
    super.initState();
    loadCustomMarker();
    controller = Get.find<AddressController>();

    print("print initila address ${widget.initialAddress?.country}");

    // Route 1: From search location widget
    if (widget.searchedLocation != null) {
      // Set currentLatLng BEFORE addPostFrameCallback
      currentLatLng = widget.searchedLocation;

      if (kDebugMode) {
        print("Route 1 - Searched Location");
        print("currentLatLng: $currentLatLng");
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.updateAddressLocation(
          widget.searchedLocation!.latitude,
          widget.searchedLocation!.longitude,
        );

        if (widget.searchedAddress != null &&
            widget.searchedAddress!.isNotEmpty) {
          controller.streetController.text = widget.searchedAddress!;
          controller.updateAddressField('street', widget.searchedAddress!);
        }

        // Fetch complete address details from coordinates
        _getAddressFromCoordinates(
          widget.searchedLocation!.latitude,
          widget.searchedLocation!.longitude,
        );

        setState(() {}); // Force rebuild
      });
    }
    // Route 2: Direct navigation with initial address
    else if (widget.initialAddress != null) {
      currentLatLng = LatLng(
        widget.initialAddress!.latitude ?? 28.6139,
        widget.initialAddress!.longitude ?? 77.2090,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setCurrentAddress(widget.initialAddress!);
      });
    }
    // Route 3: Default - use user's default address
    else {
      controller.resetForm();
      controller.setCurrentAddress(AddressModel.empty());

      // Get default address from controller
      final defaultAddr = controller.defaultAddress.value;

      if (defaultAddr != null &&
          defaultAddr.latitude != null &&
          defaultAddr.longitude != null) {
        // Set currentLatLng BEFORE addPostFrameCallback
        currentLatLng = LatLng(
          defaultAddr.latitude!,
          defaultAddr.longitude!,
        );

        if (kDebugMode) {
          print("Route 3 - Default Address");
          print("currentLatLng: $currentLatLng");
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Pre-fill fields with default address
          controller.streetController.text = defaultAddr.street ?? "";
          controller.cityController.text = defaultAddr.city ?? "";
          controller.stateController.text = defaultAddr.state ?? "";
          controller.pincodeController.text = defaultAddr.pincode ?? "";
          controller.countryController.text = defaultAddr.country ?? "";
          controller.landmarkController.text = defaultAddr.landmark ?? "";

          controller.updateAddressLocation(
            defaultAddr.latitude!,
            defaultAddr.longitude!,
          );

          setState(() {}); // Force rebuild
        });
      } else {
        // Fallback to Delhi if no default address
        currentLatLng = const LatLng(28.6139, 77.2090);

        if (kDebugMode) {
          print("Route 3 - Fallback Delhi");
          print("currentLatLng: $currentLatLng");
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _getAddressFromCoordinates(28.6139, 77.2090);
        });
      }
    }
  }

  void _switchToFormView() {
    setState(() {
      showMapView = false;
    });
  }

  void _switchToMapView() {
    setState(() {
      showMapView = true;
    });
  }
   BitmapDescriptor? customMarker;

  Future<void> loadCustomMarker() async {
    final marker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      location_marker,
    );

    setState(() {
      customMarker = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => CustomBottomNav());
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              showMapView ? 'Select Location' : 'Add Address Details',
              style: const TextStyle(fontSize: 22),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return showMapView
                ? _buildMapView(context)
                : _buildFormView(context);
          }),
        ),
      ),
    );
  }

  // MAP VIEW
  Widget _buildMapView(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) => _mapController = controller,
          initialCameraPosition: CameraPosition(
            target: currentLatLng ?? const LatLng(28.6139, 77.2090),
            zoom: 16,
          ),
          // markers: currentLatLng != null
          //     ? {
          //   Marker(
          //     markerId: const MarkerId("currentLocation"),
          //     position: currentLatLng!,
          //     icon: customMarker
          //   ),
          // }
          //     : {},
          markers: (currentLatLng != null && customMarker != null)
              ? {
            Marker(
              markerId: const MarkerId("currentLocation"),
              position: currentLatLng!,
              icon: customMarker!,
            ),
          }
              : {},
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (position) {
            setState(() {
              currentLatLng = position.target;
            });
          },
          // onCameraMove: (position) {
          //   currentLatLng = position.target;
          // },
          onCameraIdle: () {
            if (currentLatLng != null) {
              _getAddressFromCoordinates(
                currentLatLng!.latitude,
                currentLatLng!.longitude,
              );
            }
          },
        ),
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: TextField(
            onTap: () => Get.to(() => SearchAddressScreen(isFromAddressMannully: true,address: widget.initialAddress,isFromSelectDeliveryAddress: widget.isFromSelectDeliveryAddress,)),
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Search location...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Selected Address Preview
                  Obx(() {
                    final address = controller.currentAddress.value;
                    final street = controller.streetController.text;
                    final city = controller.cityController.text;
                    final state = controller.stateController.text;

                    return Container(
                      width: 1.toWidthPercent(),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Location',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            street.isNotEmpty
                                ? '$street, $city, $state'
                                : 'Select a location on map',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.resetForm();
                            Get.offAll(() => CustomBottomNav());
                          },
                          style: OutlinedButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.streetController.text.isEmpty) {
                              AppSnackBar.showError(context,
                                  message:
                                  'Please select a location on the map');
                              return;
                            }
                            _switchToFormView();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final addressCtrl = Get.find<AddressController>();

      // Use geocoding package directly
      List<Placemark> placemarks = [];

      try {
        placemarks = await placemarkFromCoordinates(lat, lng);
      } catch (e) {
        if (kDebugMode) print("Geocoding error: $e");
      }

      // Check if placemarks list is not empty
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        // Update text controllers
        addressCtrl.streetController.text = place.street ?? "";
        addressCtrl.landmarkController.text = place.subLocality ?? "";
        addressCtrl.cityController.text = place.locality ?? "";
        addressCtrl.stateController.text = place.administrativeArea ?? "";
        addressCtrl.pincodeController.text = place.postalCode ?? "";
        addressCtrl.countryController.text = place.country ?? "India";

        // Update controller fields
        addressCtrl.updateAddressField('street', place.street ?? "");
        addressCtrl.updateAddressField('landmark', place.subLocality ?? "");
        addressCtrl.updateAddressField('city', place.locality ?? "");
        addressCtrl.updateAddressField('state', place.administrativeArea ?? "");
        addressCtrl.updateAddressField('pincode', place.postalCode ?? "");
        addressCtrl.updateAddressField('country', place.country ?? "India");
        addressCtrl.updateAddressLocation(lat, lng);

        //setState(() {});
      } else {
        if (kDebugMode) print("No placemarks found for coordinates");
      }
    } catch (e) {
      if (kDebugMode) print("Error getting address: $e");
    }
  }

  // FORM VIEW
  Widget _buildFormView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error Message Display
              if (controller.errorMessage.value.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 12,
                    ),
                  ),
                ),

              // Change Location Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _switchToMapView,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Change Location from Map'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Address Type Selection
              const Text(
                'Address Type',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['home', 'work']
                      .map((type) {
                    return Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              controller.changeAddressType(type),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller
                                .currentAddress
                                .value
                                .type ==
                                type
                                ? AppColors.primary
                                : AppColors.secondary,
                            foregroundColor: controller
                                .currentAddress
                                .value
                                .type ==
                                type
                                ? Colors.white
                                : Colors.grey[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: controller.currentAddress
                                .value.type ==
                                type
                                ? 2
                                : 0,
                          ),
                          child: Text(
                            type[0].toUpperCase() + type.substring(1),
                          ),
                        ),
                      ),
                    );
                  })
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Form Card
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Street Address
                      _buildTextField(
                        label: 'Street Address',
                        controller: controller.streetController,
                        hint: "Enter street address",
                        onChanged: (value) =>
                            controller.updateAddressField('street', value),
                      ),
                      const SizedBox(height: 16),

                      // City and State
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'City',
                              controller: controller.cityController,
                              hint: "Enter city",
                              onChanged: (value) =>
                                  controller.updateAddressField(
                                      'city', value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              label: 'State',
                              controller: controller.stateController,
                              hint: "Enter state",
                              onChanged: (value) =>
                                  controller.updateAddressField(
                                      'state', value),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Pincode and Country
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Pincode',
                              controller: controller.pincodeController,
                              hint: "Enter pincode",
                              onChanged: (value) =>
                                  controller.updateAddressField(
                                      'pincode', value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              label: 'Country',
                              controller: controller.countryController,
                              hint: "Enter country",
                              onChanged: (value) =>
                                  controller.updateAddressField(
                                      'country', value),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Landmark
                      _buildTextField(
                        label: 'Landmark (Optional)',
                        controller: controller.landmarkController,
                        hint: "Enter landmark",
                        onChanged: (value) =>
                            controller.updateAddressField('landmark', value),
                      ),
                      const SizedBox(height: 16),

                      // Set as Default
                      Obx(
                            () => Row(
                          children: [
                            Checkbox(
                              value: controller.setAsDefaultCheckbox.value,
                              onChanged: (value) => controller
                                  .toggleSetAsDefaultCheckbox(value ?? false),
                              activeColor: AppColors.primary,
                            ),
                            const Text(
                              'Set as default address',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.resetForm();
                        Get.offAll(() => CustomBottomNav());
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() {
                      final bool isCheckoutFlow = widget.isFromSelectDeliveryAddress;
                      final bool wantsToSaveAddress = widget.initialAddress != null;

                      return ElevatedButton(
                        onPressed: controller.isSaving.value
                            ? null
                            : () async {

                          // ===============================
                          // CHECKOUT FLOW (NO SAVE REQUIRED)
                          // ===============================
                          if (isCheckoutFlow) {
                            if (controller.currentAddress.value == null) {
                              AppSnackBar.showInfo(
                                context,
                                message: "Please select a delivery location",
                              );
                              return;
                            }
                            final createdAddress =
                                await controller.createAddress(
                                  setAsDefault:
                                  controller.setAsDefaultCheckbox.value,
                                );
                            controller.selectedDeliveryAddress.value =
                                createdAddress ?? AddressModel.empty();

                            await Get.find<CartController>().calculateCheckout(
                              controller.selectedDeliveryAddress.value!,
                            );

                            Get.offAll(() => CartScreen(isFromBottamNav: false));
                            return;
                          }

                          // ===============================
                          // ADDRESS CREATION FLOW (OPTIONAL)
                          // ===============================
                          final createdAddress = await controller.createAddress(
                            setAsDefault: controller.setAsDefaultCheckbox.value,
                          );

                          if (createdAddress != null &&
                              controller.errorMessage.value.isEmpty) {
                            controller.resetCheckbox();

                            AppSnackBar.showSuccess(
                              context,
                              message: "Address saved successfully",
                            );

                            Get.offAll(() => CustomBottomNav());
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor:
                          AppColors.primary.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: controller.isSaving.value
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : Text(
                          //widget.initialAddress == null
                          // (widget.initialAddress != null && widget.isFromSelectDeliveryAddress)
                          //     ? "Confirm Address"
                          //     : "Save Address",
                          widget.isFromSelectDeliveryAddress
                              ? "Confirm Address"
                              : "Save Address",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),

                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}