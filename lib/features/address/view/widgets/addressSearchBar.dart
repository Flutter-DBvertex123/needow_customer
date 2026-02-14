// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as fplaces;
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../use_current_location_screen.dart';
//
// class SearchAddressScreen extends StatefulWidget {
//   @override
//   _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
// }
//
// class _UpdateAddressScreenState extends State<SearchAddressScreen> {
//   final TextEditingController searchController = TextEditingController();
//
//   late FlutterGooglePlacesSdk places;
//
//   List<AutocompletePrediction> predictions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     places = FlutterGooglePlacesSdk("AIzaSyC34xupC2K8bUvYaJ6I5waaklH8WcADpsg");
//   }
//
//   /// 🔍 Fetch autocomplete suggestions
//   void searchPlaces(String input) async {
//     if (input.isEmpty) {
//       setState(() => predictions = []);
//       return;
//     }
//
//     final result = await places.findAutocompletePredictions(
//       input,
//       countries: ['in'], // optional
//     );
//
//     setState(() {
//       predictions = result.predictions;
//     });
//   }
//
//   /// 📍 Get latitude & longitude
//   Future<void> selectPlace(String placeId, String description) async {
//     final result = await places.fetchPlace(
//       placeId,
//       fields: [
//         PlaceField.Location,
//         PlaceField.AddressComponents,
//       ],
//     );
//
//     final lat = result.place?.latLng?.lat;
//     final lng = result.place?.latLng?.lng;
//
//     print("Selected → $description");
//     print("Lat: $lat, Lng: $lng");
//
//     setState(() {
//       searchController.text = description;
//       predictions = [];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text("Select Address")),
//       body: Column(
//         children: [
//
//           /// 🔍 SEARCH BAR
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               controller: searchController,
//               onChanged: searchPlaces,
//               decoration: InputDecoration(
//                 hintText: "Search location...",
//                 prefixIcon: Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.grey.shade200,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//
//           /// 📌 AUTOCOMPLETE LIST
//           Expanded(
//             child: ListView.builder(
//               itemCount: predictions.length,
//               itemBuilder: (context, index) {
//                 final p = predictions[index];
//
//                 return ListTile(
//                   leading: Icon(Icons.location_on_outlined),
//                   title: Text(p.fullText ?? ""),
//                     onTap: () async {
//                       final result = await googlePlaces.fetchPlace(
//                         p.placeId!,
//                         fields: [
//                           fplaces.PlaceField.Location,
//                           fplaces.PlaceField.AddressComponents,
//                         ],
//                       );
//
//                       final lat = result.place?.latLng?.lat;
//                       final lng = result.place?.latLng?.lng;
//
//                       if (lat != null && lng != null) {
//                         Get.to(() => LocationPickerScreen(
//                           searchedLocation: LatLng(lat, lng),
//                           searchedAddress: p.fullText ?? "",
//                         ));
//                       }
//                     }
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
// as fplaces;
// import 'package:get/get.dart';
// import 'package:newdow_customer/utils/apptheme.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
//
// import '../use_current_location_screen.dart';
//
// class SearchAddressScreen extends StatefulWidget {
//   @override
//   _SearchAddressScreenState createState() => _SearchAddressScreenState();
// }
//
// class _SearchAddressScreenState extends State<SearchAddressScreen> {
//   final TextEditingController searchController = TextEditingController();
//   late fplaces.FlutterGooglePlacesSdk googlePlaces;
//
//   List<fplaces.AutocompletePrediction> predictions = [];
//   Timer? _debounce;
//
//   @override
//   void initState() {
//     super.initState();
//     googlePlaces = fplaces.FlutterGooglePlacesSdk(
//       "AIzaSyC34xupC2K8bUvYaJ6I5waaklH8WcADpsg",
//     );
//   }
//
//   /// 🔍 Fetch autocomplete suggestions
//   void searchPlaces(String input) async {
//     if (input.isEmpty) {
//       setState(() => predictions = []);
//       return;
//     }
//
//     final result = await googlePlaces.findAutocompletePredictions(
//       input,
//       countries: ['in'],
//     );
//
//     setState(() {
//       predictions = result.predictions;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           DefaultAppBar(titleText: "Search Address", isFormBottamNav: false),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 9.toHeightPercent(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   /// 🔍 SEARCH BAR
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8,left: 16,right: 16,bottom: 0),
//                     child: TextField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         if (_debounce?.isActive ?? false) _debounce!.cancel();
//
//                         _debounce = Timer(const Duration(milliseconds: 500), () {
//                           searchPlaces(value);
//                         });
//                       },
//                       // decoration: InputDecoration(
//                       //   hintText: "Search location...",
//                       //   prefixIcon: Icon(Icons.search),
//                       //   filled: true,
//                       //   fillColor: Colors.grey.shade200,
//                       //   border: OutlineInputBorder(
//                       //     borderRadius: BorderRadius.circular(12),
//                       //   ),
//                       // ),
//                       decoration: InputDecoration(
//                         hintText: "Search location...",
//                         prefixIcon: const Icon(Icons.search),
//                         filled: true,
//                         fillColor: Colors.grey.shade200,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 10),
//                       ),
//                     ),
//                   ),
//
//                   /// 📌 AUTOCOMPLETE LIST
//                   Expanded(
//                     child: Padding(
//                       padding:  EdgeInsets.all(16.0),
//                       child: (predictions == null ||predictions.isNotEmpty  )? ListView.builder(
//                         itemCount: predictions.length,
//                         itemBuilder: (context, index) {
//                           final p = predictions[index];
//
//                           return Card(
//                             child: ListTile(
//                               leading: Icon(Icons.location_on_outlined,size: 25,color: AppColors.primary,),
//                               title: Text(p.fullText ?? "",maxLines: 2,overflow: TextOverflow.fade,),
//                               onTap: () async {
//                                 // fetch lat/lng
//                                 final result = await googlePlaces.fetchPlace(
//                                   p.placeId!,
//                                   fields: [
//                                     fplaces.PlaceField.Location,
//                                     fplaces.PlaceField.AddressComponents,
//                                   ],
//                                 );
//                                 final lat = result.place?.latLng?.lat;
//                                 final lng = result.place?.latLng?.lng;
//
//                                 if (lat != null && lng != null) {
//                                   Get.to(() => LocationPickerScreen(
//                                     searchedLocation: LatLng(lat, lng),
//                                     searchedAddress: p.fullText ?? "",
//                                   ));
//                                 }
//                               },
//                             ),
//                           );
//                         },
//                       ):
//                       Center(
//                         child: Text(
//                           "No locations found",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       )
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//
//       ),
//     );
//   }
// }
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
as fplaces;
import 'package:get/get.dart';
import 'package:newdow_customer/features/address/model/addressModel.dart';
import 'package:newdow_customer/features/address/view/create_address_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';

