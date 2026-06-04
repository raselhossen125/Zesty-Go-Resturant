import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui_models/profile_model.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String restaurantId = 'C8ESI8GgEOLG2jMYcuET';

  Stream<ProfileModel> getProfileStream() {
    return _firestore
        .collection('restaurants')
        .doc(restaurantId)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            return ProfileModel.fromMap(snapshot.data()!);
          }

          return ProfileModel(
            name: 'Zesty Go',
            phone: '',
            email: '',
            location: '',
            imageUrl: '',
            orderCount: 0,
          );
        });
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    required String location,
    required String imageUrl,
  }) async {
    await _firestore.collection('restaurants').doc(restaurantId).update({
      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
      'imageUrl': imageUrl,
    });
  }
}
