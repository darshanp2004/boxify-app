import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/auth/sign_in/view/signin_screen.dart';
import 'package:boxify/screens/bottom/profile/cubit/profile_cubit/profilescreen_cubit.dart';
import 'package:boxify/screens/bottom/profile/cubit/profile_cubit/profilescreen_state.dart';
import 'package:boxify/screens/password/change_password/view/change_password_screen.dart';
import 'package:boxify/screens/bottom/profile/view/edit_profile_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:boxify/utils/image_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (BuildContext context, ProfileState state) {},
            builder: (context, state) {
              var profileCubit = ProfileCubit.get(context);
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    ListTile(
                      iconPath: locationIcon,
                      title: location,
                      iconHeight: 22,
                      iconWidth: 22,
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: state.locationEnabled,
                          trackColor: WidgetStateProperty.all(
                            state.locationEnabled ? Colors.blue : Colors.white,
                          ),
                          onChanged: (value) {
                            profileCubit.toggleLocation(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ListTile(
                      iconPath: notificationIcon,
                      title: notification,
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: state.notificationsEnabled,
                          trackColor: WidgetStateProperty.all(
                            state.notificationsEnabled
                                ? Colors.blue
                                : Colors.white,
                          ),
                          onChanged: (value) {
                            profileCubit.toggleNotifications(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Divider(),
                    SizedBox(height: 15.h),
                    ListTile(
                      iconPath: inviteFriendsIcon,
                      title: friendInvite,
                      trailing: Image.asset(
                        rightArrowIcon,
                        height: 20.h,
                        width: 10.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ListTile(
                      iconPath: helpSupportIcon,
                      title: helpAndSupport,
                      trailing: Image.asset(
                        rightArrowIcon,
                        height: 20.h,
                        width: 10.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ListTile(
                      iconPath: privacyIcon,
                      title: privacy,
                      trailing: Image.asset(
                        rightArrowIcon,
                        height: 20.h,
                        width: 10.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        iconPath: lockIcon,
                        title: changePassword,
                        iconHeight: 20,
                        iconWidth: 20,
                        trailing: Image.asset(
                          rightArrowIcon,
                          height: 20.h,
                          width: 10.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Divider(),
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                          (route) => false,
                        );
                      },
                      child: ListTile(iconPath: logoutIcon, title: logout),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final double iconHeight;
  final double iconWidth;
  final String title;
  final Widget? trailing;

  const ListTile({
    super.key,
    required this.iconPath,
    this.iconColor = const Color(0xFF0E7AFF),
    this.iconHeight = 18,
    this.iconWidth = 18,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Container(
            height: 34.h,
            width: 34.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Color(0xFFF3F4F8),
            ),
            child: Center(
              widthFactor: 15,
              heightFactor: 15,
              child: Image.asset(
                iconPath,
                color: Color(0xFF0E7AFF),
                height: iconHeight.h,
                width: iconWidth.w,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          CustomText(
            data: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xFF636363),
          ),
          Spacer(),
          if (trailing != null)
            Padding(padding: EdgeInsets.only(right: 15.w), child: trailing!),
        ],
      ),
    );
  }
}

// AppBar

AppBar appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xFFFFFFFF),
    toolbarHeight: 100.h,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
    ),
    title: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Container(
            height: 50.h,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFD2D4DA)),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(profileImage, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: name,
              fontWeight: FontWeight.w800,
              fontSize: 15.sp,
            ),
            SizedBox(height: 2.h),
            CustomText(data: city, fontSize: 10.sp),
          ],
        ),
        SizedBox(width: 120.w),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
          },
          child: Image.asset(editIcon, height: 25.h, width: 25.w),
        ),
      ],
    ),
  );
}
