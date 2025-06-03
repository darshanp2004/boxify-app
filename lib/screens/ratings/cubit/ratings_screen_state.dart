
import 'package:boxify/models/ratings_model.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoaded extends RatingState {
  final List<RatingModel> ratings;

  RatingLoaded(this.ratings);
}
