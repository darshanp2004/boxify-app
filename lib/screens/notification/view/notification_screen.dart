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
          final showDialog = state is! NotificationPermissionGranted;
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
                        : Center(
                          child: Container(
                            height: 60.h,
                            width: 342.w,
                            decoration: BoxDecoration(
                              color: Color(0xFF0E7AFF),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 3.w),
                                Container(
                                  width: 337.w,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.r),
                                      bottomLeft: Radius.circular(4.r),
                                      topRight: Radius.circular(6.r),
                                      bottomRight: Radius.circular(6.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
