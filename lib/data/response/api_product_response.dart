class ApiProductRatingResponse {
  final double rate;
  final int count;

  ApiProductRatingResponse({required this.rate, required this.count});

  factory ApiProductRatingResponse.fromJson(Map<String, dynamic> json) {
    return ApiProductRatingResponse(
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}

class ApiProductResponse {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ApiProductRatingResponse rating;

  ApiProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ApiProductResponse.fromJson(Map<String, dynamic> json) {
    final ratingRaw = json['rating'];
    final ratingJson = ratingRaw is Map<String, dynamic>
        ? ratingRaw
        : ratingRaw is num
        ? <String, dynamic>{'rate': ratingRaw, 'count': 0}
        : <String, dynamic>{};

    return ApiProductResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      description: (json['description'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      rating: ApiProductRatingResponse.fromJson(ratingJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}

