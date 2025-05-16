import 'package:bloc/bloc.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'homescreen_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(CardInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  void loadCards() {
    List<Map<String, String>> cricketCard = [
      {
        "title": "Urban Box Cricket",
        "image": boxCricket,
        "place":"Sindhu Bhavan Marg",
        "distance":"1.6 km away",
        "price":"₹1200/hr",
        "ratings":"4.3 (25)"
      }
    ];

    List<Map<String, String>> footballCard= [
      {
        "title": "Urban Football",
        "image": footballGround,
        "place":"Sindhu Bhavan Marg",
        "distance":"1.6 km away",
        "price":"₹1200/hr",
        "ratings":"4.3 (25)"
      }
    ];

    List<Map<String, String>> tennisCard= [
      {
        "title": "Urban Tennis",
        "image": tennisGround,
        "place":"Sindhu Bhavan Marg",
        "distance":"1.6 km away",
        "price":"₹1200/hr",
        "ratings":"4.3 (25)"
      }
    ];

    emit(CardsLoaded(cricketCard,footballCard,tennisCard));
  }

  void selectCategory(String category) {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      emit(currentState.copyWith(selectedCategory: category));
    }
  }

  Future<void> checkPermission(
      Permission permission,
      BuildContext context,
      ) async {
    PermissionStatus status = await permission.request();
    if (status.isGranted) {
      return;
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return;
    }
  }
}
