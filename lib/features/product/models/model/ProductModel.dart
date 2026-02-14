// class ProductModel {
//   final String id;
//   final String? name;
//   final String? description;
//   final Category? category;
//   final SubCategory? subCategory;
//   final BusinessType? businessType;
//   final String? productType;
//   final String? brand;
//   final double? price;
//   final double? discount;
//   final double? discountedPrice;
//   final int? quantity;
//   final String? unit;
//   final int? minStockLevel;
//   final String? stockStatus;
//   final bool? isActive;
//   final bool? isAvailable;
//   final bool? isPrescriptionRequired;
//   final bool? isVeg;
//   final String? restaurant;
//   final String? disclaimer;
//   final String? countryOfOrigin;
//   final DateTime? expiryDate;
//   final DateTime? manufacturingDate;
//   final List<String>? ingredients;
//   final List<String>? allergens;
//   final List<String>? tags;
//   final List<String>? seoKeywords;
//   final double? rating;
//   final int? reviewCount;
//   final int? salesCount;
//   final int? viewCount;
//   final int? maxOrderQuantity;
//   final double? weight;
//   final List<String>? imageUrl;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   ProductModel.empty()
//       : id = "",
//         name = null,
//         restaurant = null,
//         description = null,
//         category = null,
//         subCategory = null,
//         businessType = null,
//         productType = null,
//         brand = null,
//         price = null,
//         discount = null,
//         discountedPrice = null,
//         quantity = null,
//         unit = null,
//         minStockLevel = null,
//         stockStatus = null,
//         isActive = null,
//         isAvailable = null,
//         isPrescriptionRequired = null,
//         isVeg = null,
//         disclaimer = null,
//         countryOfOrigin = null,
//         expiryDate = null,
//         manufacturingDate = null,
//         ingredients = const [],
//         allergens = const [],
//         tags = const [],
//         seoKeywords = const [],
//         rating = null,
//         reviewCount = null,
//         salesCount = null,
//         viewCount = null,
//         maxOrderQuantity = null,
//         weight = null,
//         imageUrl = const [],
//         createdAt = null,
//         updatedAt = null;
//
//   ProductModel({
//     required this.id,
//     this.name,
//     this.description,
//     this.category,
//     this.subCategory,
//     this.businessType,
//     this.productType,
//     this.brand,
//     this.price,
//     this.discount,
//     this.discountedPrice,
//     this.quantity,
//     this.unit,
//     this.minStockLevel,
//     this.restaurant,
//     this.stockStatus,
//     this.isActive,
//     this.isAvailable,
//     this.isPrescriptionRequired,
//     this.isVeg,
//     this.disclaimer,
//     this.countryOfOrigin,
//     this.expiryDate,
//     this.manufacturingDate,
//     this.ingredients,
//     this.allergens,
//     this.tags,
//     this.seoKeywords,
//     this.rating,
//     this.reviewCount,
//     this.salesCount,
//     this.viewCount,
//     this.maxOrderQuantity,
//     this.weight,
//     this.imageUrl,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   /// ✅ Factory method to parse from JSON
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['_id'] ?? '',
//       name: json['name'],
//       description: json['description'],
//       restaurant: json['restaurant']?.toString(),
//       category: json['category'] != null
//           ? Category.fromJson(json['category'])
//           : null,
//       subCategory: json['subCategory'] != null
//           ? SubCategory.fromJson(json['subCategory'])
//           : null,
//       businessType: json['businessType'] != null
//           ? BusinessType.fromJson(json['businessType'])
//           : null,
//       productType: json['productType'],
//       brand: json['brand'],
//       price: (json['price'] ?? 0).toDouble(),
//       discount: (json['discount'] ?? 0).toDouble(),
//       discountedPrice: (json['discountedPrice'] ?? json['price'] ?? 0).toDouble(),
//       quantity: json['quantity'],
//       unit: json['unit'],
//       minStockLevel: json['minStockLevel'],
//       stockStatus: json['stockStatus'],
//       isActive: json['isActive'],
//       isAvailable: json['isAvailable'],
//       isPrescriptionRequired: json['isPrescriptionRequired'],
//       isVeg: json['isVeg'],
//       disclaimer: json['disclaimer'],
//       countryOfOrigin: json['countryOfOrigin'],
//       expiryDate: json['expiryDate'] != null
//           ? DateTime.tryParse(json['expiryDate'])
//           : null,
//       manufacturingDate: json['manufacturingDate'] != null
//           ? DateTime.tryParse(json['manufacturingDate'])
//           : null,
//       ingredients: List<String>.from(json['ingredients'] ?? []),
//       allergens: List<String>.from(json['allergens'] ?? []),
//       tags: List<String>.from(json['tags'] ?? []),
//       seoKeywords: List<String>.from(json['seoKeywords'] ?? []),
//       rating: (json['rating'] ?? 0).toDouble(),
//       reviewCount: json['reviewCount'] ?? 0,
//       salesCount: json['salesCount'] ?? 0,
//       viewCount: json['viewCount'] ?? 0,
//       maxOrderQuantity: json['maxOrderQuantity'],
//       weight: (json['weight'] ?? 0).toDouble(),
//       imageUrl: List<String>.from(json['image_url'] ?? []),
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'])
//           : null,
//       updatedAt: json['updatedAt'] != null
//           ? DateTime.tryParse(json['updatedAt'])
//           : null,
//     );
//   }
//
//   /// ✅ Convert back to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'description': description,
//       'category': category?.toJson(),
//       'subCategory': subCategory?.toJson(),
//       'businessType': businessType?.toJson(),
//       'productType': productType,
//       'brand': brand,
//       'restaurant': restaurant,
//       'price': price,
//       'discount': discount,
//       'discountedPrice': discountedPrice,
//       'quantity': quantity,
//       'unit': unit,
//       'minStockLevel': minStockLevel,
//       'stockStatus': stockStatus,
//       'isActive': isActive,
//       'isAvailable': isAvailable,
//       'isPrescriptionRequired': isPrescriptionRequired,
//       'isVeg': isVeg,
//       'disclaimer': disclaimer,
//       'countryOfOrigin': countryOfOrigin,
//       'expiryDate': expiryDate?.toIso8601String(),
//       'manufacturingDate': manufacturingDate?.toIso8601String(),
//       'ingredients': ingredients,
//       'allergens': allergens,
//       'tags': tags,
//       'seoKeywords': seoKeywords,
//       'rating': rating,
//       'reviewCount': reviewCount,
//       'salesCount': salesCount,
//       'viewCount': viewCount,
//       'maxOrderQuantity': maxOrderQuantity,
//       'weight': weight,
//       'image_url': imageUrl,
//       'createdAt': createdAt?.toIso8601String(),
//       'updatedAt': updatedAt?.toIso8601String(),
//     };
//   }
// }
//
// class Category {
//   final String? id;
//   final String? name;
//   final String? description;
//   final String? type;
//   final bool? isActive;
//   final bool? isFeatured;
//   final int? displayOrder;
//   final String? businessType;
//   final List<String>? imageUrl;
//   final List<String>? tags;
//
//   Category({
//     this.id,
//     this.name,
//     this.description,
//     this.type,
//     this.isActive,
//     this.isFeatured,
//     this.displayOrder,
//     this.businessType,
//     this.imageUrl,
//     this.tags,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json['_id'],
//     name: json['name'],
//     description: json['description'],
//     type: json['type'],
//     isActive: json['isActive'],
//     isFeatured: json['isFeatured'],
//     displayOrder: json['displayOrder'],
//     businessType: json['businessType'],
//     imageUrl: List<String>.from(json['image_url'] ?? []),
//     tags: List<String>.from(json['tags'] ?? []),
//   );
//
//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'name': name,
//     'description': description,
//     'type': type,
//     'isActive': isActive,
//     'isFeatured': isFeatured,
//     'displayOrder': displayOrder,
//     'businessType': businessType,
//     'image_url': imageUrl,
//     'tags': tags,
//   };
// }
//
// class SubCategory {
//   final String? id;
//   final String? name;
//   final String? description;
//   final bool? isActive;
//   final int? displayOrder;
//   final List<String>? imageUrl;
//
//   SubCategory({
//     this.id,
//     this.name,
//     this.description,
//     this.isActive,
//     this.displayOrder,
//     this.imageUrl,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//     id: json['_id'],
//     name: json['name'],
//     description: json['description'],
//     isActive: json['isActive'],
//     displayOrder: json['displayOrder'],
//     imageUrl: List<String>.from(json['image_url'] ?? []),
//   );
//
//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'name': name,
//     'description': description,
//     'isActive': isActive,
//     'displayOrder': displayOrder,
//     'image_url': imageUrl,
//   };
// }
//
// class BusinessType {
//   final String? id;
//   final String? name;
//   final String? code;
//   final String? description;
//   final String? icon;
//   final String? color;
//   final bool? isActive;
//   final bool? isFeatured;
//   final int? displayOrder;
//   final List<String>? tags;
//
//   BusinessType({
//     this.id,
//     this.name,
//     this.code,
//     this.description,
//     this.icon,
//     this.color,
//     this.isActive,
//     this.isFeatured,
//     this.displayOrder,
//     this.tags,
//   });
//
//   factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
//     id: json['_id'],
//     name: json['name'],
//     code: json['code'],
//     description: json['description'],
//     icon: json['icon'],
//     color: json['color'],
//     isActive: json['isActive'],
//     isFeatured: json['isFeatured'],
//     displayOrder: json['displayOrder'],
//     tags: List<String>.from(json['tags'] ?? []),
//   );
//
//   Map<String, dynamic> toJson() => {
//     '_id': id,
//     'name': name,
//     'code': code,
//     'description': description,
//     'icon': icon,
//     'color': color,
//     'isActive': isActive,
//     'isFeatured': isFeatured,
//     'displayOrder': displayOrder,
//     'tags': tags,
//   };
// }
import 'dart:convert';

