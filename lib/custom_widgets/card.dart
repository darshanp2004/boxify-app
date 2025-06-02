import 'dart:ui';

import 'package:boxify/custom_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/image_resources.dart';

class SportCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String place;
  final String distance;
  final String ratings;

  const SportCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.place,
    required this.distance,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      height: 200.h,
      width: 320.w,
      child: Padding(
        padding: EdgeInsets.all(7.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                  color: Color(0xF2FFFFFF),
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            data: title,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          Spacer(),
                          CustomText(
                            data: price,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          CustomText(
                            data: "$place  • $distance",
                            fontSize: 12.sp,
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: SvgPicture.asset(
                              starIcon,
                              height: 13.h,
                              width: 10.w,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            data: ratings,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
