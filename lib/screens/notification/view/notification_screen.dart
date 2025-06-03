import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/notification/cubit/notification_cubit.dart';
import 'package:boxify/screens/notification/cubit/notification_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/image_resources.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NotificationCubit()..checkCurrentStatus(Permission.notification),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (BuildContext context, NotificationState state) {},
        builder: (BuildContext context, NotificationState state) {
          var notificationCubit = NotificationCubit.get(context);
          final showDialog =
              state is NotificationPermissionDenied ||
              state is NotificationPermissionDeniedPermanently;
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context),
            body: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
                    showDialog
                        ? notificationContainer(context, notificationCubit)
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            filterButton(notificationCubit),
                            Expanded(
                              child: notificationList(notificationCubit),
                            ),
                          ],
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFFFFFFFF),
    toolbarHeight: 70.h,
    surfaceTintColor: Color(0xFFFFFFFF),
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Transform.scale(
          scale: 0.35,
          child: Image.asset(leftArrowIcon, height: 24.h, width: 24.w),
        ),
      ),
    ),
    title: CustomText(
      data: notification,
      fontSize: 15.sp,
      fontWeight: FontWeight.w800,
    ),
  );
}

// NotificationContainer

Widget notificationContainer(BuildContext context, NotificationCubit cubit) {
  return Container(
    height: 147.h,
    width: 340.w,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xFFD2D4DA)),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Padding(
      padding: EdgeInsets.all(15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data: enableNotification,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 6.h),
          CustomText(
            data: missingUpdates,
            fontSize: 12.sp,
            color: Color(0xFF999999),
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.h,
                  width: 145.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Color(0xFF0E7AFF)),
                  ),
                  child: Center(
                    child: CustomText(
                      data: noThanks,
                      color: Color(0xFF0E7AFF),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  cubit.checkPermission(Permission.notification, context);
                },
                child: Container(
                  height: 40.h,
                  width: 145.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF0E7AFF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: CustomText(
                      data: enable,
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

//  NotificationList

Widget notificationList(NotificationCubit cubit) {
  return ListView.builder(
    itemCount: cubit.filteredNotifications.length,
    itemBuilder: (context, index) {
      final notification = cubit.filteredNotifications[index];
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          decoration: BoxDecoration(
            color: notification.isRead ? Color(0xFFBFC2C8) : Color(0xFF0E7AFF),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 3.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.r),
                      bottomLeft: Radius.circular(4.r),
                      topRight: Radius.circular(6.r),
                      bottomRight: Radius.circular(6.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              calenderIcon,
                              height: 10.h,
                              width: 10.w,
                            ),
                            SizedBox(width: 8.w),
                            Transform.translate(
                            offset: Offset(0, 1),
                              child: CustomText(
                                data: cubit.showTime(notification.timestamp),
                                fontSize: 8.sp,
                              ),
                            ),
                            Spacer(),
                            if (!notification.isRead)
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Container(
                                  height: 6.h,
                                  width: 6.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0E7AFF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          data: notification.message,
                          fontSize: 10.sp,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// FilterButton

Widget filterButton(NotificationCubit cubit) {
  return Row(
    children: List.generate(cubit.filters.length, (index) {
      final filter = cubit.filters[index];
      final isSelected = (filter == cubit.selectedFilter);
      return GestureDetector(
        onTap: () {
          cubit.filterNotifications(filter);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, top: 25.h, bottom: 25.h),
          child: Container(
            height: 35.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected ? Color(0xFF0E7AFF) : Color(0xFFBFC2C8),
              ),
            ),
            child: Center(
              child: CustomText(
                data: filter,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
      );
    }),
  );
}
