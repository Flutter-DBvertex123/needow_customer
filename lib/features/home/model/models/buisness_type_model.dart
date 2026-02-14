//
// class BusinessTypeModel {
//   final String id;
//   final String name;
//   final String code;
//   final String description;
//   final String icon;
//   final String color;
//   final bool isActive;
//   final int displayOrder;
//   final bool isFeatured;
//   final List<String> tags;
//   final String seoTitle;
//   final String seoDescription;
//   final int v;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   // 🔥 New fields (flattened)
//   final num deliveryFirstKm;
//   final num deliveryAdditionalPerKm;
//   final String? city;
//   final double? latitude;
//   final double? longitude;
//   final num platformCharge;
//   final List<String> cities;
//
//   BusinessTypeModel({
//     required this.id,
//     required this.name,
//     required this.code,
//     required this.description,
//     required this.icon,
//     required this.color,
//     required this.isActive,
//     required this.displayOrder,
//     required this.isFeatured,
//     required this.tags,
//     required this.seoTitle,
//     required this.seoDescription,
//     required this.v,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deliveryFirstKm,
//     required this.deliveryAdditionalPerKm,
//     required this.city,
//     required this.latitude,
//     required this.longitude,
//     required this.platformCharge,
//     required this.cities,
//   });
//
//   factory BusinessTypeModel.fromJson(Map<String, dynamic> json) {
//     final deliveryCharge = json['deliveryCharge'] ?? {};
//
//     return BusinessTypeModel(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       code: json['code'] ?? '',
//       description: json['description'] ?? '',
//       icon: json['icon'] ?? '',
//       color: json['color'] ?? '',
//       isActive: json['isActive'] ?? false,
//       displayOrder: json['displayOrder'] ?? 0,
//       isFeatured: json['isFeatured'] ?? false,
//       tags: List<String>.from(json['tags'] ?? []),
//       seoTitle: json['seoTitle'] ?? '',
//       seoDescription: json['seoDescription'] ?? '',
//       v: json['__v'] ?? 0,
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//
//       // 🔥 New data mapping
//       deliveryFirstKm: deliveryCharge['firstKm'] ?? 0,
//       deliveryAdditionalPerKm: deliveryCharge['additionalPerKm'] ?? 0,
//       city: json['city'],
//       latitude: (json['latitude'] as num?)?.toDouble(),
//       longitude: (json['longitude'] as num?)?.toDouble(),
//       platformCharge: json['platformCharge'] ?? 0,
//       cities: List<String>.from(json['cities'] ?? []),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'code': code,
//       'description': description,
//       'icon': icon,
//       'color': color,
//       'isActive': isActive,
//       'displayOrder': displayOrder,
//       'isFeatured': isFeatured,
//       'tags': tags,
//       'seoTitle': seoTitle,
//       'seoDescription': seoDescription,
//       '__v': v,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//
//       // 🔥 Flattened back to API shape
//       'deliveryCharge': {
//         'firstKm': deliveryFirstKm,
//         'additionalPerKm': deliveryAdditionalPerKm,
//       },
//       'city': city,
//       'latitude': latitude,
//       'longitude': longitude,
//       'platformCharge': platformCharge,
//       'cities': cities,
//     };
//   }
// }
class BusinessTypeModel {
  final String id;
  final String name;
  final String code;
  final String? description;
  final String? icon;
  final String? color;
  final bool isActive;
  final int displayOrder;
  final bool isFeatured;
  final List<String> tags;
  final String? seoTitle;
  final String? seoDescription;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;
  final DeliveryCharge? deliveryCharge;
  final String? city;
  final double? latitude;
  final double? longitude;
  final int? platformCharge;
  final List<BusinessCity> cities;

  BusinessTypeModel({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    this.icon,
    this.color,
    required this.isActive,
    required this.displayOrder,
    required this.isFeatured,
    required this.tags,
    this.seoTitle,
    this.seoDescription,
    this.createdAt,
    this.updatedAt,
    required this.version,
    this.deliveryCharge,
    this.city,
    this.latitude,
    this.longitude,
    this.platformCharge,
    required this.cities,
  });

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) {
    return BusinessTypeModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
      isActive: json['isActive'] ?? false,
      displayOrder: json['displayOrder'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'])
          : [],
      seoTitle: json['seoTitle'],
      seoDescription: json['seoDescription'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      version: json['__v'] ?? 0,
      deliveryCharge: json['deliveryCharge'] != null
          ? DeliveryCharge.fromJson(json['deliveryCharge'])
          : null,
      city: json['city'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      platformCharge: json['platformCharge'],
      cities: json['cities'] != null
          ? (json['cities'] as List)
          .map((e) => BusinessCity.fromJson(e))
          .toList()
          : [],
    );
  }
}
class DeliveryCharge {
  final int firstKm;
  final int additionalPerKm;

  DeliveryCharge({
    required this.firstKm,
    required this.additionalPerKm,
  });

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) {
    return DeliveryCharge(
      firstKm: json['firstKm'] ?? 0,
      additionalPerKm: json['additionalPerKm'] ?? 0,
    );
  }
}

class BusinessCity {
  final String city;
  final String state;
  final double lat;
  final double lng;

  BusinessCity({
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
  });

  factory BusinessCity.fromJson(Map<String, dynamic> json) {
    return BusinessCity(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

