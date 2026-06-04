import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/dio/base/api_response.dart';

class MenuRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

  Future<ApiResponse> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();

      return ApiResponse.withSuccess(snapshot);
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> addCategory(Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .add(data);

      return ApiResponse.withSuccess("Category added");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .update(data);

      return ApiResponse.withSuccess("Category updated");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> deleteCategory(String categoryId) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .delete();

      return ApiResponse.withSuccess("Category deleted");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> addFoodItem(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('foods')
          .add(data);

      return ApiResponse.withSuccess("Food item added");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> updateFoodItem(
    String categoryId,
    String foodId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('foods')
          .doc(foodId)
          .update(data);

      return ApiResponse.withSuccess("Food item updated");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> deleteFoodItem(String categoryId, String foodId) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('foods')
          .doc(foodId)
          .delete();

      return ApiResponse.withSuccess("Food item deleted");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }
}
