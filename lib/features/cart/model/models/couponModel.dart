class CouponModel {
  final String? id;
  final String? code;
  final String? description;
  final String? discountType; // "fixed" or "percentage"
  final double? discountValue;
  final double? minOrderAmount;
  final double? maxDiscountAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final int? usageLimit;
  final int? usedCount;
  final Map<String, dynamic>? meta;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CouponModel({
    this.id,
    this.code,
    this.description,
    this.discountType,
    this.discountValue,
    this.minOrderAmount,
    this.maxDiscountAmount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.usageLimit,
    this.usedCount,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['_id'],
      code: json['code'],
      description: json['description'],
      discountType: json['discountType'],
      discountValue: (json['discountValue'] ?? 0).toDouble(),
      minOrderAmount: (json['minOrderAmount'] ?? 0).toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] ?? 0).toDouble(),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'],
      usageLimit: json['usageLimit'],
      usedCount: json['usedCount'],
      meta: json['meta'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'description': description,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrderAmount': minOrderAmount,
      'maxDiscountAmount': maxDiscountAmount,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'usageLimit': usageLimit,
      'usedCount': usedCount,
      'meta': meta,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}