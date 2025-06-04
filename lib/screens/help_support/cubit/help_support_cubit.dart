import 'package:boxify/models/faq_model.dart';
import 'package:boxify/screens/help_support/cubit/help_support_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HelpAndSupportCubit extends Cubit<HelpAndSupportState> {
  HelpAndSupportCubit() : super(HelpSupportInitial()){
    expandedList = List<bool>.filled(faqData.length, false);
    emit(FaqToggleState(expandedList));
  }

  static HelpAndSupportCubit get(context) => BlocProvider.of(context);

  final List<FAQModel> faqData = [
    FAQModel(
      question: "How do I book a court?",
      answer: "You can book a court by selecting the date and time slot in the app.",
    ),
    FAQModel(
      question: "What payment methods are accepted?",
      answer: "We accept credit cards, debit cards, and digital wallets.",
    ),
    FAQModel(
      question: "Can I cancel my booking?",
      answer: "Yes, you can cancel up to 24 hours before the booking time.",
    ),
    FAQModel(
      question: "How do I contact support?",
      answer: "Use the live chat or call support options in the Help & Support screen.",
    ),
    FAQModel(
      question: "Can I change my booking after confirmation?",
      answer: "Yes, changes can be made from the 'My Bookings' section if done 12 hours prior.",
    ),
    // FAQModel(
    //   question: "Do I need to create an account to book?",
    //   answer: "Yes, an account is required to manage your bookings and payments.",
    // ),
    // FAQModel(
    //   question: "Are there any cancellation charges?",
    //   answer: "No cancellation charges if canceled at least 24 hours in advance.",
    // ),
  ];

  late List<bool> expandedList;

  void toggleExpanded(int index) {
    expandedList[index] = !expandedList[index];
    emit(FaqToggleState(List.from(expandedList)));
  }
}
