import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'direction_screen_state.dart';

class DirectionCubit extends Cubit<DirectionState> {
  DirectionCubit() : super(DirectionInitial());

  static DirectionCubit get(context) => BlocProvider.of(context);
  double latitude = 23.0225;
  double longitude = 72.5714;

  Future<void> loadDirections() async {
    emit(DirectionLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(DirectionLoaded());
  }

  Future<void> openGoogleMaps() async {
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    }
  }
}
