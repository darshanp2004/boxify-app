import 'package:boxify/custom_widgets/card.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/view/booking_venue_screen.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_cubit.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Utils/image_resources.dart';
import '../../../../utils/string.dart';

class SeeAllScreen extends StatefulWidget {
  final String? category;

  const SeeAllScreen({super.key, required this.category});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadCards(),
      child: Scaffold(
        backgroundColor: Color(0XFFF3F4F8),
        appBar: AppBar(
          toolbarHeight: 70.h,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0XFFFFFFFF),
          centerTitle: true,
          title: CustomText(
            data: widget.category ?? "",
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  top: 20.h,
                  bottom: 10.h,
                ),
                child: SizedBox(
                  height: 45.h,
                  width: 340.w,
                  child: SearchBar(
                    hintText: searchHint,
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: Color(0XFF999999),
                        fontSize: 12.sp,
                        fontFamily: andersonGrotesk,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: [SvgPicture.asset(searchIcon)],
                    backgroundColor: WidgetStatePropertyAll(Color(0XFFFFFFFF)),
                    elevation: WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (BuildContext context, HomeState state) {},
                builder: (context, state) {
                  if (state is CardInitial) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CardsLoaded) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.category == cricket) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingVenueScreen(),
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final card =
                                widget.category == cricket
                                    ? state.cricketCard[0]
                                    : widget.category == football
                                    ? state.footballCard[0]
                                    : state.tennisCard[0];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 25.w,
                                right: 25.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              child: SportCard(
                                image: card[image]!,
                                title: card[title]!,
                                price: card[price]!,
                                place: card[place]!,
                                distance: card[distance]!,
                                ratings: card[ratings]!,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  if (state is CardError) {
                    return Center(child: CustomText(data: state.message));
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CategoryList
