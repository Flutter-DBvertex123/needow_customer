/*
import 'buisness_type_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String type;
  final bool isActive;
  final int displayOrder;
  final bool isFeatured;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BusinessTypeModel? businessType;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.isActive,
    required this.displayOrder,
    required this.isFeatured,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    this.businessType,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      isActive: json['isActive'] ?? false,
      displayOrder: json['displayOrder'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      v: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      businessType: json['businessType'] != null
          ? BusinessTypeModel.fromJson(json['businessType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'type': type,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'isFeatured': isFeatured,
      '__v': v,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'businessType': businessType?.toJson(),
    };
  }
}
*/
class CategoryModel {
  final String id;
  final String name;
  final bool isActive;
  final String? description;
  final int? displayOrder;
  final String? type;
  final bool? isFeatured;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.isActive,
    this.description,
    this.displayOrder,
    this.type,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      isActive: json['isActive'],
      description: json['description'],
      displayOrder: json['displayOrder'],
      type: json['type'],
      isFeatured: json['isFeatured'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      imageUrl: json['image_url'] != null
          ? List<String>.from(json['image_url'])
          : [],
    );
  }
}



class SubCategoryModel {
  final String id;
  final String name;
  final CategoryModel? category;
  final String? description;
  final bool isActive;
  final int? displayOrder;
  final List<dynamic> imageUrl;
  final String? createdAt;
  final String? updatedAt;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
    this.description,
    required this.isActive,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
      displayOrder: json['displayOrder'],
      imageUrl: json['image_url'] ??  '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