import 'package:get/get.dart';

import '../../../home/foodSection/restaurent/model/restaurentModel.dart';

/// ===================== PRODUCT MODEL =====================
class ProductModel {
  final String id;
  final String? name;
  final String? description;

  final Category? category;
  final SubCategory? subCategory;
  final BusinessType? businessType;

  final String? productType; // grocery | medicine | food
  final String? brand;

  final double? price;
  final double? discount;
  final double? discountedPrice;

  final int? quantity;
  final String? unit;
  final int? minStockLevel;
  final String? stockStatus;

  final bool? isActive;
  final bool? isAvailable;
  final bool? isPrescriptionRequired;
  final bool? isVeg;
  final bool? isRecommended;

  final String? disclaimer;
  final String? countryOfOrigin;

  final DateTime? expiryDate;
  final DateTime? manufacturingDate;

  final List<String>? ingredients;
  final List<String>? allergens;
  final List<String>? tags;
  final List<String>? seoKeywords;

  final double? rating;
  final int? reviewCount;
  final int? salesCount;
  final int? viewCount;
  final int? maxOrderQuantity;
  final double? weight;

  final List<String>? imageUrl;

  /// 🔥 FOOD SPECIFIC
  final int? preparationTime;
  final String? servingSize;
  final String? spiceLevel;
  final String? expiryDuration;
  final List<Addon>? addons;
  final List<ServingSize>? servingSizes;
  final String? foodType;

