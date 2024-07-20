class Article {
  final String title;
  final String size;
  final int oldPrice;
  final int newPrice;
  final int likes;
  final String seller;
  final int reviews;
  final int rating;
  final List<String> photos; // Nouvelle liste de photos
  final String description; // Nouvelle description
  final String category; // Nouvelle catégorie
  final String brand; // Nouvelle marque
  final String condition;
  final String id; // Nouvel état// Nouvel état

  const Article({
    required this.title,
    required this.size,
    required this.oldPrice,
    required this.newPrice,
    required this.likes,
    required this.seller,
    required this.reviews,
    required this.rating,
    required this.photos, // Initialisation de la liste de photos
    required this.description, // Initialisation de la description
    required this.category, // Initialisation de la catégorie
    required this.brand, // Initialisation de la marque
    required this.condition, required this.id, // Initialisation de l'état
  });
}
