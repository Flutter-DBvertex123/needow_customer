

class AddToCartModel {
  final String userId;
  final List<CartProduct> items;
  final bool isActive;
  final double cartTotal;

  AddToCartModel({
    required this.userId,
    required this.items,
    required this.isActive,
    required this.cartTotal,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    final itemsList = (json['items'] as List<dynamic>?)
        ?.map((item) => CartProduct.fromJson(item))
        .toList() ??
        [];

    return AddToCartModel(
      userId: json['userId'] ?? '',
      items: itemsList,
      isActive: json['isActive'] ?? true,
      cartTotal: (json['cartTotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'cartTotal': cartTotal,
    };
  }
}




class CartProduct {
  final String productId;
  final int quantity;
  final double price;
  final double discount;

  CartProduct({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.discount,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'discount': discount,
    };
  }
}
