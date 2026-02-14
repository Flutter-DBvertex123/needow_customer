// import '../../../orders/model/models/orderModel.dart';
// import 'cartModel.dart';
//
// class CartCheckoutModel {
//   DeliveryAddress? deliveryAddress;
//   Map<String, CartGroup>? groups;
//   int? grandTotal;
//   DateTime? calculationTimestamp;
//
//   CartCheckoutModel({
//     this.deliveryAddress,
//     this.groups,
//     this.grandTotal,
//     this.calculationTimestamp,
//   });
//
//   factory CartCheckoutModel.fromJson(Map<String, dynamic> json) {
//     return CartCheckoutModel(
//       deliveryAddress: json['delivery_address'] != null
//           ? DeliveryAddress.fromJson(json['delivery_address'])
//           : null,
//       groups: json['groups'] != null
//           ? (json['groups'] as Map<String, dynamic>).map(
//             (key, value) =>
//             MapEntry(key, CartGroup.fromJson(value)),
//       )
//           : null,
//       grandTotal: json['grand_total'],
//       calculationTimestamp:
//       json['calculation_timestamp'] != null
//           ? DateTime.parse(json['calculation_timestamp'])
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'delivery_address': deliveryAddress,
//       'groups': groups?.map(
//             (key, value) => MapEntry(key, value.toJson()),
//       ),
//       'grand_total': grandTotal,
//       'calculation_timestamp':
//       calculationTimestamp?.toIso8601String(),
//     };
//   }
// }
// class CartGroup {
//   List<CartItem>? items;
//   int? subtotal;
//   double? totalDistance;
//   int? deliveryFee;
//   int? platformCharges;
//   int? groupTotal;
//
//   CartGroup({
//     this.items,
//     this.subtotal,
//     this.totalDistance,
//     this.deliveryFee,
//     this.platformCharges,
//     this.groupTotal,
//   });
//
//   factory CartGroup.fromJson(Map<String, dynamic> json) {
//     return CartGroup(
//       items: json['items'] != null
//           ? (json['items'] as List)
//           .map((e) => CartItem.fromJson(e))
//           .toList()
//           : [],
//       subtotal: json['subtotal'],
//       totalDistance:
//       (json['total_distance'] as num?)?.toDouble(),
//       deliveryFee: json['delivery_fee'],
//       platformCharges: json['platform_charges'],
//       groupTotal: json['group_total'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'items': items?.map((e) => e.toJson()).toList(),
//       'subtotal': subtotal,
//       'total_distance': totalDistance,
//       'delivery_fee': deliveryFee,
//       'platform_charges': platformCharges,
//       'group_total': groupTotal,
//     };
//   }
// }
import 'package:newdow_customer/features/address/model/addressModel.dart';

import 'cartModel.dart';

class CartCheckoutModel {
  AddressModel? deliveryAddress;
  CheckoutGroups? groups;
  num? grandTotal;
  DateTime? calculationTimestamp;

  CartCheckoutModel({
    this.deliveryAddress,
    this.groups,
    this.grandTotal,
    this.calculationTimestamp,
  });

  factory CartCheckoutModel.fromJson(Map<String, dynamic> json) {
    return CartCheckoutModel(
      deliveryAddress: json['delivery_address'] != null
          ? AddressModel.fromJson(json['delivery_address'])
          : null,
      groups: json['groups'] != null
          ? CheckoutGroups.fromJson(json['groups'])
          : null,
      grandTotal: json['grand_total'],
      calculationTimestamp:
      json['calculation_timestamp'] != null
          ? DateTime.parse(json['calculation_timestamp'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_address': deliveryAddress?.toJson(),
      'groups': groups?.toJson(),
      'grand_total': grandTotal,
      'calculation_timestamp':
      calculationTimestamp?.toIso8601String(),
    };
  }
}
class CheckoutGroups {
  CartGroup? grocery;
  CartGroup? food;
  CartGroup? medicine;

  CheckoutGroups({
    this.grocery,
    this.food,
    this.medicine,
  });

  factory CheckoutGroups.fromJson(Map<String, dynamic> json) {
    return CheckoutGroups(
      grocery: json['grocery'] != null
          ? CartGroup.fromJson(json['grocery'])
          : CartGroup.empty(),
      food: json['food'] != null
          ? CartGroup.fromJson(json['food'])
          : CartGroup.empty(),
      medicine: json['medicine'] != null
          ? CartGroup.fromJson(json['medicine'])
          : CartGroup.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grocery': grocery?.toJson(),
      'food': food?.toJson(),
      'medicine': medicine?.toJson(),
    };
  }
}
class CartGroup {
  List<CartItem> items;
  num subtotal;
  double totalDistance;
  num deliveryFee;
  num platformCharges;
  num groupTotal;

  CartGroup({
    required this.items,
    required this.subtotal,
    required this.totalDistance,
    required this.deliveryFee,
    required this.platformCharges,
    required this.groupTotal,
  });

  factory CartGroup.fromJson(Map<String, dynamic> json) {
    return CartGroup(
      items: json['items'] != null
          ? (json['items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList()
          : [],
      subtotal: json['subtotal'] ?? 0,
      totalDistance:
      (json['total_distance'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: json['delivery_fee'] ?? 0,
      platformCharges: json['platform_charges'] ?? 0,
      groupTotal: json['group_total'] ?? 0,
    );
  }

  /// Empty group fallback
  factory CartGroup.empty() {
    return CartGroup(
      items: [],
      subtotal: 0,
      totalDistance: 0,
      deliveryFee: 0,
      platformCharges: 0,
      groupTotal: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'total_distance': totalDistance,
      'delivery_fee': deliveryFee,
      'platform_charges': platformCharges,
      'group_total': groupTotal,
    };
  }
}
