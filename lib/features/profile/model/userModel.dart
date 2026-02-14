class UserModel {
  final String id;
  final String name;
  final String phone;
  final String role;
  final String status;
  final List<String> addresses;
  final String? defaultAddressId;
  final List<dynamic> restaurants;
  final bool isDashboardUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final bool isProfileComplete;
  final String? dob;
  final String? email;
  final String? gender;
  final String? photo;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.status,
    required this.addresses,
    this.defaultAddressId,
    required this.restaurants,
    required this.isDashboardUser,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    required this.isProfileComplete,
    this.dob,
    this.email,
    this.gender,
    this.photo,
  });
  UserModel.empty()
      : id = '',
        name = '',
        phone = '',
        role = '',
        status = '',
        addresses = const [],
        defaultAddressId = null,
        restaurants = const [],
        isDashboardUser = false,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        lastLoginAt = null,
        isProfileComplete = false,
        dob = null,
        email = null,
        gender = null,
        photo = null;


  /// ✅ Factory constructor to parse JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      defaultAddressId: json['defaultAddressId'],
      restaurants: json['restaurants'] ?? [],
      isDashboardUser: json['isDashboardUser'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      lastLoginAt: DateTime.tryParse(json['lastLoginAt'] ?? ''),
      isProfileComplete: json['isProfileComplete'] ?? false,
      dob: json['dob'],
      email: json['email'],
      gender: json['gender'],
      photo: json['photo'],
    );
  }

  /// 📦 Convert back to JSON (for PUT or POST requests)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      "role": role,
      "status": status,
      "addresses": addresses,
      "defaultAddressId": defaultAddressId,
      "restaurants": restaurants,
      "isDashboardUser": isDashboardUser,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "lastLoginAt": lastLoginAt?.toIso8601String(),
      "isProfileComplete": isProfileComplete,
      "dob": dob,
      "email": email,
      "gender": gender,
      "photo": photo,
    };
  }
}
