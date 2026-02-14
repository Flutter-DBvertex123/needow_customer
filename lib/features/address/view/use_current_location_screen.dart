// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:newdow_customer/widgets/appbutton.dart';
// //
// // import '../../../utils/apptheme.dart';
// // import '../../../widgets/navbar.dart';
// // import '../controller/addressController.dart';
// //
// // class LocationPickerScreen extends StatefulWidget {
// //   const LocationPickerScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// // }
// //
// // class _LocationPickerScreenState extends State<LocationPickerScreen> {
// //   GoogleMapController? _mapController;
// //
// //   LatLng? currentLatLng;
// //   String currentAddress = "Fetching address...";
// //   bool setAsDefault = false;
// //
// //   String addressType = "home"; // home / work
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchCurrentLocation();
// //   }
// //   final controller = Get.find<AddressController>();
// //   Future<void> _fetchCurrentLocation() async {
// //     LocationPermission permission =
// //     await Geolocator.requestPermission();
// //
// //     if (permission == LocationPermission.denied ||
// //         permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Location permission denied")),
// //       );
// //       return;
// //     }
// //
// //     Position pos = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );
// //
// //     setState(() {
// //       currentLatLng = LatLng(pos.latitude, pos.longitude);
// //     });
// //
// //     _getAddress(pos.latitude, pos.longitude);
// //   }
// //
// //   Future<void> _getAddress(double lat, double lng) async {
// //     List<Placemark> placemarks =
// //     await placemarkFromCoordinates(lat, lng);
// //     controller.updateAddressLocation(
// //       lat,
// //       lng,
// //     );
// //     Placemark place = placemarks.first;
// //     controller.streetController.text = place.street ?? "";
// //     controller.landmarkController.text = place.subLocality ?? "";
// //     controller.cityController.text = place.locality ?? "";
// //     controller.stateController.text = place.administrativeArea ?? "";
// //     controller.pincodeController.text = place.postalCode ?? "";
// //     setState(() {
// //       currentAddress =
// //       "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       top: false,
// //       child: Scaffold(
// //         body: currentLatLng == null
// //             ? const Center(child: CircularProgressIndicator())
// //             : Stack(
// //           children: [
// //             GoogleMap(
// //               onMapCreated: (controller) => _mapController = controller,
// //               initialCameraPosition: CameraPosition(
// //                 target: currentLatLng!,
// //                 zoom: 16,
// //               ),
// //               markers: {
// //                 Marker(
// //                   markerId: const MarkerId("currentLocation"),
// //                   position: currentLatLng!,
// //                 ),
// //               },
// //               myLocationEnabled: true,
// //               myLocationButtonEnabled: true,
// //             ),
// //
// //             /// Bottom Panel
// //             Align(
// //               alignment: Alignment.bottomCenter,
// //               child: Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius:
// //                   const BorderRadius.vertical(top: Radius.circular(20)),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.15),
// //                       blurRadius: 10,
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //
// //                     /// Checkbox
// //
// //                         Obx(() {
// //                           return Row(
// //                             children: [
// //                               Checkbox(
// //                                 value: controller.setAsDefaultCheckbox.value,
// //                                 onChanged: (value) =>
// //                                     controller.toggleSetAsDefaultCheckbox(value ?? false),
// //                                 activeColor: AppColors.primary,
// //                               ),
// //                               const Text(
// //                                 'Set as default address',
// //                                 style: TextStyle(
// //                                   fontSize: 14,
// //                                   fontWeight: FontWeight.w500,
// //                                 ),
// //                               ),
// //                             ],
// //                           );
// //                         }),
// //
// //
// //                     const SizedBox(height: 10),
// //
// //                     /// Address Type
// //                     Row(
// //                       children: [
// //                         Radio(
// //                           value: "home",
// //                           groupValue: addressType,
// //                           onChanged: (value) {
// //                             controller.changeAddressType("home");
// //                           },
// //                         ),
// //                         const Text("Home"),
// //
// //                         const SizedBox(width: 20),
// //
// //                         Radio(
// //                           value: "work",
// //                           groupValue: addressType,
// //                           onChanged: (value) {
// //                             controller.changeAddressType("work");
// //                           },
// //                         ),
// //                         const Text("Work"),
// //                       ],
// //                     ),
// //
// //                     const SizedBox(height: 10),
// //
// //                     /// Address TextField
// //                     TextField(
// //                       controller: TextEditingController(
// //                         text: currentAddress,
// //                       ),
// //                       readOnly: true,
// //                       maxLines: 2,
// //                       decoration: const InputDecoration(
// //                         labelText: "Address",
// //                         border: OutlineInputBorder(),
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 15),
// //
// //                     /// Save Button
// //                     Appbutton(
// //                         buttonText: "Save",
// //                         onTap: () async {
// //                           // Pass the checkbox value to createAddress
// //                           final createdAddress =
// //                               await controller.createAddress(
// //                             setAsDefault: controller.setAsDefaultCheckbox.value,
// //                           );
// //
// //                           if (createdAddress != null &&
// //                               controller.errorMessage.value.isEmpty) {
// //                             // Reset checkbox after successful creation
// //                             controller.resetCheckbox();
// //                             Get.to(CustomBottomNav());
// //                           }
// //                         },
// //                         // onTap: () {
// //                         //     Navigator.pop(context, {
// //                         //       "lat": currentLatLng!.latitude,
// //                         //       "lng": currentLatLng!.longitude,
// //                         //       "address": currentAddress,
// //                         //       "default": setAsDefault,
// //                         //       "type": addressType,
// //                         //     });
// //                         //   },
// //                         isLoading: false),
// //                     SizedBox(height: 10,)
// //                     // SizedBox(
// //                     //   width: double.infinity,
// //                     //   child: ElevatedButton(
// //                     //     onPressed: () {
// //                     //       Navigator.pop(context, {
// //                     //         "lat": currentLatLng!.latitude,
// //                     //         "lng": currentLatLng!.longitude,
// //                     //         "address": currentAddress,
// //                     //         "default": setAsDefault,
// //                     //         "type": addressType,
// //                     //       });
// //                     //     },
// //                     //     child: const Text("Save"),
// //                     //   ),
// //                     // )
// //                   ],
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:newdow_customer/widgets/appbutton.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
//
// import '../../../utils/apptheme.dart';
// import '../../../widgets/navbar.dart';
// import '../controller/addressController.dart';
//
// class LocationPickerScreen extends StatefulWidget {
//   const LocationPickerScreen({Key? key}) : super(key: key);
//
//   @override
//   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// }
//
// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   GoogleMapController? _mapController;
//
//   LatLng? currentLatLng;
//   String currentAddress = "Fetching address...";
//   late RxString addressType;
//
//   final controller = Get.find<AddressController>();
//
//   @override
//   void initState() {
//     super.initState();
//     addressType = "home".obs;
//     _fetchCurrentLocation();
//   }
//
//   Future<void> _fetchCurrentLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location permission denied")),
//       );
//       return;
//     }
//
//     Position pos = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     setState(() {
//       currentLatLng = LatLng(pos.latitude, pos.longitude);
//     });
//
//     _getAddress(pos.latitude, pos.longitude);
//   }
//
//   Future<void> _getAddress(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//
//       Placemark place = placemarks.first;
//
//       // Update text controllers with address data
//       controller.streetController.text = place.street ?? "";
//       controller.landmarkController.text = place.subLocality ?? "";
//       controller.cityController.text = place.locality ?? "";
//       controller.stateController.text = place.administrativeArea ?? "";
//       controller.pincodeController.text = place.postalCode ?? "";
//       controller.countryController.text = place.country ?? "India";
//
//       // Update controller's currentAddress with all data
//       controller.updateAddressField('street', place.street ?? "");
//       controller.updateAddressField('landmark', place.subLocality ?? "");
//       controller.updateAddressField('city', place.locality ?? "");
//       controller.updateAddressField('state', place.administrativeArea ?? "");
//       controller.updateAddressField('pincode', place.postalCode ?? "");
//       controller.updateAddressField('country', place.country ?? "India");
//       controller.updateAddressLocation(lat, lng);
//
//       // Update current address display
//       setState(() {
//         currentAddress =
//         "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
//       });
//     } catch (e) {
//       print("Error getting address: $e");
//       setState(() {
//         currentAddress = "Unable to fetch address";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.offAll(() => CustomBottomNav());  // navigate to home instead of closing app
//         return false; // prevent default back close
//       },
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           body: currentLatLng == null
//               ? const Center(child: CircularProgressIndicator())
//               : Stack(
//             children: [
//               GoogleMap(
//                 onMapCreated: (mapController) => _mapController = mapController,
//                 initialCameraPosition: CameraPosition(
//                   target: currentLatLng!,
//                   zoom: 16,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId("currentLocation"),
//                     position: currentLatLng!,
//                   ),
//                 },
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//                 onTap: (LatLng tappedPoint) {
//                   setState(() {
//                     currentLatLng = tappedPoint;
//                   });
//                   _getAddress(tappedPoint.latitude, tappedPoint.longitude);
//                 },
//               ),
//
//               /// Bottom Panel
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(20)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         /// Checkbox
//                         Obx(() {
//                           return Row(
//                               children: [
//                                 Checkbox(
//                                   value: controller.setAsDefaultCheckbox.value,
//                                   onChanged: (value) {
//                                     controller.toggleSetAsDefaultCheckbox(
//                                         value ?? false);
//                                   },
//                                   activeColor: AppColors.primary,
//                                 ),
//                                 const Text(
//                                   'Set as default address',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ]
//                           );
//                         }),
//
//                         const SizedBox(height: 10),
//
//                         /// Address Type
//                         Obx(() {
//                           return Row(
//                               children: [
//                                 Radio<String>(
//                                   value: "home",
//                                   groupValue: addressType.value,
//                                   onChanged: (value) {
//                                     if (value != null) {
//                                       addressType.value = value;
//                                       controller.changeAddressType(value);
//                                     }
//                                   },
//                                 ),
//                                 const Text("Home"),
//                                 const SizedBox(width: 20),
//                                 Radio<String>(
//                                   value: "work",
//                                   groupValue: addressType.value,
//                                   onChanged: (value) {
//                                     if (value != null) {
//                                       addressType.value = value;
//                                       controller.changeAddressType(value);
//                                     }
//                                   },
//                                 ),
//                                 const Text("Work"),
//                               ]
//                           );
//                         }),
//
//                         const SizedBox(height: 10),
//
//                         /// Address TextField
//                         TextField(
//                           controller: TextEditingController(
//                             text: currentAddress,
//                           ),
//                           readOnly: true,
//                           maxLines: 2,
//                           decoration: const InputDecoration(
//                             labelText: "Address",
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//
//                         const SizedBox(height: 15),
//
//                         /// Save Button
//                          Appbutton(
//                             buttonText: "Save",
//                             onTap: () async {
//                               Get.find<LoadingController>().isLoading.value = true;
//                               final createdAddress =
//                               await controller.createAddress(
//                                 setAsDefault: controller
//                                     .setAsDefaultCheckbox.value,
//                               );
//
//                               if (createdAddress != null &&
//                                   controller.errorMessage.value.isEmpty) {
//                                 controller.resetCheckbox();
//                                 controller.resetForm();
//                                 Get.to(() => CustomBottomNav());
//                                 Get.find<LoadingController>().isLoading.value = false;
//                                 AppSnackBar.showSuccess(context, message: "Address created successfully");
//                               }
//                             },
//                          ),
//                         const SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:newdow_customer/features/address/view/widgets/addressSearchBar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as fplaces;

