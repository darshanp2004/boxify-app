import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/auth/sign_in/view/signin_screen.dart';
import 'package:boxify/screens/owner/details/court_details/cubit/court_details_cubit.dart';
import 'package:boxify/screens/owner/details/court_details/cubit/court_details_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/image_resources.dart';

class CourtDetailsScreen extends StatefulWidget {
  const CourtDetailsScreen({super.key});

  @override
  State<CourtDetailsScreen> createState() => _CourtDetailsScreenState();
}

class _CourtDetailsScreenState extends State<CourtDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourtDetailsCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        body: BlocConsumer<CourtDetailsCubit, CourtDetailsState>(
          listener: (BuildContext context, CourtDetailsState state) {},
          builder: (BuildContext context, CourtDetailsState state) {
            var courtDetailsCubit = CourtDetailsCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: MediaQuery
                      .of(context)
                      .size
                      .height / 9,
                ),
                child: Form(
                  key: courtDetailsCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: courtDetails,
                        fontFamily: koulen,
                        fontSize: 32.sp,
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        data: addCourtDetails,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(3, (index) {
                              final imageFile = courtDetailsCubit
                                  .selectedImages[index];
                              return GestureDetector(
                                onTap: () {
                                  courtImagePickerBottomSheet(context,courtDetailsCubit,index);
                                },
                                child: Container(
                                  height: double.infinity,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: imageFile != null
                                        ? DecorationImage(
                                      image: FileImage(imageFile),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: imageFile == null
                                      ? Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Color(0xFFF1F1F1),
                                  )
                                      : null,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        controller: courtDetailsCubit.turfNameController,
                        hintText: turfName,
                        icon: turfIcon,
                        validator: courtDetailsCubit.validateTurfName,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: courtDetailsCubit.courtNameController,
                        hintText: courtName,
                        icon: courtNameIcon,
                        validator: courtDetailsCubit.validateCourtName,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: courtDetailsCubit.addressController,
                        hintText: addressText,
                        icon: addressIcon,
                        validator: courtDetailsCubit.validateAddress,
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 110.h,
                        child: TextFormField(
                          maxLines: 10,
                          validator: courtDetailsCubit.validateDescription,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: description,
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: andersonGrotesk,
                              color: Color(0xFF1E1E1E),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: 10.h,
                              left: 15.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: Color(0XFFD2D4DA)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: Color(0XFF0E7AFF)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomElevatedButton(
                        text: saveChanges,
                        backgroundColor: Color(0xFF0E7AFF),
                        textColor: Color(0xFFFFFFFF),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        onPressed: () async {
                          SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                          await preferences.clear();
                          courtDetailsCubit.validateInputs(context);
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



// courtImagePickerBottomSheet

Future<void> courtImagePickerBottomSheet(
    BuildContext context,
    CourtDetailsCubit cubit,
    int index,
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
                      Navigator.pop(context);
                      cubit.pickImageFromCamera(index);
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
                      Navigator.pop(context);
                      cubit.pickImageFromGallery(index);
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
