// lib/models/address_model.dart

import 'dart:math';

class CreateAddressModel {
  final String? id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String type; // home, work, other
  final String landmark;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CreateAddressModel({
    this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.type,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  /// Convert CreateAddressModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'type': type,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Create CreateAddressModel from JSON
  factory CreateAddressModel.fromJson(Map<String, dynamic> json) {
    return CreateAddressModel(
      id: json['id'] as String?,
      street: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      type: json['type'] as String? ?? 'home',
      landmark: json['landmark'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Create a copy of CreateAddressModel with modified fields
  CreateAddressModel copyWith({
    String? id,
    String? street,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? type,
    String? landmark,
    double? latitude,
    double? longitude,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CreateAddressModel(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
      type: type ?? this.type,
      landmark: landmark ?? this.landmark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get full address as string
  String getFullAddress() {
    return '$street, $landmark, $city, $state, $pincode, $country';
  }

  /// Get address summary
  String getAddressSummary() {
    return '$street, $city, $state';
  }

  /// Check if address is valid
  bool isValid() {
    return street.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        pincode.isNotEmpty &&
        country.isNotEmpty &&
        latitude != 0.0 &&
        longitude != 0.0;
  }

  /// Get coordinates as list
  List<double> getCoordinates() {
    return [latitude, longitude];
  }

  /// Calculate distance from another address (in kilometers)
  double getDistanceFrom(CreateAddressModel other) {
    const double earthRadiusKm = 6371;

    double dLat = _degreesToRadians(other.latitude - latitude);
    double dLon = _degreesToRadians(other.longitude - longitude);

    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_degreesToRadians(latitude)) *
            cos(_degreesToRadians(other.latitude)) *
            (sin(dLon / 2) * sin(dLon / 2));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadiusKm * c;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }

  @override
  String toString() {
    return 'CreateAddressModel(id: $id, street: $street, city: $city, state: $state, '
        'pincode: $pincode, country: $country, type: $type, landmark: $landmark, '
        'latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CreateAddressModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              street == other.street &&
              city == other.city &&
              state == other.state &&
              pincode == other.pincode &&
              country == other.country &&
              type == other.type &&
              landmark == other.landmark &&
              latitude == other.latitude &&
              longitude == other.longitude &&
              isDefault == other.isDefault;

  @override
  int get hashCode =>
      id.hashCode ^
      street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      pincode.hashCode ^
      country.hashCode ^
      type.hashCode ^
      landmark.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      isDefault.hashCode;

  /// Factory constructor for creating a default address
  factory CreateAddressModel.defaultAddress() {
    return CreateAddressModel(
      street: '221B Baker Street',
      city: 'London',
      state: 'Greater London',
      pincode: 'NW1 6XE',
      country: 'UK',
      type: 'home',
      landmark: 'Near Police Station',
      latitude: 28.6139,
      longitude: 77.209,
      isDefault: false,
    );
  }

  /// Factory constructor for creating an empty address
  factory CreateAddressModel.empty() {
    return CreateAddressModel(
      street: '',
      city: '',
      state: '',
      pincode: '',
      country: '',
      type: 'home',
      landmark: '',
      latitude: 0.0,
      longitude: 0.0,
      isDefault: false,
    );
  }
}