/*

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'dart:ui' as ui;

import 'package:newdow_customer/utils/apptheme.dart';

class MapWidget extends StatefulWidget {
  final Function(LatLng)? onLocationSelected;
  final Function(String)? onAddressChanged; // Add this callback

  const MapWidget({
    super.key,
    this.onLocationSelected,
    this.onAddressChanged,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? mapController;

  late BitmapDescriptor customMarker;
  bool _markerLoaded = false;

  Set<Marker> _markers = {};
  late LatLng _defaultCenter;
  late LatLng _centerMarkerPosition;
  final addressCtrl = Get.find<AddressController>();

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _defaultCenter = LatLng(
      addressCtrl.defaultAddress.value?.latitude ?? 28.6139,
      addressCtrl.defaultAddress.value?.longitude ?? 77.2090,
    );
    _centerMarkerPosition = _defaultCenter;

    // Add initial marker at center
    _addMarkerAtCenter();

    // Fetch initial address
    _getAddressFromCoordinates(_defaultCenter.latitude, _defaultCenter.longitude);
  }

  Future<void> _loadCustomMarker() async {
    try {
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder, Rect.fromLTWH(0, 0, 250, 250));

      // Draw icon
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(Icons.location_on.codePoint),
          style: TextStyle(
            fontSize: 80,
            fontFamily: Icons.location_on.fontFamily,
            color: AppColors.primary,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(75 - textPainter.width / 2, 75 - textPainter.height / 2));

      final image = await pictureRecorder.endRecording().toImage(150, 150);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      customMarker = BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
      setState(() {
        _markerLoaded = true;
      });
    } catch (e) {
      if (kDebugMode) print('Error loading marker: $e');
    }
  }

  /// Fetch address from latitude and longitude
  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Update address fields in controller with individual components
        addressCtrl.streetController.text = place.street ?? "";
        addressCtrl.landmarkController.text = place.subLocality ?? "";
        addressCtrl.cityController.text = place.locality ?? "";
        addressCtrl.stateController.text = place.administrativeArea ?? "";
        addressCtrl.pincodeController.text = place.postalCode ?? "";
        addressCtrl.countryController.text = place.country ?? "India";

        addressCtrl.updateAddressField('street', place.street ?? "");
        addressCtrl.updateAddressField('landmark', place.subLocality ?? "");
        addressCtrl.updateAddressField('city', place.locality ?? "");
        addressCtrl.updateAddressField('state', place.administrativeArea ?? "");
        addressCtrl.updateAddressField('pincode', place.postalCode ?? "");
        addressCtrl.updateAddressField('country', place.country ?? "India");
        addressCtrl.updateAddressLocation(lat, lng);

        // Format complete address for callback
        String address =
            "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''} ${place.postalCode ?? ''}";

        // Clean up extra spaces and commas
        address = address.replaceAll(RegExp(r',\s*,'), '/').replaceAll(RegExp(r'\s+'), ' ').trim();

        // Call the address callback with formatted address
        widget.onAddressChanged?.call(address);

        if (kDebugMode) {
          print('📍 Street: ${place.street}');
          print('📍 Landmark: ${place.subLocality}');
          print('📍 City: ${place.locality}');
          print('📍 State: ${place.administrativeArea}');
          print('📍 Pincode: ${place.postalCode}');
          print('📍 Complete Address: $address');
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error getting address: $e');
    }
  }

  void _addMarkerAtCenter() {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId("centerLocation"),
          position: _centerMarkerPosition,
          icon: _markerLoaded
              ? customMarker
              : BitmapDescriptor.defaultMarkerWithHue(50),
          infoWindow: const InfoWindow(
            title: "Selected Location",
          ),
        ),
      };
    });
  }

  void _onCameraMove(CameraPosition position) {
    // Update the center marker position to follow camera center
    _centerMarkerPosition = position.target;
    _addMarkerAtCenter();
  }

  void _onCameraIdle() {
    // When user stops dragging, fetch address and call the callback
    _getAddressFromCoordinates(
      _centerMarkerPosition.latitude,
      _centerMarkerPosition.longitude,
    );

    widget.onLocationSelected?.call(_centerMarkerPosition);

    if (kDebugMode) {
      print('📍 Location selected: ${_centerMarkerPosition.latitude}, ${_centerMarkerPosition.longitude}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map
        GoogleMap(
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: false,
          indoorViewEnabled: true,
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: _defaultCenter,
            zoom: 14,
          ),
          markers: _markers,
          onCameraMove: _onCameraMove,
          onCameraIdle: _onCameraIdle,
        ),
      ],
    );
  }
}*/
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newdow_customer/features/address/controller/addressController.dart';
import 'dart:ui' as ui;

import 'package:newdow_customer/utils/apptheme.dart';

class MapWidget extends StatefulWidget {
  final Function(LatLng)? onLocationSelected;
  final Function(String)? onAddressChanged;
  final LatLng? initialLocation; // Add this parameter

