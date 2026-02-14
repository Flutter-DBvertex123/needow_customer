// import 'package:newdow_customer/features/auth/model/models/userModel.dart';
//
// import '../../../profile/model/userModel.dart';
//
//
//
// class UsersCartModel {
//   final String id;
//   final UserModel user;
//   final List<CartItem> items;
//   final bool isActive;
//   final int cartTotal;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//
//   UsersCartModel({
//     required this.id,
//     required this.user,
//     required this.items,
//     required this.isActive,
//     required this.cartTotal,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });
//
//   factory UsersCartModel.fromJson(Map<String, dynamic> json) {
//     return UsersCartModel(
//       id: json["_id"] ?? "",
//       user: UserModel.fromJson(json["userId"] ?? {}),
//       items: (json["items"] as List<dynamic>? ?? [])
//           .map((item) => CartItem.fromJson(item))
//           .toList(),
//       isActive: json["isActive"] ?? false,
//       cartTotal: json["cartTotal"] ?? 0,
//       createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
//       v: json["__v"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "userId": user.toJson(),
//       "items": items.map((e) => e.toJson()).toList(),
//       "isActive": isActive,
//       "cartTotal": cartTotal,
//       "createdAt": createdAt.toIso8601String(),
//       "updatedAt": updatedAt.toIso8601String(),
//       "__v": v,
//     };
//   }
// }
//
// class CartItem {
//   final Product? product;
//   final int quantity;
//   final int price;
//   final int discount;
//   final String id;
//
//   CartItem({
//     this.product,
//     required this.quantity,
//     required this.price,
//     required this.discount,
//     required this.id,
//   });
//
//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       product: json["productId"] != null && json["productId"] is Map
//           ? Product.fromJson(json["productId"])
//           : null,
//       quantity: json["quantity"] ?? 0,
//       price: json["price"] ?? 0,
//       discount: json["discount"] ?? 0,
//       id: json["_id"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "productId": product?.toJson(),
//       "quantity": quantity,
//       "price": price,
//       "discount": discount,
//       "_id": id,
//     };
//   }
// }
//
// class Product {
//   final String id;
//   final String name;
//   final String category;
//   final String subCategory;
//   final String businessType;
//   final String productType;
//   final String brand;
//   final int price;
//   final int discount;
//   final int quantity;
//   final String unit;
//   final int minStockLevel;
//   final String stockStatus;
//   final bool isActive;
//   final bool isAvailable;
//   final bool isPrescriptionRequired;
//   final String disclaimer;
//   final String countryOfOrigin;
//   final DateTime expiryDate;
//   final DateTime manufacturingDate;
//   final int rating;
//   final int reviewCount;
//   final int salesCount;
//   final int viewCount;
//   final int maxOrderQuantity;
//   final int weight;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final num discountedPrice;
//   final int v;
//   final List<String> ingredients;
//   final List<String> allergens;
//   final List<String> tags;
//   final List<String> seoKeywords;
//   final List<String> imageUrl;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.subCategory,
//     required this.businessType,
//     required this.productType,
//     required this.brand,
//     required this.price,
//     required this.discount,
//     required this.quantity,
//     required this.unit,
//     required this.minStockLevel,
//     required this.stockStatus,
//     required this.isActive,
//     required this.isAvailable,
//     required this.isPrescriptionRequired,
//     required this.disclaimer,
//     required this.countryOfOrigin,
//     required this.expiryDate,
//     required this.manufacturingDate,
//     required this.rating,
//     required this.reviewCount,
//     required this.salesCount,
//     required this.viewCount,
//     required this.maxOrderQuantity,
//     required this.weight,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.discountedPrice,
//     required this.v,
//     required this.ingredients,
//     required this.allergens,
//     required this.tags,
//     required this.seoKeywords,
//     required this.imageUrl,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json["_id"] ?? "",
//       name: json["name"] ?? "",
//       category: json["category"] ?? "",
//       subCategory: json["subCategory"] ?? "",
//       businessType: json["businessType"] ?? "",
//       productType: json["productType"] ?? "",
//       brand: json["brand"] ?? "",
//       price: json["price"] ?? 0,
//       discount: json["discount"] ?? 0,
//       quantity: json["quantity"] ?? 0,
//       unit: json["unit"] ?? "",
//       minStockLevel: json["minStockLevel"] ?? 0,
//       stockStatus: json["stockStatus"] ?? "",
//       isActive: json["isActive"] ?? false,
//       isAvailable: json["isAvailable"] ?? false,
//       isPrescriptionRequired: json["isPrescriptionRequired"] ?? false,
//       disclaimer: json["disclaimer"] ?? "",
//       countryOfOrigin: json["countryOfOrigin"] ?? "",
//       expiryDate:
//       DateTime.tryParse(json["expiryDate"] ?? "") ?? DateTime.now(),
//       manufacturingDate:
//       DateTime.tryParse(json["manufacturingDate"] ?? "") ?? DateTime.now(),
//       rating: json["rating"] ?? 0,
//       reviewCount: json["reviewCount"] ?? 0,
//       salesCount: json["salesCount"] ?? 0,
//       viewCount: json["viewCount"] ?? 0,
//       maxOrderQuantity: json["maxOrderQuantity"] ?? 0,
//       weight: json["weight"] ?? 0,
//       createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
//       discountedPrice: json["discountedPrice"] ?? 0,
//       v: json["__v"] ?? 0,
//       ingredients: List<String>.from(json["ingredients"] ?? []),
//       allergens: List<String>.from(json["allergens"] ?? []),
//       tags: List<String>.from(json["tags"] ?? []),
//       seoKeywords: List<String>.from(json["seoKeywords"] ?? []),
//       imageUrl: List<String>.from(json["image_url"] ?? []),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "name": name,
//       "category": category,
//       "subCategory": subCategory,
//       "businessType": businessType,
//       "productType": productType,
//       "brand": brand,
//       "price": price,
//       "discount": discount,
//       "quantity": quantity,
//       "unit": unit,
//       "minStockLevel": minStockLevel,
//       "stockStatus": stockStatus,
//       "isActive": isActive,
//       "isAvailable": isAvailable,
//       "isPrescriptionRequired": isPrescriptionRequired,
//       "disclaimer": disclaimer,
//       "countryOfOrigin": countryOfOrigin,
//       "expiryDate": expiryDate.toIso8601String(),
//       "manufacturingDate": manufacturingDate.toIso8601String(),
//       "rating": rating,
//       "reviewCount": reviewCount,
//       "salesCount": salesCount,
//       "viewCount": viewCount,
//       "maxOrderQuantity": maxOrderQuantity,
//       "weight": weight,
//       "createdAt": createdAt.toIso8601String(),
//       "updatedAt": updatedAt.toIso8601String(),
//       "discountedPrice": discountedPrice,
//       "__v": v,
//       "ingredients": ingredients,
//       "allergens": allergens,
//       "tags": tags,
//       "seoKeywords": seoKeywords,
//       "image_url": imageUrl,
//     };
//   }
// }
import 'package:newdow_customer/features/auth/model/models/userModel.dart';

