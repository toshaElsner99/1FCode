import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/utils/app_utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications data - in real app, this would come from API/storage
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: AppCommonString.profileUpdate,
      description: AppCommonString.profileUpdateDesc,
      time: '2 hours ago',
      isRead: false,
      type: NotificationType.success,
      category: NotificationCategory.today,
    ),
    NotificationItem(
      id: '2',
      title: AppCommonString.nomineeAdded,
      description: AppCommonString.nomineeAddedDesc,
      time: '5 hours ago',
      isRead: false,
      type: NotificationType.info,
      category: NotificationCategory.today,
    ),
    NotificationItem(
      id: '3',
      title: AppCommonString.subscriptionRenewal,
      description: AppCommonString.subscriptionRenewalDesc,
      time: '1 day ago',
      isRead: true,
      type: NotificationType.warning,
      category: NotificationCategory.yesterday,
    ),
    NotificationItem(
      id: '4',
      title: AppCommonString.securityAlert,
      description: AppCommonString.securityAlertDesc,
      time: '2 days ago',
      isRead: true,
      type: NotificationType.error,
      category: NotificationCategory.yesterday,
    ),
    NotificationItem(
      id: '5',
      title: AppCommonString.systemUpdate,
      description: AppCommonString.systemUpdateDesc,
      time: '3 days ago',
      isRead: true,
      type: NotificationType.info,
      category: NotificationCategory.thisWeek,
    ),
    NotificationItem(
      id: '6',
      title: AppCommonString.reminder,
      description: AppCommonString.reminderDesc,
      time: '1 week ago',
      isRead: true,
      type: NotificationType.info,
      category: NotificationCategory.older,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: AppCommonString.notifications,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
      ),
      backgroundColor: AppColor.screenBgColor,
      body: _notifications.isEmpty ? _buildEmptyState() : _buildNotificationsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 60,
                color: AppColor.greyText,
              ),
            ),
            const SizedBox(height: 32),
            
            // Empty state title
            Text(
              AppCommonString.noNotifications,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 24,
                color: AppColor.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Empty state description
            Text(
              AppCommonString.noNotificationsDesc,
              style: AppTextStyles.regular.copyWith(
                fontSize: 16,
                color: AppColor.greyText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    // Group notifications by category
    final groupedNotifications = _groupNotificationsByCategory();
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        final category = groupedNotifications.keys.elementAt(index);
        final notifications = groupedNotifications[category]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Padding(
              padding: EdgeInsets.only(bottom: 16, top: index > 0 ? 24 : 0),
              child: Text(
                _getCategoryTitle(category),
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            
            // Notifications in this category
            ...notifications.map((notification) => _buildNotificationCard(notification)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: notification.isRead 
            ? null 
            : Border.all(color: AppColor.primary, width: 1),
      ),
      child: InkWell(
        onTap: () => _onNotificationTap(notification),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and unread indicator
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.semiBold.copyWith(
                              fontSize: 16,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Description
                    Text(
                      notification.description,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        color: AppColor.greyText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Time
                    Text(
                      notification.time,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 12,
                        color: AppColor.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<NotificationCategory, List<NotificationItem>> _groupNotificationsByCategory() {
    final Map<NotificationCategory, List<NotificationItem>> grouped = {};
    
    for (final notification in _notifications) {
      if (!grouped.containsKey(notification.category)) {
        grouped[notification.category] = [];
      }
      grouped[notification.category]!.add(notification);
    }
    
    return grouped;
  }

  String _getCategoryTitle(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.today:
        return AppCommonString.today;
      case NotificationCategory.yesterday:
        return AppCommonString.yesterday;
      case NotificationCategory.thisWeek:
        return AppCommonString.thisWeek;
      case NotificationCategory.older:
        return AppCommonString.older;
    }
  }


  void _onNotificationTap(NotificationItem notification) {
    // Mark as read if unread
    if (!notification.isRead) {
      setState(() {
        notification.isRead = true;
      });
    }
    
    // Handle notification tap based on type
    AppUtils.instance.showSnackBar(
      context,
      '${notification.title} tapped',
      backgroundColor: AppColor.primary,
    );
  }
}

// Notification model classes
class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String time;
  bool isRead;
  final NotificationType type;
  final NotificationCategory category;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.type,
    required this.category,
  });
}

enum NotificationType {
  success,
  info,
  warning,
  error,
}

enum NotificationCategory {
  today,
  yesterday,
  thisWeek,
  older,
}
