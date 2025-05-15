abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final List<String> suggestions;
  LocationLoaded(this.suggestions);
}
