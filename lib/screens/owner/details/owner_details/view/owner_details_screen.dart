import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/owner/details/owner_details/cubit/owner_details_cubit.dart';
import 'package:boxify/screens/owner/details/owner_details/cubit/owner_details_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OwnerDetailsScreen extends StatefulWidget {
  final String username;
  final String email;

  const OwnerDetailsScreen({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  State<OwnerDetailsScreen> createState() => _OwnerDetailsScreenState();
}

class _OwnerDetailsScreenState extends State<OwnerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              OwnerDetailsCubit(username: widget.username, email: widget.email),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        body: BlocConsumer<OwnerDetailsCubit, OwnerDetailsState>(
          listener: (BuildContext context, OwnerDetailsState state) {},
          builder: (BuildContext context, OwnerDetailsState state) {
            var ownerDetailsCubit = OwnerDetailsCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: MediaQuery.of(context).size.height / 9,
                ),
                child: Form(
                  key: ownerDetailsCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: personalDetails,
                        fontFamily: koulen,
                        fontSize: 32.sp,
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 150.h,
                              width: 150.w,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFD2D4DA),
                                  width: 3,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  shape: BoxShape.circle,
                                  image:
                                      ownerDetailsCubit.selectedImage != null
                                          ? DecorationImage(
                                            image: FileImage(
                                              ownerDetailsCubit.selectedImage!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                          : null,
                                ),
                                child:
                                    ownerDetailsCubit.selectedImage == null
                                        ? Icon(
                                          Icons.person_outline_rounded,
                                          color: Color(0xFFFFFFFF),
                                          size: 80,
                                        )
                                        : null,
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 97,
                              child: GestureDetector(
                                onTap: () {
                                  imagePickerBottomSheet(
                                    context,
                                    ownerDetailsCubit,
                                  );
                                },
                                child: Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0E7AFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        controller: ownerDetailsCubit.usernameController,
                        hintText: userName,
                        icon: userIcon,
                        validator: ownerDetailsCubit.validateUsername,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: ownerDetailsCubit.emailController,
                        hintText: email,
                        icon: emailIcon,
                        readOnly: true,
                      ),
                      SizedBox(height: 10.h),
                      Theme(
                        data: Theme.of(context).copyWith(
                          dialogTheme: DialogTheme(
                            backgroundColor: Color(0xFFF3F4F8),
                          ),
                        ),
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            hintText: phoneNo,
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF1E1E1E),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12),
                              child: Image.asset(mobileIcon, width: 24.w, height: 24.h),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: Color(0XFFD2D4DA)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: Color(0XFF0E7AFF)),
                            ),
                          ),
                          initialCountryCode: "IN",
                          showCountryFlag: false,
                          validator: ownerDetailsCubit.validateMobileNumber,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: ownerDetailsCubit.businessNameController,
                        hintText: businessName,
                        icon: businessIcon,
                        validator: ownerDetailsCubit.validateBusinessName,
                      ),
                      SizedBox(height: 20.h),
                      CustomElevatedButton(
                        text: saveChanges,
                        backgroundColor: Color(0xFF0E7AFF),
                        textColor: Color(0xFFFFFFFF),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        onPressed: () {
                          ownerDetailsCubit.navigateToCourtDetails(context);
                        },
                      ),
                    ],
                  ),
                ),
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
  OwnerDetailsCubit cubit,
) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
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
      );
    },
  );
}
