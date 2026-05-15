import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/dio/base/api_response.dart';

class MenuRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

  Future<ApiResponse> getCategories() async {
    try {
      final querySnapshot = await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();
      return ApiResponse.withSuccess(querySnapshot);
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> addCategory(Map<String, dynamic> categoryData) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .add(categoryData);
      return ApiResponse.withSuccess("Category Added");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> updateCategory(
    String categoryId,
    Map<String, dynamic> categoryData,
  ) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .update(categoryData);
      return ApiResponse.withSuccess("Category Updated");
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
      return ApiResponse.withSuccess("Category Deleted");
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }
}
