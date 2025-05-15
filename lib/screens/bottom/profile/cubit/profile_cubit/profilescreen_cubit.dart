import 'package:boxify/screens/bottom/profile/cubit/profile_cubit/profilescreen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(ProfileState(
    locationEnabled: false,
    notificationsEnabled: true,
  ));

  void toggleLocation(bool value) {
    emit(state.copyWith(locationEnabled: value));
  }

  void toggleNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }
}