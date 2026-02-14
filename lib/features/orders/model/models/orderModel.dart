/*class OrderModel {
  final String id;
  final String orderNumber;
  final String orderType;
  final String user;
  final String? restaurant;
  final List<OrderedItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final String paymentId;
  final DeliveryAddress deliveryAddress;
  final String deliveryAgent;
  final DateTime estimatedDeliveryTime;
  final String customerNotes;
  final String restaurantNotes;
  final String coupon;
  final List<StatusHistory> statusHistory;
  final bool isScheduled;
  final DateTime scheduledFor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.orderType,
    required this.user,
    this.restaurant,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.paymentId,
    required this.deliveryAddress,
    required this.deliveryAgent,
    required this.estimatedDeliveryTime,
    required this.customerNotes,
    required this.restaurantNotes,
    required this.coupon,
    required this.statusHistory,
    required this.isScheduled,
    required this.scheduledFor,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] as String,
      orderNumber: json['orderNumber'] as String,
      orderType: json['orderType'] as String,
      user: json['user'] as String,
      restaurant: json['restaurant'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderedItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentId: json['paymentId'] as String,
      deliveryAddress:
      DeliveryAddress.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      deliveryAgent: json['deliveryAgent'] as String,
      estimatedDeliveryTime: DateTime.parse(json['estimatedDeliveryTime'] as String),
      customerNotes: json['customerNotes'] as String,
      restaurantNotes: json['restaurantNotes'] as String,
      coupon: json['coupon'] as String,
      statusHistory: (json['statusHistory'] as List<dynamic>)
          .map((status) => StatusHistory.fromJson(status as Map<String, dynamic>))
          .toList(),
      isScheduled: json['isScheduled'] as bool,
      scheduledFor: DateTime.parse(json['scheduledFor'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderNumber': orderNumber,
      'orderType': orderType,
      'user': user,
      'restaurant': restaurant,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'totalAmount': totalAmount,
      'status': status,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'deliveryAddress': deliveryAddress.toJson(),
      'deliveryAgent': deliveryAgent,
      'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
      'customerNotes': customerNotes,
      'restaurantNotes': restaurantNotes,
      'coupon': coupon,
      'statusHistory': statusHistory.map((status) => status.toJson()).toList(),
      'isScheduled': isScheduled,
      'scheduledFor': scheduledFor.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class OrderedItem {
  final String id;
  final String item;
  final String itemModel;
  final String name;
  final double price;
  final int quantity;
  final List<String> image;
  final String variant;
  final String notes;

  OrderedItem({
    required this.id,
    required this.item,
    required this.itemModel,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.variant,
    required this.notes,
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) {
    return OrderedItem(
      id: json['_id'] as String,
      item: json['item'] as String,
      itemModel: json['itemModel'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      image: List<String>.from(json['image'] as List<dynamic>),
      variant: json['variant'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'item': item,
      'itemModel': itemModel,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'variant': variant,
      'notes': notes,
    };
  }
}

class DeliveryAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String user;
  final bool isDefault;
  final String type;
  final String landmark;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.user,
    required this.isDefault,
    required this.type,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['_id'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      pincode: json['pincode'] as String,
      country: json['country'] as String,
      user: json['user'] as String,
      isDefault: json['isDefault'] as bool,
      type: json['type'] as String,
      landmark: json['landmark'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'user': user,
      'isDefault': isDefault,
      'type': type,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class StatusHistory {
  final String id;
  final String status;
  final DateTime timestamp;
  final String note;
  final String updatedBy;

  StatusHistory({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.note,
    required this.updatedBy,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['_id'] as String,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String,
      updatedBy: json['updatedBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
      'updatedBy': updatedBy,
    };
  }
}*/
/*
import 'package:newdow_customer/features/profile/model/userModel.dart';

class OrderModel {
  final String id;
  final String orderNumber;
  final String orderType;
  final String user;
  final String? restaurant;
  final List<OrderedItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final String paymentId;
  final DeliveryAddress? deliveryAddress; // ✅ CHANGED: Made nullable
  final String deliveryAgent;
  final DateTime estimatedDeliveryTime;
  final String customerNotes;
  final String restaurantNotes;
  final String coupon;
  final List<StatusHistory> statusHistory;
  final bool isScheduled;
  final DateTime scheduledFor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.orderType,
    required this.user,
    this.restaurant,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.paymentId,
    this.deliveryAddress, // ✅ CHANGED: Made optional
    required this.deliveryAgent,
    required this.estimatedDeliveryTime,
    required this.customerNotes,
    required this.restaurantNotes,
    required this.coupon,
    required this.statusHistory,
    required this.isScheduled,
    required this.scheduledFor,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   return OrderModel(
  //     id: json['_id'] as String,
  //     orderNumber: json['orderNumber'] as String,
  //     orderType: json['orderType'] as String,
  //     user: (json['user'] is Map<String, dynamic>)
  //         ? json['user']['_id'] as String
  //         : json['user'] as String,
  //     restaurant: json['restaurant'] as String? ?? "",
  //     items: (json['items'] as List<dynamic>)
  //         .map((item) => OrderedItem.fromJson(item as Map<String, dynamic>))
  //         .toList(),
  //     subtotal: (json['subtotal'] as num).toDouble(),
  //     tax: (json['tax'] as num).toDouble(),
  //     deliveryFee: (json['deliveryFee'] as num).toDouble(),
  //     discount: (json['discount'] as num).toDouble(),
  //     totalAmount: (json['totalAmount'] as num).toDouble(),
  //     status: json['status'] as String,
  //     paymentStatus: json['paymentStatus'] as String,
  //     paymentMethod: json['paymentMethod'] as String,
  //     paymentId: json['paymentId'] as String,
  //     // ✅ FIXED: Handle null delivery address
  //     deliveryAddress: json['deliveryAddress'] != null
  //         ? DeliveryAddress.fromJson(
  //         json['deliveryAddress'] as Map<String, dynamic>)
  //         : null,
  //     deliveryAgent: json['deliveryAgent'] as String,
  //     estimatedDeliveryTime:
  //     DateTime.parse(json['estimatedDeliveryTime'] as String),
  //     customerNotes: json['customerNotes'] as String,
  //     restaurantNotes: json['restaurantNotes'] as String,
  //     coupon: json['coupon'] as String,
  //     statusHistory: (json['statusHistory'] as List<dynamic>)
  //         .map((status) =>
  //         StatusHistory.fromJson(status as Map<String, dynamic>))
  //         .toList(),
  //     isScheduled: json['isScheduled'] as bool,
  //     scheduledFor: DateTime.parse(json['scheduledFor'] as String),
  //     createdAt: DateTime.parse(json['createdAt'] as String),
  //     updatedAt: DateTime.parse(json['updatedAt'] as String),
  //     version: json['__v'] as int,
  //   );
  // }
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] as String,
      orderNumber: json['orderNumber'] as String,
      orderType: json['orderType'] as String,

      user: (json['user'] is Map<String, dynamic>)
          ? json['user']['_id'] as String
          : json['user'] as String,

      restaurant: json['restaurant'] as String? ?? "",

      items: (json['items'] as List<dynamic>)
          .map((item) => OrderedItem.fromJson(item as Map<String, dynamic>))
          .toList(),

      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),

      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentId: json['paymentId'] as String,

      // ✅ FIX: deliveryAddress is nullable
      deliveryAddress: json['deliveryAddress'] != null
          ? DeliveryAddress.fromJson(json['deliveryAddress'])
          : null,

      // ✅ FIX: prevent null → String cast crash
      deliveryAgent: json['deliveryAgent'] as String? ?? "",

      // ✅ FIX: handle null timestamp
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'])
          : DateTime.now(),

      // ✅ FIX: null-safe notes
      customerNotes: json['customerNotes'] as String? ?? "",
      restaurantNotes: json['restaurantNotes'] as String? ?? "",

      // ✅ FIX: null-safe coupon
      coupon: json['coupon'] as String? ?? "",

      statusHistory: (json['statusHistory'] as List<dynamic>)
          .map((status) =>
          StatusHistory.fromJson(status as Map<String, dynamic>))
          .toList(),

      isScheduled: json['isScheduled'] as bool,

      scheduledFor: json['scheduledFor'] != null
          ? DateTime.parse(json['scheduledFor'])
          : DateTime.now(),

      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderNumber': orderNumber,
      'orderType': orderType,
      'user': user,
      'restaurant': restaurant,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'totalAmount': totalAmount,
      'status': status,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'deliveryAddress': deliveryAddress?.toJson(),
      'deliveryAgent': deliveryAgent,
      'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
      'customerNotes': customerNotes,
      'restaurantNotes': restaurantNotes,
      'coupon': coupon,
      'statusHistory': statusHistory.map((status) => status.toJson()).toList(),
      'isScheduled': isScheduled,
      'scheduledFor': scheduledFor.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class OrderedItem {
  final String id;
  final String item;
  final String itemModel;
  final String name;
  final double price;
  final int quantity;
  final List<String> image;
  final String variant;
  final String notes;

  OrderedItem({
    required this.id,
    required this.item,
    required this.itemModel,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.variant,
    required this.notes,
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];

    if (json['image'] is String) {
      String imgStr = json['image'] as String;

      // Remove [ ] and spaces
      imgStr = imgStr.replaceAll('[', '').replaceAll(']', '').trim();

      if (imgStr.contains(', ')) {
        // MULTIPLE IMAGES -> Split only on comma + space
        parsedImages = imgStr
            .split(', ')
            .map((s) => s.trim())
            .toList();
      } else {
        // SINGLE IMAGE -> leave as it is
        parsedImages = [imgStr];
      }
    } else if (json['image'] is List) {
      parsedImages = List<String>.from(json['image']);
    }

    return OrderedItem(
      id: json['_id'] as String,
      item: json['item'] as String,
      itemModel: json['itemModel'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      // ✅ FIXED: Handle image as string (comes as "[url]" in your data)
   image: parsedImages,
      // image: json['image'] is String
      //     ? [json['image'] as String]
      //     : List<String>.from(json['image'] as List<dynamic>),
      variant: json['variant'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'item': item,
      'itemModel': itemModel,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'variant': variant,
      'notes': notes,
    };
  }
}

class DeliveryAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String user;
  final bool isDefault;
  final String type;
  final String landmark;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.user,
    required this.isDefault,
    required this.type,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['_id'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      pincode: json['pincode'] as String,
      country: json['country'] as String,
      user: json['user'] as String,
      isDefault: json['isDefault'] as bool,
      type: json['type'] as String,
      landmark: json['landmark'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'user': user,
      'isDefault': isDefault,
      'type': type,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class StatusHistory {
  final String id;
  final String status;
  final DateTime timestamp;
  final String note;
  final String updatedBy;

  StatusHistory({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.note,
    required this.updatedBy,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['_id'] as String,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String,
      updatedBy: json['updatedBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
      'updatedBy': updatedBy,
    };
  }
}
*/
class OrderModel {
  final String id;
  final String orderNumber;
  final String orderType;
  final String user;
  final String restaurant;
  final List<OrderedItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final String paymentId;
  final DeliveryAddress? deliveryAddress;
  final String deliveryAgent;
  final DateTime estimatedDeliveryTime;
  final String customerNotes;
  final String restaurantNotes;
  final String coupon;
  final List<StatusHistory> statusHistory;
  final bool isScheduled;
  final DateTime scheduledFor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.orderType,
    required this.user,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.paymentId,
    this.deliveryAddress,
    required this.deliveryAgent,
    required this.estimatedDeliveryTime,
    required this.customerNotes,
    required this.restaurantNotes,
    required this.coupon,
    required this.statusHistory,
    required this.isScheduled,
    required this.scheduledFor,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id']?.toString() ?? "",
      orderNumber: json['orderNumber']?.toString() ?? "",
      orderType: json['orderType']?.toString() ?? "",

