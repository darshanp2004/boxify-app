import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/bottom/profile/cubit/edit_profile_cubit/editprofile_screen_cubit.dart';
import 'package:boxify/screens/bottom/profile/cubit/edit_profile_cubit/editprofile_screen_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/image_resources.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (BuildContext context, EditProfileState state) {},
          builder: (context, state) {
            var editProfileCubit = EditProfileCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(40.r),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160.h,
                        left: MediaQuery.of(context).size.width / 2 - 60.w,
                        child: CircleAvatar(
                          radius: 64.r,
                          backgroundColor: Color(0xFFD2D4DA),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFFFFFFF),
                            radius: 62.r,
                            child: CircleAvatar(
                              backgroundImage:
                                  state.image != null
                                      ? FileImage(state.image!)
                                      : AssetImage(profileImage),
                              radius: 60.r,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 45.h),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.h),
                        child: Center(
                          child: CustomText(
                            data: editProfile,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120.w, top: 20.h),
                    child: IconButton(
                      onPressed: () {
                        editProfileCubit.pickImageFromGallery();
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                  SizedBox(height: 80.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: CustomTextField(
                      controller: editProfileCubit.usernameController,
                      hintText: userName,
                      icon: userIcon,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: CustomTextField(
                      controller: editProfileCubit.emailController,
                      hintText: email,
                      icon: emailIcon,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: CustomText(data: saveChanges),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
