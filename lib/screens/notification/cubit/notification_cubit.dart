import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

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
}
