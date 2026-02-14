import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.find<NotificationController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchNotifications(refresh: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (controller.isMoreDataAvailable.value &&
            !controller.isLoading.value) {
          controller.fetchNotifications();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Obx(() {
          return AppBar(
surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.primary,
                    size: 22,
                    weight: 800,
                  ),
                ),
              ),
            ),
            title: Text("Notifications", style: TextStyle(color: Colors.black)),
            centerTitle: true,

            actions: [
              controller.isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : controller.unreadCount > 0
                  ? Container(
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${controller.unreadCount} New",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        }),
      ),

      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: List.generate(12, (i) => _shimmerTile()),
          );
        }

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            // GROUP SECTIONS
            ...controller.groupKeys.map((group) {
              return _buildGroupSection(group, controller);
            }).toList(),

            // PAGINATION LOADING
            if (controller.isLoading.value &&
                controller.notifications.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildGroupSection(String title, NotificationController controller) {
    final list = controller.groupedNotifications[title] ?? [];

    if (list.isEmpty) return SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Obx(() {
                  final hasUnread = controller.groupedNotifications[title]
                      ?.any((e) => !e.read) ??
                      false;
                  return hasUnread
                      ? GestureDetector(
                    onTap: () => controller.markGroupAsRead(title),
                    child: Text(
                      "Mark all as read",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                      : const SizedBox();
                }),
              ],
            ),
          ),
          ...list.map((e) => _notificationTile(e)),
        ],
      ),
    );
  }
  Widget _notificationTile(NotificationModel model) {
    bool isExpanded = controller.expandedId.value == model.id;

    return GestureDetector(
      onTap: () async {
        final wasExpanded = controller.expandedId.value == model.id;
        controller.expandedId.value = wasExpanded ? "" : model.id;

        if (!model.read && !wasExpanded) {
          await controller.markSingleAsRead(model.id); // Local + Server
        }
      },
      child: Obx(() {
        bool isExpanded = controller.expandedId.value == model.id;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ICON
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIcon(model.type),
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),

                  SizedBox(width: 12),

                  // TITLE + MESSAGE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: model.read
                                ? Colors.black
                                : AppColors.primary,

                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 6),

                        // EXPANDABLE MESSAGE
                        AnimatedCrossFade(
                          firstChild: Text(
                            model.message,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          secondChild: Text(
                            model.message,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 250),
                        ),
                      ],
                    ),
                  ),

                  // TIME
                  Text(
                    _timeAgo(model.sentAt),
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),

            // DIVIDER BELOW CARD
            Divider(thickness: 0.7, color: Colors.green.shade300, height: 1),
          ],
        );
      }),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "order":
        return Icons.local_shipping_outlined;
      case "offer":
        return Icons.local_offer;
      case "review":
        return Icons.star_border;
      default:
        return Icons.notifications;
    }
  }

  String _timeAgo(DateTime utcDate) {
    final date = utcDate.toLocal();

    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = date.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $amPm";
  }

  Widget _shimmerTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 120, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
