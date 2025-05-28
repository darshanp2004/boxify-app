import 'package:boxify/screens/bottom/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:boxify/screens/bottom/bottom_navigation/cubit/bottom_navigation_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationScreen extends StatefulWidget {

  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
        listener: (BuildContext context, BottomNavigationState state) {  },
        builder: (context, state) {
          var bottomNavigationCubit = BottomNavigationCubit.get(context);
          return Scaffold(
            body: state.screens[state.currentIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: SizedBox(
                height: 100.h,
                child: BottomNavigationBar(
                  currentIndex: state.currentIndex,type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    bottomNavigationCubit.updateIndex(index);
                  },
                  selectedItemColor: Color(0XFF0E7AFF),
                  unselectedItemColor: Color(0XFF999999),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedLabelStyle: TextStyle(
                    fontFamily:lexend,
                    fontWeight: FontWeight.w400,
                    fontSize: 8.sp,
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 0
                              ? Color(0XFF0E7AFF)
                              : Color(0XFF999999),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(homeIcon, width: 25.w),
                      ),
                      label: homeLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 1
                              ? Color(0XFF0E7AFF)
                              : Color(0XFF999999),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(exploreIcon, width: 25.w),
                      ),
                      label: exploreLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 2
                              ? Color(0XFF0E7AFF)
                              : Color(0XFF999999),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(bookingIcon, width: 25.w),
                      ),
                      label: bookingLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          state.currentIndex == 3
                              ? Color(0XFF0E7AFF)
                              : Color(0XFF999999),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(profileIcon, width: 20.w),
                      ),
                      label: profileLabel,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
