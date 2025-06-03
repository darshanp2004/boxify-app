import 'dart:ui';

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
                        top: 140.h,
                        left: MediaQuery.of(context).size.width / 3 - 10.w,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD2D4DA),
                          ),
                          child: Center(
                            child: Container(
                              height: 144.h,
                              width: 144.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Center(
                                child: Container(
                                  height: 135.h,
                                  width: 135.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          state.image != null
                                              ? FileImage(state.image!)
                                                  as ImageProvider
                                              : AssetImage(profileImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.h, left: 20.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            leftArrowIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 55.h, right: 140.w),
                        child: Center(
                          child: CustomText(
                            data: editProfile,
                            fontWeight: FontWeight.w800,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 90.w, top: 35.h),
                    child: GestureDetector(
                      onTap: () {
                        imagePickerBottomSheet(context, editProfileCubit);
                      },
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF0E7AFF),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFFFFFFF),
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Color(0xFFFFFFFF),
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: CustomTextField(
                      controller: editProfileCubit.usernameController,
                      hintText: userName,
                      icon: userIcon,
                      fillColor: Color(0xFFFFFFFF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: CustomTextField(
                      controller: editProfileCubit.emailController,
                      hintText: email,
                      icon: emailIcon,
                      fillColor: Color(0xFFFFFFFF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Color(0xFFFFFFFF),
                            border: Border.all(color: Color(0xFFD2D4DA)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w, top: 5.h),
                            child: DropdownButton<String>(
                              value:
                                  (state.gender.isNotEmpty)
                                      ? state.gender
                                      : null,
                              hint: CustomText(
                                data: gender,
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5.h,
                                  right: 10.w,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                  color: Color(0xFFB3B5BD),
                                ),
                              ),
                              isExpanded: true,
                              underline: SizedBox(),
                              dropdownColor: Colors.white,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  editProfileCubit.updateGender(newValue);
                                }
                              },
                              items:
                                  editProfileCubit.genderOptions
                                      .map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: CustomText(
                                            data: value,
                                            fontSize: 12.sp,
                                          ),
                                        );
                                      })
                                      .toList(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Color(0xFFFFFFFF),
                            border: Border.all(color: Color(0xFFD2D4DA)),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, top: 5.h),
                                child: CustomText(
                                  data:
                                      state.birthDate != null
                                          ? '${state.birthDate?.day}/${state.birthDate?.month}/${state.birthDate?.year}'
                                          : birthDate,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                  if (pickedDate != null) {
                                    editProfileCubit.updateBirthDate(
                                      pickedDate,
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                  color: Color(0xFFB3B5BD),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 329.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFF0E7AFF),
                      ),
                      child: Center(
                        child: CustomText(
                          data: saveChanges,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: Color(0xFFF3F4F8),
                        ),
                      ),
                    ),
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

// ImagePickerBottomSheet

Future<void> imagePickerBottomSheet(
  BuildContext context,
  EditProfileCubit cubit,
) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      iconSize: 50,
                      color: Color(0xFFD9D9D9),
                      onPressed: () {
                        cubit.pickImageFromCamera(context);
                      },
                    ),
                    CustomText(data: camera, fontSize: 12.sp),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.photo),
                      iconSize: 50,
                      color: Color(0xFFD9D9D9),
                      onPressed: () {
                        cubit.pickImageFromGallery(context);
                      },
                    ),
                    CustomText(data: gallery, fontSize: 12.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