import '../../../utils/apptheme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/navbar.dart';
import '../controller/addressController.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng? searchedLocation;
  final String? searchedAddress;

  const LocationPickerScreen({
    Key? key,
    this.searchedLocation,
    this.searchedAddress,
  }) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  TextEditingController searchController = TextEditingController();
  late fplaces.FlutterGooglePlacesSdk places;

  LatLng? currentLatLng;
  String currentAddress = "Fetching address...";
  late RxString addressType;

  final controller = Get.find<AddressController>();
  List<fplaces.AutocompletePrediction> predictions = [];

  @override
  void initState() {
    super.initState();
    loadCustomMarker();
    addressType = "home".obs;
    //places = fplaces.FlutterGooglePlacesSdk("AIzaSyC34xupC2K8bUvYaJ6I5waaklH8WcADpsg");
    places = fplaces.FlutterGooglePlacesSdk(placesKey);

    // If location is passed from search, use it
    if (widget.searchedLocation != null) {
      currentLatLng = widget.searchedLocation;
      currentAddress = widget.searchedAddress ?? "Fetching address...";
      _getAddress(currentLatLng!.latitude, currentLatLng!.longitude);
    } else {
      _fetchCurrentLocation();
    }
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
  Future<void> _fetchCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLatLng = LatLng(pos.latitude, pos.longitude);
    });

    _getAddress(pos.latitude, pos.longitude);
  }

  Future<void> _getAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      Placemark place = placemarks.first;

      controller.streetController.text = place.street ?? "";
      controller.landmarkController.text = place.subLocality ?? "";
      controller.cityController.text = place.locality ?? "";
      controller.stateController.text = place.administrativeArea ?? "";
      controller.pincodeController.text = place.postalCode ?? "";
      controller.countryController.text = place.country ?? "India";

      controller.updateAddressField('street', place.street ?? "");
      controller.updateAddressField('landmark', place.subLocality ?? "");
      controller.updateAddressField('city', place.locality ?? "");
      controller.updateAddressField('state', place.administrativeArea ?? "");
      controller.updateAddressField('pincode', place.postalCode ?? "");
      controller.updateAddressField('country', place.country ?? "India");
      controller.updateAddressLocation(lat, lng);

      setState(() {
        currentAddress =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
      });
    } catch (e) {
      print("Error getting address: $e");
      setState(() {
        currentAddress = "Unable to fetch address";
      });
    }
  }

  /// 🔍 Fetch autocomplete suggestions
  void searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() => predictions = []);
      return;
    }

    final result = await places.findAutocompletePredictions(
      input,
      countries: ['in'],
    );

    setState(() {
      predictions = result.predictions;
    });
  }

  /// 📍 Get latitude & longitude and navigate
  Future<void> selectPlace(String placeId, String description) async {
    try {
      final result = await places.fetchPlace(
        placeId,
        fields: [
          fplaces.PlaceField.Location,
          fplaces.PlaceField.AddressComponents,
        ],
      );

      final lat = result.place?.latLng?.lat;
      final lng = result.place?.latLng?.lng;

      if (lat != null && lng != null) {
        setState(() {
          currentLatLng = LatLng(lat, lng);
          searchController.text = description;
          predictions = [];
        });

        await _getAddress(lat, lng);
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
        );
      }
    } catch (e) {
      print("Error selecting place: $e");
    }
  }
  Future<void> animateCameraToLocation(LatLng location, {double zoom = 16}) async {
    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, zoom),
    );
  }

  /// Move camera instantly
  Future<void> moveCamera(LatLng location, {double zoom = 16}) async {
    _mapController?.moveCamera(
      CameraUpdate.newLatLngZoom(location, zoom),
    );
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
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("Add Address", style: TextStyle(color: Colors.black),),
            centerTitle: true,
          ),
          body: currentLatLng == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
            children: [

              // GoogleMap(
              //   onMapCreated: (mapController) =>
              //   _mapController = mapController,
              //   initialCameraPosition: CameraPosition(
              //     target: currentLatLng!,
              //     zoom: 16,
              //   ),
              //   markers: {
              //     Marker(
              //       markerId: const MarkerId("currentLocation"),
              //       position: currentLatLng!,
              //     ),
              //   },
              //   myLocationEnabled: true,
              //   myLocationButtonEnabled: true,
              //   onTap: (LatLng tappedPoint) {
              //     setState(() {
              //       currentLatLng = tappedPoint;
              //     });
              //     _getAddress(tappedPoint.latitude, tappedPoint.longitude);
              //   },
              // ),
              Column(
                children: [
                  Expanded(
                    child: Expanded(
                      child: GoogleMap(
                        onMapCreated: (controller) => _mapController = controller,
                        initialCameraPosition: CameraPosition(
                          target: currentLatLng!,
                          zoom: 16,
                        ),
                        // markers: currentLatLng != null
                        //     ? {
                        //   Marker(
                        //
                        //     markerId: const MarkerId("currentLocation"),
                        //     position: currentLatLng!,
                        //
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
                          // Update marker position as camera moves
                          setState(() {
                            currentLatLng = position.target;
                          });
                        },
                        onCameraIdle: () {
                          // Fetch address when camera stops
                          if (currentLatLng != null) {
                            _getAddress(currentLatLng!.latitude, currentLatLng!.longitude);
                          }
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
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
                            /// Checkbox
                            Obx(() {
                              return Row(children: [
                                Checkbox(
                                  value: controller
                                      .setAsDefaultCheckbox.value,
                                  onChanged: (value) {
                                    controller.toggleSetAsDefaultCheckbox(
                                        value ?? false);
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                const Text(
                                  'Set as default address',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]);
                            }),

                            const SizedBox(height: 10),

                            /// Address Type
                            Obx(() {
                              return Row(children: [
                                Radio<String>(
                                  value: "home",
                                  groupValue: addressType.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      addressType.value = value;
                                      controller.changeAddressType(value);
                                    }
                                  },
                                ),
                                const Text("Home"),
                                const SizedBox(width: 20),
                                Radio<String>(
                                  value: "work",
                                  groupValue: addressType.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      addressType.value = value;
                                      controller.changeAddressType(value);
                                    }
                                  },
                                ),
                                const Text("Work"),
                              ]);
                            }),

                            const SizedBox(height: 10),

                            /// Address TextField
                            TextField(
                              controller: TextEditingController(
                                text: currentAddress,
                              ),
                              readOnly: true,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                labelText: "Address",
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 15),

                            /// Save Button
                            Appbutton(
                              buttonText: "Save",
                              onTap: () async {
                                Get.find<LoadingController>()
                                    .isLoading
                                    .value = true;
                                final createdAddress =
                                await controller.createAddress(
                                  setAsDefault: controller
                                      .setAsDefaultCheckbox.value,
                                );

                                if (createdAddress != null &&
                                    controller.errorMessage.value.isEmpty) {
                                  controller.resetCheckbox();
                                  controller.resetForm();
                                  Get.to(() => CustomBottomNav());
                                  Get.find<LoadingController>()
                                      .isLoading
                                      .value = false;
                                  AppSnackBar.showSuccess(context,
                                      message:
                                      "Address created successfully");
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: TextField(
                  onTap: () => Get.to(() => SearchAddressScreen()),
                  controller: searchController,
                  //onChanged: searchPlaces,
                  decoration: InputDecoration(
                    hintText: "Search location...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              /// 🔍 Search Results Dropdown
              if (predictions.isNotEmpty)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        final p = predictions[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(p.fullText ?? ""),
                          onTap: () =>
                              selectPlace(p.placeId!, p.fullText ?? ""),
                        );
                      },
                    ),
                  ),
                ),

              /// Bottom Panel
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: const BorderRadius.vertical(
              //           top: Radius.circular(20)),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.15),
              //           blurRadius: 10,
              //         ),
              //       ],
              //     ),
              //     child: SingleChildScrollView(
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           /// Checkbox
              //           Obx(() {
              //             return Row(children: [
              //               Checkbox(
              //                 value: controller
              //                     .setAsDefaultCheckbox.value,
              //                 onChanged: (value) {
              //                   controller.toggleSetAsDefaultCheckbox(
              //                       value ?? false);
              //                 },
              //                 activeColor: AppColors.primary,
              //               ),
              //               const Text(
              //                 'Set as default address',
              //                 style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ]);
              //           }),
              //
              //           const SizedBox(height: 10),
              //
              //           /// Address Type
              //           Obx(() {
              //             return Row(children: [
              //               Radio<String>(
              //                 value: "home",
              //                 groupValue: addressType.value,
              //                 onChanged: (value) {
              //                   if (value != null) {
              //                     addressType.value = value;
              //                     controller.changeAddressType(value);
              //                   }
              //                 },
              //               ),
              //               const Text("Home"),
              //               const SizedBox(width: 20),
              //               Radio<String>(
              //                 value: "work",
              //                 groupValue: addressType.value,
              //                 onChanged: (value) {
              //                   if (value != null) {
              //                     addressType.value = value;
              //                     controller.changeAddressType(value);
              //                   }
              //                 },
              //               ),
              //               const Text("Work"),
              //             ]);
              //           }),
              //
              //           const SizedBox(height: 10),
              //
              //           /// Address TextField
              //           TextField(
              //             controller: TextEditingController(
              //               text: currentAddress,
              //             ),
              //             readOnly: true,
              //             maxLines: 2,
              //             decoration: const InputDecoration(
              //               labelText: "Address",
              //               border: OutlineInputBorder(),
              //             ),
              //           ),
              //
              //           const SizedBox(height: 15),
              //
              //           /// Save Button
              //           Appbutton(
              //             buttonText: "Save",
              //             onTap: () async {
              //               Get.find<LoadingController>()
              //                   .isLoading
              //                   .value = true;
              //               final createdAddress =
              //               await controller.createAddress(
              //                 setAsDefault: controller
              //                     .setAsDefaultCheckbox.value,
              //               );
              //
              //               if (createdAddress != null &&
              //                   controller.errorMessage.value.isEmpty) {
              //                 controller.resetCheckbox();
              //                 controller.resetForm();
              //                 Get.to(() => CustomBottomNav());
              //                 Get.find<LoadingController>()
              //                     .isLoading
              //                     .value = false;
              //                 AppSnackBar.showSuccess(context,
              //                     message:
              //                     "Address created successfully");
              //               }
              //             },
              //           ),
              //           const SizedBox(height: 10),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}