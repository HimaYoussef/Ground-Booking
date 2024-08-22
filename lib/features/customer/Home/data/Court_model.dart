class Court {
  final String name;
  final String imageUrl;
  final String category;
  final int rate;
  final int rate_num;
  final String id;
  final String description;
  final String StartHour;
  final String EndHour;
  final String price;

  Court(
     {
    required this.name,
     required this.rate_num,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rate,
    required this.id,
    required this.description,
    required this.StartHour,
    required this.EndHour,
  });
}
