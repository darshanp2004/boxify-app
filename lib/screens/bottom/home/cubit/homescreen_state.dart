abstract class HomeState {}

class CardInitial extends HomeState {}

class CardsLoaded extends HomeState {
  final List<Map<String, String>> cricketCard;
  final List<Map<String, String>> footballCard;
  final List<Map<String, String>> tennisCard;
  final String selectedCategory;


  CardsLoaded(this.cricketCard, this.footballCard, this.tennisCard,{this.selectedCategory="Cricket"});

  CardsLoaded copyWith({String? selectedCategory}) {
    return CardsLoaded(
      cricketCard,
      footballCard,
      tennisCard,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class CardError extends HomeState {
  final String message;
  CardError(this.message);
}
