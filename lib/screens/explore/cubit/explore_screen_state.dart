import 'package:boxify/models/sport_categories_model.dart';

class ExploreState{}

class ExploreInitial extends ExploreState{}

class CategoriesLoading extends ExploreState{}

class CategoriesLoaded extends ExploreState{
  final List<SportCategory> categories;

  CategoriesLoaded(this.categories);
}