      user: json['user'] is Map
          ? json['user']['_id']?.toString() ?? ""
          : json['user']?.toString() ?? "",

      restaurant: json['restaurant']?.toString() ?? "",

      items: (json['items'] as List? ?? [])
          .map((e) => OrderedItem.fromJson(e))
          .toList(),

      subtotal: (json['subtotal'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),

      status: json['status']?.toString() ?? "",
      paymentStatus: json['paymentStatus']?.toString() ?? "",
      paymentMethod: json['paymentMethod']?.toString() ?? "",
      paymentId: json['paymentId']?.toString() ?? "",

      deliveryAddress: json['deliveryAddress'] != null
          ? DeliveryAddress.fromJson(json['deliveryAddress'])
          : null,

      deliveryAgent: json['deliveryAgent']?.toString() ?? "",

      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.tryParse(json['estimatedDeliveryTime']) ?? DateTime.now()
          : DateTime.now(),

      customerNotes: json['customerNotes']?.toString() ?? "",
      restaurantNotes: json['restaurantNotes']?.toString() ?? "",
      coupon: json['coupon']?.toString() ?? "",

      statusHistory: (json['statusHistory'] as List? ?? [])
          .map((e) => StatusHistory.fromJson(e))
          .toList(),

      isScheduled: json['isScheduled'] ?? false,

      scheduledFor: json['scheduledFor'] != null
          ? DateTime.tryParse(json['scheduledFor']) ?? DateTime.now()
          : DateTime.now(),

      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),