  /// 🔥 RESTAURANT (FOOD ONLY)
  final Restaurant? restaurant;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.businessType,
    this.productType,
    this.brand,
    this.price,
    this.isRecommended,
    this.discount,
    this.discountedPrice,
    this.quantity,
    this.unit,
    this.minStockLevel,
    this.stockStatus,
    this.isActive,
    this.isAvailable,
    this.isPrescriptionRequired,
    this.isVeg,
    this.disclaimer,
    this.countryOfOrigin,
    this.expiryDate,
    this.manufacturingDate,
    this.ingredients,
    this.allergens,
    this.tags,
    this.seoKeywords,
    this.rating,
    this.reviewCount,
    this.salesCount,
    this.viewCount,
    this.maxOrderQuantity,
    this.weight,
    this.imageUrl,
    this.preparationTime,
    this.servingSize,
    this.spiceLevel,
    this.expiryDuration,
    this.addons,
    this.servingSizes,
    this.foodType,
    this.restaurant,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'],
      description: json['description'],

      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      subCategory: json['subCategory'] != null
          ? SubCategory.fromJson(json['subCategory'])
          : null,
      businessType: json['businessType'] != null
          ? BusinessType.fromJson(json['businessType'])
          : null,

      productType: json['productType'],
      brand: json['brand'],
      isRecommended: json['isRecommended'] ?? false,
      price: (json['price'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      discountedPrice:
      (json['discountedPrice'] ?? json['price'] ?? 0).toDouble(),

      quantity: json['quantity'],
      unit: json['unit'],
      minStockLevel: json['minStockLevel'],
      stockStatus: json['stockStatus'],

      isActive: json['isActive'],
      isAvailable: json['isAvailable'],
      isPrescriptionRequired: json['isPrescriptionRequired'],
      isVeg: json['isVeg'],

      disclaimer: json['disclaimer'],
      countryOfOrigin: json['countryOfOrigin'],

      expiryDate: json['expiryDate'] != null
          ? DateTime.tryParse(json['expiryDate'])
          : null,
      manufacturingDate: json['manufacturingDate'] != null
          ? DateTime.tryParse(json['manufacturingDate'])
          : null,

      ingredients: List<String>.from(json['ingredients'] ?? []),
      allergens: List<String>.from(json['allergens'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      seoKeywords: List<String>.from(json['seoKeywords'] ?? []),

      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      salesCount: json['salesCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      maxOrderQuantity: json['maxOrderQuantity'],
      weight: (json['weight'] ?? 0).toDouble(),

      imageUrl: List<String>.from(json['image_url'] ?? []),

      /// FOOD
      preparationTime: json['preparationTime'],
      servingSize: json['servingSize'],
      spiceLevel: json['spiceLevel'],
      expiryDuration: json['expiryDuration'],
      foodType: json['foodType'],

      addons: (json['addons'] as List?)
          ?.map((e) => Addon.fromJson(e))
          .toList(),

      servingSizes: (json['servingSizes'] as List?)
          ?.map((e) => ServingSize.fromJson(e))
          .toList(),

      restaurant: json['restaurant'] != null && json['restaurant'] is Map
          ? Restaurant.fromJson(json['restaurant'])
          : null,
      // restaurant: json['restaurant'] != null
      //     ? RestaurantModel.fromJson(json['restaurant'])
      //     : null,

      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
    );
  }
}
class RestaurantModel {
  final String id;
  final String name;
  final String weeklyOffDay;
  final WorkingHours workingHours;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.weeklyOffDay,
    required this.workingHours, required String priceRange,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'],
      name: json['name'],
      weeklyOffDay: json['weeklyOffDay'],
      workingHours: WorkingHours.fromJson(json['workingHours']), priceRange: '',
    );
  }
}

class WorkingHours {
  final String start;
  final String end;

