import 'package:boxify/models/sport_categories_model.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'explore_screen_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of(context);

  void loadCategories() async {
    emit(CategoriesLoading());

    await Future.delayed(Duration(seconds: 1));

    final categories = [
      SportCategory(image: cricketImage, labelName: cricket),
      SportCategory(image: tableTennisImage, labelName: tableTennis),
      SportCategory(image: tennisImage, labelName: tennis),
      SportCategory(image: footBallImage, labelName: football),
      SportCategory(image: basketBallImage, labelName: basketBall),
      SportCategory(image: hockeyImage, labelName: hockey),
      SportCategory(image: golfImage, labelName: golf),
      SportCategory(image: badmintonImage, labelName: badminton),
      SportCategory(image: baseBallImage, labelName: baseBall),
    ];
    emit(CategoriesLoaded(categories));
  }


}
