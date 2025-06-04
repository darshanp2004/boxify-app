abstract class HelpAndSupportState{}

class HelpSupportInitial extends HelpAndSupportState{}

class FaqToggleState extends HelpAndSupportState {
  final List<bool> expandedList;
  FaqToggleState(this.expandedList);
}