class WalletModel {
  final String id;
  final String walletId;
  final String type;
  final double amount;
  final double balanceAfter;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v;

  WalletModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['_id'] as String,
      walletId: json['walletId'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      balanceAfter: (json['balanceAfter'] as num).toDouble(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  // List ke liye helper
  static List<WalletModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => WalletModel.fromJson(json)).toList();
  }
}