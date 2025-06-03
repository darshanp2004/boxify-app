import 'package:boxify/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()){
    filteredNotifications = List.from(notifications);
  }

  static NotificationCubit get(context) => BlocProvider.of(context);

  final List<String> filters = ["All", "Read", "Unread"];
  String selectedFilter = "All";

  List<NotificationModel> filteredNotifications = [];

  Future<void> checkPermission(
    Permission permission,
    BuildContext context,
  ) async {
    PermissionStatus status = await permission.request();

    if (status.isGranted) {
      emit(NotificationPermissionGranted());
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      emit(NotificationPermissionDeniedPermanently());
    } else {
      emit(NotificationPermissionDenied());
    }
  }

  Future<void> checkCurrentStatus(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) {
      emit(NotificationPermissionGranted());
    } else {
      emit(NotificationPermissionDenied());
    }
  }

  List<NotificationModel> notifications = [
    NotificationModel(
      message: "Someone liked your comment.",
      timestamp: DateTime.now(),
      isRead: false,
    ),
    NotificationModel(
      message: "Your review can help improve Urban Box Cricket.Please share your suggestions and feedback.",
      timestamp: DateTime.now().subtract(Duration(minutes: 12)),
      isRead: false,
    ),
    NotificationModel(
      message: "New comment on your review.",
      timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      isRead: true,
    ),
    NotificationModel(
      message: "Your review can help improve Urban Box Cricket.",
      timestamp: DateTime.now().subtract(Duration(minutes: 25)),
      isRead: true,
    ),
    NotificationModel(
      message: "New comment on your review.",
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      isRead: true,
    ),
    NotificationModel(
      message: "Someone liked your comment.",
      timestamp: DateTime.now().subtract(Duration(minutes: 55)),
      isRead: true,
    ),
  ];

  void filterNotifications(String filterType) {
    selectedFilter = filterType;

    if (filterType == "Read") {
      filteredNotifications  = notifications.where((n) => n.isRead).toList();
    } else if (filterType == "Unread") {
      filteredNotifications  = notifications.where((n) => !n.isRead).toList();
    } else {
      filteredNotifications  = List.from(notifications);
    }

    emit(NotificationList(filteredNotifications ));
  }

  String showTime(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hr ago";
    return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
  }
}