      version: json['__v'] ?? 0,
    );
  }
}


/// -------------------- ORDERED ITEM -------------------- ///
class OrderedItem {
  final String id;
  final String item;
  final String itemModel;
  final String name;
  final double price;
  final int quantity;
  final List<String> image;
  final String variant;
  final String notes;

  OrderedItem({
    required this.id,
    required this.item,
    required this.itemModel,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.variant,
    required this.notes,
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) {
    List<String> images = [];

    if (json['image'] is String) {
      String img = json['image']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim();
      images = img.split(",").map((e) => e.trim()).toList();
    } else if (json['image'] is List) {
      images = List<String>.from(json['image']);
    }

    return OrderedItem(
      id: json['_id']?.toString() ?? "",
      item: json['item']?.toString() ?? "",
      itemModel: json['itemModel']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      image: images,
      variant: json['variant']?.toString() ?? "",
      notes: json['notes']?.toString() ?? "",
    );
  }
}


/// -------------------- DELIVERY ADDRESS -------------------- ///
class DeliveryAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String user;
  final bool isDefault;
  final String type;
  final String landmark;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.user,
    required this.isDefault,
    required this.type,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['_id']?.toString() ?? "",
      street: json['street']?.toString() ?? "",
      city: json['city']?.toString() ?? "",
      state: json['state']?.toString() ?? "",
      pincode: json['pincode']?.toString() ?? "",
      country: json['country']?.toString() ?? "",
      user: json['user']?.toString() ?? "",
      isDefault: json['isDefault'] ?? false,
      type: json['type']?.toString() ?? "",
      landmark: json['landmark']?.toString() ?? "",
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }
}


/// -------------------- STATUS HISTORY -------------------- ///
class StatusHistory {
  final String id;
  final String status;
  final DateTime timestamp;
  final String note;
  final String updatedBy;

  StatusHistory({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.note,
    required this.updatedBy,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['_id']?.toString() ?? "",
      status: json['status']?.toString() ?? "",
      timestamp:
      DateTime.tryParse(json['timestamp'] ?? "") ?? DateTime.now(),
      note: json['note']?.toString() ?? "",
      updatedBy: json['updatedBy']?.toString() ?? "",
    );
  }
}
