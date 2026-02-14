import '../../../utils/constants.dart';
import '../model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
abstract class NotificationService {
  Future<NotificationListResponse> getNotifications({
    required String userId,
    int page,
    int limit,
    String? search,
  });

  Future<bool> sendNotification({
    required String user,
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? meta,
  });
  Future<NotificationModel> getNotificationById(String id);

  Future<List<String>> markAllAsRead(List<String> ids);

}


class NotificationServiceImpl implements NotificationService {

  @override
  Future<NotificationListResponse> getNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    final uri = Uri.parse(
      "$notificationUrl/user/$userId?page=$page&limit=$limit&search=${search ?? ''}",
    );
    print("getNotifications");
    final res = await http.get(uri);
    print("getNotifications response ${res.statusCode}");
    print("getNotifications response ${res.body}");
    if (res.statusCode == 200) {
      print("notificatons");
      final body = jsonDecode(res.body);
      return NotificationListResponse.fromMap(body);
    } else {
      throw Exception("Failed to fetch notifications");
    }
  }

  @override
  Future<bool> sendNotification({
    required String user,
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? meta,
  }) async {
    final uri = Uri.parse(notificationUrl);

    final body = {
      "user": user,
      "title": title,
      "message": message,
      "type": type,
      "meta": meta ?? {},
    };

    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return res.statusCode == 201 || res.statusCode == 200;
  }
  @override
  Future<NotificationModel> getNotificationById(String id) async {
    final uri = Uri.parse("$notificationUrl/$id");

    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return NotificationModel.fromMap(body['data']);
    } else {
      throw Exception("Failed to fetch notification");
    }
  }
  @override
  Future<List<String>> markAllAsRead(List<String> ids) async {
    final uri = Uri.parse("$notificationUrl/mark-all-read");

    final body = {"ids": ids};

    final res = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body);
      return List<String>.from(data["ids"] ?? []);
    } else {
      throw Exception("Failed to mark notifications as read");
    }
  }
}
