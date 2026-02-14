class NotificationMeta {
  final String? orderId;

  NotificationMeta({this.orderId});

  factory NotificationMeta.fromMap(Map<String, dynamic> map) {
    return NotificationMeta(
      orderId: map['orderId']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
    };
  }
}

class NotificationModel {
  final String id;
  final String user;
  final String title;
  final String message;
  final bool read;
  final DateTime sentAt;
  final bool isActive;
  final int displayOrder;
  final int priority;
  final String channel;
  final NotificationMeta? meta;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.user,
    required this.title,
    required this.message,
    required this.read,
    required this.sentAt,
    required this.isActive,
    required this.displayOrder,
    required this.priority,
    required this.channel,
    required this.meta,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'] ?? '',
      user: map['user'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      read: map['read'] ?? false,
      sentAt: map['sentAt'] != null
          ? DateTime.parse(map['sentAt'])
          : DateTime.now(),
      isActive: map['isActive'] ?? true,
      displayOrder: map['displayOrder'] ?? 0,
      priority: map['priority'] ?? 0,
      channel: map['channel'] ?? '',
      meta: map['meta'] != null ? NotificationMeta.fromMap(map['meta']) : null,
      type: map['type'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': user,
      'title': title,
      'message': message,
      'read': read,
      'sentAt': sentAt.toIso8601String(),
      'isActive': isActive,
      'displayOrder': displayOrder,
      'priority': priority,
      'channel': channel,
      'meta': meta?.toMap(),
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    bool? read,
  }) {
    return NotificationModel(
      id: id,
      user: user,
      title: title,
      message: message,
      read: read ?? this.read,
      sentAt: sentAt,
      isActive: isActive,
      displayOrder: displayOrder,
      priority: priority,
      channel: channel,
      meta: meta,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class NotificationListResponse {
  final List<NotificationModel> data;
  final int total;
  final int page;
  final int limit;

  NotificationListResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory NotificationListResponse.fromMap(Map<String, dynamic> map) {
    final list = map['data']['data'] as List<dynamic>;

    return NotificationListResponse(
      data: list.map((e) => NotificationModel.fromMap(e)).toList(),
      total: map['data']['total'] ?? 0,
      page: map['data']['page'] ?? 1,
      limit: map['data']['limit'] ?? 20,
    );
  }
}