  WorkingHours({required this.start, required this.end});

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      start: json['start'],
      end: json['end'],
    );
  }
}
class Addon {
  final RxInt setQty = 0.obs;
  final RxDouble totalPrice = 0.0.obs;
  final String name;
  final double price;
  final qty;
  final bool isAvailable;

  Addon({
    required setQty ,
    required this.name,
    required totalPrice,
    required this.price,
    required this.qty,
    required this.isAvailable,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      setQty: 0,
      totalPrice: 0.0,
      name: json['name'],
      qty: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      isAvailable: json['isAvailable'] ?? false,
    );
  }
}

class ServingSize {
  final String name;
  final double price;
  final bool isAvailable;

  ServingSize({
    required this.name,
    required this.price,
    required this.isAvailable,
  });

  factory ServingSize.fromJson(Map<String, dynamic> json) {
    return ServingSize(
      name: json['name'],
      price: (json['price'] ?? 0).toDouble(),
      isAvailable: json['isAvailable'] ?? false,
    );
  }
}

class Category {
  final String? id;
  final String? name;
  final String? description;
  final String? type;
  final bool? isActive;
  final bool? isFeatured;
  final int? displayOrder;
  final String? businessType;
  final List<String>? imageUrl;
  final List<String>? tags;

  Category({
    this.id,
    this.name,
    this.description,
    this.type,
    this.isActive,
    this.isFeatured,
    this.displayOrder,
    this.businessType,
    this.imageUrl,
    this.tags,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'],
    name: json['name'],
    description: json['description'],
    type: json['type'],
    isActive: json['isActive'],
    isFeatured: json['isFeatured'],
    displayOrder: json['displayOrder'],
    businessType: json['businessType'],
    imageUrl: List<String>.from(json['image_url'] ?? []),
    tags: List<String>.from(json['tags'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'type': type,
    'isActive': isActive,
    'isFeatured': isFeatured,
    'displayOrder': displayOrder,
    'businessType': businessType,
    'image_url': imageUrl,
    'tags': tags,
  };
}

class SubCategory {
  final String? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final int? displayOrder;
  final List<String>? imageUrl;

  SubCategory({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.displayOrder,
    this.imageUrl,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['_id'],
    name: json['name'],
    description: json['description'],
    isActive: json['isActive'],
    displayOrder: json['displayOrder'],
    imageUrl: List<String>.from(json['image_url'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'isActive': isActive,
    'displayOrder': displayOrder,
    'image_url': imageUrl,
  };
}

class BusinessType {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final String? icon;
  final String? color;
  final bool? isActive;
  final bool? isFeatured;
  final int? displayOrder;
  final List<String>? tags;

  BusinessType({
    this.id,
    this.name,
    this.code,
    this.description,
    this.icon,
    this.color,
    this.isActive,
    this.isFeatured,
    this.displayOrder,
    this.tags,
  });

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    id: json['_id'],
    name: json['name'],
    code: json['code'],
    description: json['description'],
    icon: json['icon'],
    color: json['color'],
    isActive: json['isActive'],
    isFeatured: json['isFeatured'],
    displayOrder: json['displayOrder'],
    tags: List<String>.from(json['tags'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'code': code,
    'description': description,
    'icon': icon,
    'color': color,
    'isActive': isActive,
    'isFeatured': isFeatured,
    'displayOrder': displayOrder,
    'tags': tags,
  };
}