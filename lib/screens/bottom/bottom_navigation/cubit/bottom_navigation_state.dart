import 'package:flutter/material.dart';

class BottomNavigationState {
  final int currentIndex;
  final List<Widget> screens;

  BottomNavigationState({required this.currentIndex, required this.screens});

  BottomNavigationState copyWith({
    int? currentIndex,
    List<Widget>? screens,
  }) {
    return BottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      screens: screens ?? this.screens,
    );
  }
}
