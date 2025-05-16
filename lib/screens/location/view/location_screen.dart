import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/location/cubit/location_screen_cubit.dart';
import 'package:boxify/screens/location/cubit/location_screen_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/string.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag1,
      child: BlocProvider(
        create: (context) => LocationCubit()..showSuggestions(),
        child: BlocConsumer<LocationCubit, LocationState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            var locCubit = LocationCubit.get(context);
            return Scaffold(
              backgroundColor: Color(0xFFF3F4F8),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70.h, left: 25.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          crossIcon,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: CustomText(
                        data: loc,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: SizedBox(
                        height: 50.h,
                        width: 340.w,
                        child: SearchBar(
                          controller: locCubit.searchController,
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              locCubit.addSearch(value);
                              locCubit.searchController.clear();
                            }
                          },
                          hintText: searchHint,
                          hintStyle: WidgetStatePropertyAll(
                            TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: [SvgPicture.asset(searchIcon)],
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xFFFFFFFF),
                          ),
                          elevation: WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Image.asset(
                              navigationIcon,
                              height: 16.h,
                              width: 16.w,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            data: locText,
                            fontSize: 12,
                            color: Color(0xFF0E7AFF),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoaded) {
                          return Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Column(
                              children:
                                  state.suggestions
                                      .map(
                                        (suggestion) => Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 5.h,
                                          ),
                                          child: SizedBox(
                                            width: 340.w,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  locationIcon,
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                                SizedBox(width: 5.w),
                                                GestureDetector(
                                                  onTap:
                                                      () => Navigator.pop(
                                                        context,
                                                      ),
                                                  child: CustomText(
                                                    data: suggestion,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    locCubit.removeSuggestion(
                                                      suggestion,
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    crossIcon,
                                                    height: 10.h,
                                                    width: 10.w,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
