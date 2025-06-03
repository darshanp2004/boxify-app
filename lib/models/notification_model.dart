class NotificationModel {
  final String message;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.message,
    required this.timestamp,
    required this.isRead
  });
}
