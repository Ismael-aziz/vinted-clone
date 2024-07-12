// article.dart
class Article {
  final String title;
  final String size;
  final String oldPrice;
  final String newPrice;
  final String imageUrl;
  final int likes;
  final String seller;
  final double rating;
  final int reviews;
  final bool isNew;

  Article({
    required this.title,
    required this.size,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
    required this.likes,
    required this.seller,
    required this.rating,
    required this.reviews,
    required this.isNew,
  });
}
