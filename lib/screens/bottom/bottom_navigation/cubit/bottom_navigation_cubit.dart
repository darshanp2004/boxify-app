import 'package:boxify/screens/bottom/explore/view/explore_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../booking/view/booking_screen.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import 'bottom_navigation_state.dart';


class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(
    BottomNavigationState(
      currentIndex: 0,
      screens: [
        HomeScreen(),
        ExploreScreen(),
        BookingScreen(),
        ProfileScreen(),
      ],
    ),
  );
  static BottomNavigationCubit get(context) => BlocProvider.of(context);

  void updateIndex(int newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }
}
