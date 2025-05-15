class CardModel {
  final String title;
  final String image;
  final String date;
  final String time;
  final String? court;

  CardModel({
    required this.title,
    required this.image,
    required this.date,
    required this.time,
    this.court  ,
  });
}
