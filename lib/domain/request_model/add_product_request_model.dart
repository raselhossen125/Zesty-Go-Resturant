class AddProductRequestModel {
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final double rating;
  final int ratingCount;

  AddProductRequestModel({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
    this.ratingCount = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
      'rating': {'rate': rating, 'count': ratingCount},
    };
  }
}

