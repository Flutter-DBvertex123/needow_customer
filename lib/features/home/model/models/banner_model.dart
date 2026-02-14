class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final bool isActive;
  final int displayOrder;
  final String type;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isActive = true,
    this.displayOrder = 0,
    this.type = 'homepage',
    this.priority = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ Convert JSON to BannerModel with proper null safety
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Banner',
      imageUrl: json['image_url']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? true,
      displayOrder: json['displayOrder'] as int? ?? 0,
      type: (json['type']?.toString() ?? 'homepage').toLowerCase(),
      priority: json['priority'] as int? ?? 0,
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  /// ✅ Parse DateTime safely
  static DateTime _parseDateTime(dynamic dateValue) {
    try {
      if (dateValue is String && dateValue.isNotEmpty) {
        return DateTime.parse(dateValue);
      }
      if (dateValue is DateTime) {
        return dateValue;
      }
    } catch (e) {
      print('⚠️ Error parsing date: $e');
    }
    return DateTime.now();
  }

  /// ✅ Convert BannerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image_url': imageUrl,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'type': type,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// ✅ Copy with method for creating modified copies
  BannerModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
    String? type,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// ✅ Equality comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BannerModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  /// ✅ String representation for debugging
  @override
  String toString() =>
      'BannerModel(id: $id, title: $title, type: $type, isActive: $isActive)';

  /// ✅ Check if banner is valid for display
  bool get isValid => id.isNotEmpty && imageUrl.isNotEmpty && isActive;

  /// ✅ Check if banner type matches
  bool isOfType(String bannerType) => type.toLowerCase() == bannerType.toLowerCase();
}