import '../../../profile/model/userModel.dart';

class UsersCartModel {
  final String id;
  final UserModel user;
  final List<CartItem> items;
  final bool isActive;
  final num subtotal;
  final num discounts;
  final num tax;
  final num shipping;
  final num total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num v;

  UsersCartModel({
    required this.id,
    required this.user,
    required this.items,
    required this.isActive,
    required this.subtotal,
    required this.discounts,

    required this.tax,
    required this.shipping,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  UsersCartModel.empty()
      : id = '',
        user = UserModel.empty(), // make sure this exists
        items = const [],
        isActive = false,
        subtotal = 0,
        discounts = 0,
        tax = 0,
        shipping = 0,
        total = 0,

        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        v = 0;

  factory UsersCartModel.fromJson(Map<String, dynamic> json) {
    return UsersCartModel(
      id: json["_id"] ?? "",
      user: UserModel.fromJson(json["userId"] ?? {}),
      items: (json["items"] as List? ?? [])
          .map((item) => CartItem.fromJson(item))
          .toList(),
      isActive: json["isActive"] ?? false,
      subtotal: json["subtotal"] ?? 0,
      discounts: json["discounts"] ?? 0,
      tax: json["tax"] ?? 0,
      shipping: json["shipping"] ?? 0,
      total: json["total"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      v: json["__v"] ?? 0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": user.toJson(),
      "items": items.map((e) => e.toJson()).toList(),
      "isActive": isActive,
      "subtotal": subtotal,
      "discounts": discounts,
      "tax": tax,
      "shipping": shipping,
      "total": total,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}

class CartItem {
  final Product? product;
  final num quantity;
  final num unitPrice;
  final num discountPercent;
  final String name;
  final String prescriptionUrl;
  final num lineTotal;
  final String id;
  CartItem.empty()
      : product = null,
        quantity = 0,
        unitPrice = 0,
        discountPercent = 0,
        name = "",
        prescriptionUrl = '',
        lineTotal = 0,
        id = "";
  CartItem({
    this.product,
    required this.quantity,
    required this.unitPrice,
    required this.prescriptionUrl,
    required this.discountPercent,
    required this.name,
    required this.lineTotal,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json["productId"] != null && json["productId"] is Map
          ? Product.fromJson(json["productId"])
          : null,
      quantity: json["quantity"] ?? 0,
      unitPrice: json["unitPrice"] ?? 0,
      discountPercent: json["discountPercent"] ?? 0,
      name: json["name"] ?? "",
      lineTotal: json["lineTotal"] ?? 0,
      id: json["_id"] ?? "",
      prescriptionUrl: json["prescriptionUrl"] ?? "",
    );

  }

  Map<String, dynamic> toJson() {
    return {
      "productId": product?.toJson(),
      "quantity": quantity,
      "unitPrice": unitPrice,
      "discountPercent": discountPercent,
      "name": name,
      "lineTotal": lineTotal,
      "_id": id,
      "prescriptionUrl":prescriptionUrl
    };
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String subCategory;
  final String? restaurant;
  final String businessType;
  final String productType;
  final String brand;
  final List<String> imageUrl;
  final num price;
  final num discount;
  final num quantity;
  final String unit;
  final num minStockLevel;
  final String stockStatus;
  final bool isActive;
  final bool isAvailable;
  final bool isPrescriptionRequired;
  final String sellerName;
  final String countryOfOrigin;
  final List<String> ingredients;
  final List<String> allergens;
  final num rating;
  final int reviewCount;
  final List<String> tags;
  final num salesCount;
  final num viewCount;
  final num maxOrderQuantity;
  final num weight;
  final List<String> seoKeywords;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num discountedPrice;
  final num v;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.businessType,
    required this.productType,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.unit,
    required this.minStockLevel,
    required this.stockStatus,
    required this.isActive,
    required this.isAvailable,
    required this.isPrescriptionRequired,
    required this.sellerName,
    required this.countryOfOrigin,
    required this.ingredients,
    required this.allergens,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.salesCount,
    required this.viewCount,
    required this.maxOrderQuantity,
    required this.weight,
    required this.seoKeywords,
    required this.createdAt,
    required this.updatedAt,
    required this.discountedPrice,
    required this.v,
    this.restaurant
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      restaurant: json["restaurant"] ?? "",
      subCategory: json["subCategory"] ?? "",
      businessType: json["businessType"] ?? "",
      productType: json["productType"] ?? "",
      brand: json["brand"] ?? "",
      imageUrl: List<String>.from(json["image_url"] ?? []),
      price: json["price"] ?? 0,
      discount: json["discount"] ?? 0,
      quantity: json["quantity"] ?? 0,
      unit: json["unit"] ?? "",
      minStockLevel: json["minStockLevel"] ?? 0,
      stockStatus: json["stockStatus"] ?? "",
      isActive: json["isActive"] ?? false,
      isAvailable: json["isAvailable"] ?? false,
      isPrescriptionRequired: json["isPrescriptionRequired"] ?? false,
      sellerName: json["sellerName"] ?? "",
      countryOfOrigin: json["countryOfOrigin"] ?? "",
      ingredients: List<String>.from(json["ingredients"] ?? []),
      allergens: List<String>.from(json["allergens"] ?? []),
      rating: json["rating"] ?? 0,
      reviewCount: json["reviewCount"] ?? 0,
      tags: List<String>.from(json["tags"] ?? []),
      salesCount: json["salesCount"] ?? 0,
      viewCount: json["viewCount"] ?? 0,
      maxOrderQuantity: json["maxOrderQuantity"] ?? 0,
      weight: json["weight"] ?? 0,
      seoKeywords: List<String>.from(json["seoKeywords"] ?? []),
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      discountedPrice: json["discountedPrice"] ?? 0,
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "description": description,
      "category": category,
      "subCategory": subCategory,
      "businessType": businessType,
      "productType": productType,
      "brand": brand,
      "image_url": imageUrl,
      "price": price,
      "discount": discount,
      "quantity": quantity,
      "unit": unit,
      "minStockLevel": minStockLevel,
      "stockStatus": stockStatus,
      "isActive": isActive,
      "isAvailable": isAvailable,
      "isPrescriptionRequired": isPrescriptionRequired,
      "sellerName": sellerName,
      "countryOfOrigin": countryOfOrigin,
      "ingredients": ingredients,
      "allergens": allergens,
      "rating": rating,
      "reviewCount": reviewCount,
      "tags": tags,
      "salesCount": salesCount,
      "viewCount": viewCount,
      "maxOrderQuantity": maxOrderQuantity,
      "weight": weight,
      "seoKeywords": seoKeywords,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "discountedPrice": discountedPrice,
      'restaurant': restaurant,
      "__v": v,
    };
  }
}
