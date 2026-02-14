import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/prefs.dart';
import '../model/notification_model.dart';
import '../service/notification_service.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserId().then((_) => fetchNotifications(refresh: true));
  }

  // ==================== OBSERVABLES ====================
  RxString expandedId = "".obs;
  RxSet<String> markingAsReadIds = <String>{}.obs;
  RxList<String> groupKeys = <String>[].obs;
  final NotificationService service;
  NotificationController(this.service);

  late String? userId;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isMoreDataAvailable = true.obs;
  RxInt page = 1.obs;
  RxInt total = 0.obs;
  RxInt limit = 20.obs;

  // CHANGE 1: RxMap banao
  RxMap<String, List<NotificationModel>> groupedNotifications = <String, List<NotificationModel>>{}.obs;

  // DELETE OLD GETTER
  // Map<String, List<...>> get groupedNotifications { ... }

  // ==================== COMPUTED ====================
  int get unreadCount => notifications.where((e) => !e.read).length;

  bool hasUnreadInGroup(String group) {
    return groupedNotifications[group]?.any((e) => !e.read) ?? false;
  }

  // ==================== GROUPING LOGIC ====================
  void _updateGroupedNotifications() {
    print("_updateGroupedNotifications call");
    final Map<String, List<NotificationModel>> map = {};
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));

    for (var n in notifications) {
      String key;
      if (n.sentAt.isAfter(todayStart)) {
        key = "Today";
      } else if (n.sentAt.isAfter(yesterdayStart)) {
        key = "Yesterday";
      } else {
        key = DateFormat("dd MMM yyyy").format(n.sentAt);
      }
      map.putIfAbsent(key, () => []);
      map[key]!.add(n);
    }

    groupedNotifications.assignAll(map);
    groupKeys.assignAll(map.keys.toList());
  }
  // ==================== FETCH NOTIFICATIONS ====================
  Future<void> fetchNotifications({bool refresh = false}) async {
    print("[fetchNotifications] call : Refresh: $refresh");
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      if (refresh) {
        page.value = 1;
        notifications.clear();
        isMoreDataAvailable.value = true;
      }
      print("getting notification");
      final response = await service.getNotifications(
        userId: userId ?? "",
        page: page.value,
        limit: limit.value,
      );

      notifications.addAll(response.data);
      notifications.sort((a, b) => b.sentAt.compareTo(a.sentAt));
      total.value = response.total;

      if (notifications.length >= total.value) {
        isMoreDataAvailable.value = false;
      } else {
        page.value++;
      }

      _updateGroupedNotifications(); // ADD HERE

    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== MARK READ ====================
  Future<List<String>> markRead(List<String> ids) async {
    print("ids: $ids");
    try {
      final updatedIds = await service.markAllAsRead(ids);

      for (var id in updatedIds) {
        final index = notifications.indexWhere((n) => n.id == id);
        if (index != -1) {
          notifications[index] = notifications[index].copyWith(read: true);
        }
      }

      notifications.refresh();
      _updateGroupedNotifications(); // ADD HERE

      return updatedIds;
    } catch (e) {
      print("Error marking read: $e");
      return [];
    }
  }

  // ==================== MARK SINGLE ====================
  Future<void> markSingleAsRead(String id) async {
    if (id.isEmpty) return;

    final index = notifications.indexWhere((n) => n.id == id);
    if (index == -1) return;

    // Optimistic UI
    notifications[index] = notifications[index].copyWith(read: true);
    notifications.refresh();
    _updateGroupedNotifications(); // ADD HERE

    try {
      await service.markAllAsRead([id]);
    } catch (e) {
      print("Failed to mark read on server: $e");
    }
  }

  Future<void> markGroupAsRead(String group) async {
    print("mark as read group: $group");

    // notifications se directly filter karo — groupedNotifications pe depend mat karo
    final ids = notifications
        .where((n) => n.read == false && _getGroupKey(n.sentAt) == group)
        .map((e) => e.id)
        .toList();

    print("mark as read ids: $ids");
    if (ids.isEmpty) return;

    await markRead(ids);
    print("mark as read done");

    _updateGroupedNotifications();
    print("mark as update code done");

    groupedNotifications.refresh();
    print("mark as update part  code done");
    fetchNotifications(refresh: true);
  }
  // ==================== OTHERS ====================
  Future<void> getUserId() async {
    userId = await AuthStorage.getUserFromPrefs().then((user) => user?.id ?? "");
  }

  Future<bool> sendPushNotification({
    required String user,
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? meta,
  }) async {
    return service.sendNotification(
      user: user,
      title: title,
      message: message,
      type: type,
      meta: meta,
    );
  }

  Future<NotificationModel?> getNotificationDetails(String notificationId) async {
    try {
      return await service.getNotificationById(notificationId);
    } catch (e) {
      print("Error fetching notification details: $e");
      return null;
    }
  }

  String _getGroupKey(DateTime sentAt) {
    print("_getGroupKey call");
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));

    if (sentAt.isAfter(todayStart)) return "Today";
    if (sentAt.isAfter(yesterdayStart)) return "Yesterday";
    return DateFormat("dd MMM yyyy").format(sentAt);
  }
}