import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/ratings/cubit/ratings_screen_cubit.dart';
import 'package:boxify/screens/ratings/cubit/ratings_screen_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/image_resources.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingCubit()..loadRatings(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: appBar(context),
        body: BlocConsumer<RatingCubit, RatingState>(
          listener: (BuildContext context, RatingState state) {},
          builder: (BuildContext context, RatingState state) {
            if (state is RatingLoaded) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 40.h),
                itemCount: state.ratings.length,
                itemBuilder: (context, index) {
                  final rating = state.ratings[index];
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 20.h,
                      left: 25.w,
                      right: 25.w,
                    ),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40.h,
                              width: 40.w,
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD2D4DA),),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(child: Image.asset(rating.image,fit: BoxFit.cover,))
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  data: rating.name,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E1E1E),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (i) {
                                        return Icon(
                                          i < rating.rating
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded,
                                          size: 16.sp,
                                          color: Color(0xFF0E7AFF),
                                        );
                                      }),
                                    ),
                                    SizedBox(width: 10.w),
                                    Transform.translate(
                                      offset: Offset(0, 1),
                                      child: CustomText(
                                        data: "• ${rating.date}",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        CustomText(
                          data: '“${rating.comment}”',
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

//Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Color(0xFFF3F4F8),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.transparent,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Transform.scale(
          scale: 0.35,
          child: Image.asset(leftArrowIcon, height: 24.h, width: 24.w),
        ),
      ),
    ),
    title: CustomText(
      data: rating,
      fontWeight: FontWeight.w800,
      fontSize: 18.sp,
    ),
  );
}
