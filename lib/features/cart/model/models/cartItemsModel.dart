class CartItems {
  final String productId;
  final int quantity;
  final String prescriptionUrl;


  CartItems({
    required this.productId,
    required this.quantity,
    required this.prescriptionUrl,
  });

  // copyWith for immutability / easy updates
  CartItems copyWith({
    String? productId,
    int? quantity,
    String? prescriptionUrl
  }) {
    return CartItems(
      prescriptionUrl: prescriptionUrl ?? this.prescriptionUrl,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  // JSON helpers
  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      prescriptionUrl: json["prescriptionUrl"] ?? "",
      productId: json['productId'] ?? '',
      quantity: (json['quantity'] ?? 0) is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "prescriptionUrl":prescriptionUrl,
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  String toString() => 'CartItems(productId: $productId, quantity: $quantity)';
}
