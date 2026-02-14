import '../../../cart/model/models/cartModel.dart';

class CreateOrderModel {
  String? orderNumber;
  String? orderType;
  String? user;
  String? restaurant;
  List<OrderItem>? items;
  num? subtotal;
  double? tax;
  double? deliveryFee;
  PickupLocation? pickupLocation;
  double? discount;
  double? totalAmount;
  String? status;
  String? paymentStatus;
  String? paymentMethod;
  String? paymentId;
  String? deliveryAddress;
  String? deliveryAgent;
  String? customerNotes;
  String? restaurantNotes;
  String? coupon;
  bool? isScheduled;
  DateTime? scheduledFor;

  CreateOrderModel({
    this.pickupLocation,
    this.orderNumber,
    this.orderType,
    this.user,
    this.restaurant,
    this.items,
    this.subtotal,
    this.tax,
    this.deliveryFee,
    this.discount,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.paymentId,
    this.deliveryAddress,
    this.deliveryAgent,
    this.customerNotes,
    this.restaurantNotes,
    this.coupon,
    this.isScheduled,
    this.scheduledFor,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      orderNumber: json['orderNumber'],
      orderType: json['orderType'],
      user: json['user'],
      restaurant: json['restaurant'],
      items: json['items'] != null
          ? (json['items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList()
          : [],
      pickupLocation: json['pickup_location'] != null
          ? PickupLocation.fromJson(json['pickup_location'])
          : null,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      paymentId: json['paymentId'],
      deliveryAddress: json['deliveryAddress'],
      deliveryAgent: json['deliveryAgent'],
      customerNotes: json['customerNotes'],
      restaurantNotes: json['restaurantNotes'],
      coupon: json['coupon'],
      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: json['scheduledFor'] != null
          ? DateTime.parse(json['scheduledFor'])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "orderNumber": orderNumber,
      "orderType": orderType,
      "user": user,
      "restaurant": restaurant,
      "items": items?.map((e) => e.toJson()).toList(),
      "pickup_location": pickupLocation?.toJson(),
      "subtotal": subtotal,
      "tax": tax,
      "deliveryFee": deliveryFee,
      "discount": discount,
      "totalAmount": totalAmount,
      "status": status,
      "paymentStatus": paymentStatus,
      "paymentMethod": paymentMethod,
      "paymentId": paymentId,
      "deliveryAddress": deliveryAddress,
      "deliveryAgent": deliveryAgent,
      "customerNotes": customerNotes,
      "restaurantNotes": restaurantNotes,
      "coupon": coupon,
      "isScheduled": isScheduled,
      "scheduledFor": scheduledFor?.toIso8601String(),
    };
  }
}

class OrderItem {
  String? item;
  String? itemModel;
  String? name;
  double? price;
  num? quantity;
  String? image;
  String? variant;
  String? notes;
  String? prescriptionUrl;

  OrderItem({
    this.item,
    this.itemModel,
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.variant,
    this.notes,
    this.prescriptionUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      item: json['item'],
      itemModel: json['itemModel'],
      name: json['name'],
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      image: json['image'],
      variant: json['variant'],
      notes: json['notes'],
      prescriptionUrl: json["prescriptionUrl"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "item": item,
      "itemModel": itemModel,
      "name": name,
      "price": price,
      "quantity": quantity,
      "image": image,
      "variant": variant,
      "notes": notes,
      "prescriptionUrl": prescriptionUrl
    };
  }
  CartItem? getItems(List<CartItem> cartItems) {
    if (cartItems.isNotEmpty) {
      return cartItems.first;
    }
    return null;
  }
}
class PickupLocation {
  final String? type;
  final List<double>? coordinates; // [longitude, latitude]

  const PickupLocation({
    this.type,
    this.coordinates,
  });

  /// Factory constructor from JSON
  factory PickupLocation.fromJson(Map<String, dynamic> json) {
    return PickupLocation(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(
        json['coordinates'].map((e) => (e as num).toDouble()),
      )
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  /// Convenience getters
  double? get longitude =>
      (coordinates != null && coordinates!.isNotEmpty)
          ? coordinates![0]
          : null;

  double? get latitude =>
      (coordinates != null && coordinates!.length > 1)
          ? coordinates![1]
          : null;
}
