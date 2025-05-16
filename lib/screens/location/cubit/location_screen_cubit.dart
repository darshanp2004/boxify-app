import 'package:boxify/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_screen_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  static LocationCubit get(context) => BlocProvider.of(context);

  List<String> suggestions = [];
  List<String> initialSuggestions = [place, place, place, place];
  final TextEditingController searchController = TextEditingController();

  Future<void> showSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    suggestions = prefs.getStringList(searchKey) ?? initialSuggestions;
    emit(LocationLoaded(suggestions));
  }

  Future<void> removeSuggestion(String suggestion) async {
    suggestions.remove(suggestion);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(searchKey, suggestions);
    emit(LocationLoaded(suggestions));
  }

  void addSearch(String searchText) async {
    final prefs = await SharedPreferences.getInstance();
    suggestions = prefs.getStringList(searchKey) ?? [];
    suggestions.insert(0, searchText);
    if (suggestions.length > 4) {
      suggestions = suggestions.sublist(0, 4);
    }
    await prefs.setStringList(searchKey, suggestions);
    emit(LocationLoaded(suggestions));
  }
}
