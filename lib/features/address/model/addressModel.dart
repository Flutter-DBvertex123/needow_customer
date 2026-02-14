// lib/models/address_model.dart

class AddressModel {
  final String? id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String user;
   bool isDefault;
  final String type;
  final String landmark;
  final double latitude;
  final double longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  AddressModel({
    this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.user,
    required this.isDefault,
    required this.type,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  /// Convert AddressModel to JSON
  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'pincode': pincode,
    'country': country,
    'user': user,
    'isDefault': isDefault,
    'type': type,
    'landmark': landmark,
    'latitude': latitude,
    'longitude': longitude,
    if (id != null) '_id': id,
    if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
    if (version != null) '__v': version,
  };

  /// Create AddressModel from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'] as String?,
      street: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      user: json['user'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
      type: json['type'] as String? ?? 'home',
      landmark: json['landmark'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      version: json['__v'] as int?,
    );
  }
  AddressModel copyWith({
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
    return AddressModel(
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
      user: user ?? "",
    );
  }

  factory AddressModel.empty() {
    return AddressModel(
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
      user: '',
    );
  }
  factory AddressModel.defaultAddress() {
    return AddressModel(
      street: '221B Baker Street',
      city: 'London',
      state: 'Greater London',
      pincode: 'NW1 6XE',
      country: 'UK',
      type: 'home',
      landmark: 'Near Police Station',
      latitude: 28.6139,
      longitude: 77.209,
      isDefault: false, user: '',
    );
  }

}