  const MapWidget({
    super.key,
    this.onLocationSelected,
    this.onAddressChanged,
    this.initialLocation, // Add this
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? mapController;

  late BitmapDescriptor customMarker;
  bool _markerLoaded = false;

  Set<Marker> _markers = {};
  late LatLng _defaultCenter;
  late LatLng _centerMarkerPosition;
  final addressCtrl = Get.find<AddressController>();

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();

    // Use initialLocation if provided, otherwise use default
    _defaultCenter = widget.initialLocation ??
        LatLng(
          addressCtrl.defaultAddress.value?.latitude ?? 28.6139,
          addressCtrl.defaultAddress.value?.longitude ?? 77.2090,
        );
    _centerMarkerPosition = _defaultCenter;

    // Add initial marker at center
    _addMarkerAtCenter();

    // Fetch initial address
    _getAddressFromCoordinates(_defaultCenter.latitude, _defaultCenter.longitude);
  }

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If initialLocation changed, update the map
    if (widget.initialLocation != null &&
        widget.initialLocation != oldWidget.initialLocation) {
      _defaultCenter = widget.initialLocation!;
      _centerMarkerPosition = _defaultCenter;

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _defaultCenter,
              zoom: 17,
            ),
          ),
        );
      }

      _addMarkerAtCenter();
      _getAddressFromCoordinates(_defaultCenter.latitude, _defaultCenter.longitude);
    }
  }

  Future<void> _loadCustomMarker() async {
    try {
      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder, Rect.fromLTWH(0, 0, 250, 250));

      // Draw icon
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(Icons.location_on.codePoint),
          style: TextStyle(
            fontSize: 80,
            fontFamily: Icons.location_on.fontFamily,
            color: AppColors.primary,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(75 - textPainter.width / 2, 75 - textPainter.height / 2));

      final image = await pictureRecorder.endRecording().toImage(150, 150);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      customMarker = BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
      setState(() {
        _markerLoaded = true;
      });
    } catch (e) {
      if (kDebugMode) print('Error loading marker: $e');
    }
  }

  /// Fetch address from latitude and longitude
  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Update address fields in controller with individual components
        addressCtrl.streetController.text = place.street ?? "";
        addressCtrl.landmarkController.text = place.subLocality ?? "";
        addressCtrl.cityController.text = place.locality ?? "";
        addressCtrl.stateController.text = place.administrativeArea ?? "";
        addressCtrl.pincodeController.text = place.postalCode ?? "";
        addressCtrl.countryController.text = place.country ?? "India";

        addressCtrl.updateAddressField('street', place.street ?? "");
        addressCtrl.updateAddressField('landmark', place.subLocality ?? "");
        addressCtrl.updateAddressField('city', place.locality ?? "");
        addressCtrl.updateAddressField('state', place.administrativeArea ?? "");
        addressCtrl.updateAddressField('pincode', place.postalCode ?? "");
        addressCtrl.updateAddressField('country', place.country ?? "India");
        addressCtrl.updateAddressLocation(lat, lng);

        // Format complete address for callback
        String address =
            "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''} ${place.postalCode ?? ''}";

        // Clean up extra spaces and commas
        address = address.replaceAll(RegExp(r',\s*,'), '/').replaceAll(RegExp(r'\s+'), ' ').trim();

        // Call the address callback with formatted address
        widget.onAddressChanged?.call(address);

        if (kDebugMode) {
          print('📍 Street: ${place.street}');
          print('📍 Landmark: ${place.subLocality}');
          print('📍 City: ${place.locality}');
          print('📍 State: ${place.administrativeArea}');
          print('📍 Pincode: ${place.postalCode}');
          print('📍 Complete Address: $address');
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error getting address: $e');
    }
  }

  void _addMarkerAtCenter() {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId("centerLocation"),
          position: _centerMarkerPosition,
          icon: _markerLoaded
              ? customMarker
              : BitmapDescriptor.defaultMarkerWithHue(50),
          infoWindow: const InfoWindow(
            title: "Selected Location",
          ),
        ),
      };
    });
  }

  void _onCameraMove(CameraPosition position) {
    // Update the center marker position to follow camera center
    _centerMarkerPosition = position.target;
    _addMarkerAtCenter();
  }

  void _onCameraIdle() {
    // When user stops dragging, fetch address and call the callback
    _getAddressFromCoordinates(
      _centerMarkerPosition.latitude,
      _centerMarkerPosition.longitude,
    );

    widget.onLocationSelected?.call(_centerMarkerPosition);

    if (kDebugMode) {
      print('📍 Location selected: ${_centerMarkerPosition.latitude}, ${_centerMarkerPosition.longitude}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map
        GoogleMap(
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: false,
          indoorViewEnabled: true,
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (controller) {
            mapController = controller;

            // If initialLocation is provided, animate to it after map creation
            if (widget.initialLocation != null) {
              Future.delayed(const Duration(milliseconds: 300), () {
                mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: widget.initialLocation!,
                      zoom: 17,
                    ),
                  ),
                );
              });
            }
          },
          initialCameraPosition: CameraPosition(
            target: _defaultCenter,
            zoom: 14,
          ),
          markers: _markers,
          onCameraMove: _onCameraMove,
          onCameraIdle: _onCameraIdle,
        ),
      ],
    );
  }
}