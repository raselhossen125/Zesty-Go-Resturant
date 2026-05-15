import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String? id;
  final String? foodName;
  final String? foodImage;
  final String? description;
  final double? price;
  final double? rating;
  final bool isPopular;
  final Timestamp? createdAt;

  FoodModel({
    this.id,
    this.foodName,
    this.foodImage,
    this.description,
    this.price,
    this.rating,
    this.isPopular = false,
    this.createdAt,
  });

  factory FoodModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return FoodModel(
      id: doc.id,
      foodName: data['foodName'] ?? '',
      foodImage: data['foodImage'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      isPopular: data['isPopular'] ?? false,
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'foodImage': foodImage,
      'description': description,
      'price': price,
      'rating': rating,
      'isPopular': isPopular,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
