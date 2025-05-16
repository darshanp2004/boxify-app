import 'package:boxify/models/booking_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/image_resources.dart';
import 'bookingscreen_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState(selectedIndex: 0));

  static BookingCubit get(context) => BlocProvider.of(context);

  late TabController? tabController;

  final List<CardModel> cards = [
    CardModel(
      title: "Urban Box Cricket",
      image: boxCricket,
      date: "Saturday, 3rd February",
      time: "12:30 pm to 02:30 pm",
    ),
  ];

  void onTabSelected(int index) {
    emit(BookingState(selectedIndex: index));
  }

  void initController(TickerProvider vsync) {
    tabController = TabController(length: 3, vsync: vsync);
    tabController!.addListener(() {
      if (!tabController!.indexIsChanging) {
        emit(BookingState(selectedIndex: tabController!.index));
      }
    });
  }
}
