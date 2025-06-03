import 'package:boxify/models/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationPermissionGranted extends NotificationState {}

class NotificationPermissionDenied extends NotificationState {}

class NotificationPermissionDeniedPermanently extends NotificationState {}

class NotificationList extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationList(this.notifications);
}