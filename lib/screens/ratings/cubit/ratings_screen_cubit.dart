import 'package:boxify/models/ratings_model.dart';
import 'package:boxify/screens/ratings/cubit/ratings_screen_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  static RatingCubit get(context) => BlocProvider.of(context);

  void loadRatings() {
    final ratings = [
      RatingModel(
        image: user1,
        name: "Raj Patel",
        rating: 3,
        date: "2 days ago",
        comment:
            "Excellent turf quality! The surface is well-maintained and provides great grip. Perfect for football matches. The lighting is also very good for evening games.",
      ),
      RatingModel(
        image: user2,
        name: "Ashwi",
        rating: 4,
        date: "3 day ago",
        comment:
            "Amazing experience! The court was clean, staff was helpful, and booking was super easy. Will visit again.",
      ),
    ];

    emit(RatingLoaded(ratings));
  }
}
