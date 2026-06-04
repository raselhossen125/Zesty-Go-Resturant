import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getOrders() async {
    final snapshot = await _firestore.collection('orders').get();

    return snapshot.docs.map((e) {
      return e.data();
    }).toList();
  }
}