import '../use_current_location_screen.dart';

class SearchAddressScreen extends StatefulWidget {
  bool isFromAddressMannully;
  bool? isFromSelectDeliveryAddress;
  AddressModel? address;
  SearchAddressScreen({this.isFromAddressMannully = false,this.isFromSelectDeliveryAddress,this.address});
  @override
  _SearchAddressScreenState createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final TextEditingController searchController = TextEditingController();
  late FocusNode searchFocusNode;
  late fplaces.FlutterGooglePlacesSdk googlePlaces;

  List<fplaces.AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    googlePlaces = fplaces.FlutterGooglePlacesSdk(
      "AIzaSyC34xupC2K8bUvYaJ6I5waaklH8WcADpsg",
    );

    // Enable focus on search when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  /// 🔍 Fetch autocomplete suggestions
  void searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() => predictions = []);
      return;
    }

    final result = await googlePlaces.findAutocompletePredictions(
      input,
      countries: ['in'],
    );

    setState(() {
      predictions = result.predictions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DefaultAppBar(titleText: "Search Address", isFormBottamNav: false),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 9.toHeightPercent(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔍 SEARCH BAR
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 16, right: 16, bottom: 0),
                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();

                        _debounce = Timer(const Duration(milliseconds: 500), () {
                          searchPlaces(value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search location...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),

                  /// 📌 AUTOCOMPLETE LIST
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: (predictions == null || predictions.isNotEmpty)
                          ? ListView.builder(
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          final p = predictions[index];

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on_outlined,
                                size: 25,
                                color: AppColors.primary,
                              ),
                              title: Text(
                                p.fullText ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                              ),
                              onTap: () async {
                                // Disable focus node before navigating
                                searchFocusNode.unfocus();

                                // fetch lat/lng
                                final result =
                                await googlePlaces.fetchPlace(
                                  p.placeId!,
                                  fields: [
                                    fplaces.PlaceField.Location,
                                    fplaces.PlaceField.AddressComponents,
                                  ],
                                );
                                final lat =
                                    result.place?.latLng?.lat;
                                final lng =
                                    result.place?.latLng?.lng;

                                if (lat != null && lng != null) {
                                  widget.isFromAddressMannully ?
                                  Get.to(() => AddAddressScreen(
                                    initialAddress: widget.address,
                                    isFromSelectDeliveryAddress: widget.isFromSelectDeliveryAddress == null ? false : widget.isFromSelectDeliveryAddress!,
                                    searchedLocation: LatLng(lat, lng),
                                    searchedAddress: p.fullText ?? "",
                                  )):
                                  Get.to(() => LocationPickerScreen(
                                    searchedLocation: LatLng(lat, lng),
                                    searchedAddress: p.fullText ?? "",
                                  ));
                                }
                              },
                            ),
                          );
                        },
                      )
                          : Center(
                        child: Text(
                          "No locations found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}