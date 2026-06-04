import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/dio/base/api_response.dart';

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

  Future<ApiResponse> validateCredentials(
    String inputEmail,
    String inputPassword,
  ) async {
    try {
      final doc = await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .get();

      if (!doc.exists || doc.data() == null) {
        return ApiResponse.withError("Restaurant account not found.");
      }

      final data = doc.data() as Map<String, dynamic>;

      final dbEmail = (data['authEmail'] ?? '').toString().trim();
      final dbPassword = (data['authPassword'] ?? '').toString();

      if (dbEmail == inputEmail.trim() && dbPassword == inputPassword) {
        return ApiResponse.withSuccess(true);
      } else {
        return ApiResponse.withError("Invalid email or password.");
      }
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }
}
