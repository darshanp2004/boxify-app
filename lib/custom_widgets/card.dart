import 'dart:ui';

import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/utils/string.dart';
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
  final bool? bookable;

  const SportCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.place,
    required this.distance,
    required this.ratings,
    this.bookable,
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
              if (bookable != null)
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: bookable! ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CustomText(
                      data: bookable! ? bookAble : occupied,
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  color: Color(0xF2FFFFFF),
                  padding: EdgeInsets.only(top: 15.h, left: 10.h, right: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            data: title,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          Spacer(),
                          CustomText(
                            data: price,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          CustomText(
                            data: "$place  • $distance",
                            fontSize: 9.sp,
                          ),
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0, -2),
                            child: Icon(Icons.star_border_rounded, size: 15.sp),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(data: ratings, fontSize: 9.sp),
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
