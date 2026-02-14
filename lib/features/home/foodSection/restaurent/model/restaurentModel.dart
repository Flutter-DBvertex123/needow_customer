import 'package:http/http.dart' as http;
import 'dart:convert';

// Restaurant Model
class Restaurant {
  final String id;
  final String name;
  final String ownerName;
  final String mobile;
  final String email;
  final String coverImage;
  final String address;
  final String cityArea;
  final List<String> cuisineTypes;
  final String restaurantType;
  final String logo;
  final WorkingHours workingHours;
  final String weeklyOffDay;
  final int avgPreparationTime;
  final double deliveryChargeMin;
  final double deliveryChargeAfter1km;
  final bool isDeliveryAvailable;
  final bool isTakeawayAvailable;
  final bool isPureVeg;
  final bool isFeatured;
  final int totalOrders;
  final String status;
  final bool isActive;
  final double rating;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  Restaurant({
    required this.coverImage,
    required this.id,
    required this.name,
    required this.ownerName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.cityArea,
    required this.cuisineTypes,
    required this.restaurantType,
    required this.logo,
    required this.workingHours,
    required this.weeklyOffDay,
    required this.avgPreparationTime,
    required this.deliveryChargeMin,
    required this.deliveryChargeAfter1km,
    required this.isDeliveryAvailable,
    required this.isTakeawayAvailable,
    required this.isPureVeg,
    required this.isFeatured,
    required this.totalOrders,
    required this.status,
    required this.isActive,
    required this.rating,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      ownerName: json['ownerName'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      cityArea: json['cityArea'] ?? '',
      cuisineTypes: List<String>.from(json['cuisineTypes'] ?? []),
      restaurantType: json['restaurantType'] ?? '',
      logo: json['logo'] ?? '',
      workingHours: WorkingHours.fromJson(json['workingHours'] ?? {}),
      weeklyOffDay: json['weeklyOffDay'] ?? '',
      avgPreparationTime: json['avgPreparationTime'] ?? 0,
      deliveryChargeMin: (json['deliveryChargeMin'] ?? 0).toDouble(),
      deliveryChargeAfter1km: (json['deliveryChargeAfter1km'] ?? 0).toDouble(),
      isDeliveryAvailable: json['isDeliveryAvailable'] ?? false,
      isTakeawayAvailable: json['isTakeawayAvailable'] ?? false,
      isPureVeg: json['isPureVeg'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      totalOrders: json['totalOrders'] ?? 0,
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      coverImage: json['coverPhoto'] ?? "",
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'ownerName': ownerName,
      'mobile': mobile,
      'email': email,
      'address': address,
      'cityArea': cityArea,
      'cuisineTypes': cuisineTypes,
      'restaurantType': restaurantType,
      'logo': logo,
      'coverPhoto': coverImage,
      'workingHours': workingHours.toJson(),
      'weeklyOffDay': weeklyOffDay,
      'avgPreparationTime': avgPreparationTime,
      'deliveryChargeMin': deliveryChargeMin,
      'deliveryChargeAfter1km': deliveryChargeAfter1km,
      'isDeliveryAvailable': isDeliveryAvailable,
      'isTakeawayAvailable': isTakeawayAvailable,
      'isPureVeg': isPureVeg,
      'isFeatured': isFeatured,
      'totalOrders': totalOrders,
      'status': status,
      'isActive': isActive,
      'rating': rating,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// Working Hours Model
class WorkingHours {
  final String start;
  final String end;
  final String id;

  WorkingHours({
    required this.start,
    required this.end,
    required this.id,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
      '_id': id,
    };
  }
}

// API Response Model
class RestaurantResponse {
  final List<Restaurant> restaurants;
  final int total;
  final int page;
  final int limit;

  RestaurantResponse({
    required this.restaurants,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantResponse(
      restaurants: (json['data'] as List?)
          ?.map((item) => Restaurant.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
    );
  }
}