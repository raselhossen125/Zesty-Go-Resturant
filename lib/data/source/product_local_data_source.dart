// import 'dart:convert';
//
// import 'package:demo_app/data/services/sharedprefarance/local_storage.dart';
// import 'package:demo_app/domain/ui_models/product_ui_model.dart';
//
// class ProductLocalDataSource {
//   final LocalStorageServices localStorageServices;
//
//   ProductLocalDataSource({required this.localStorageServices});
//
//   Future<List<ProductUiModel>> getLocalProducts({required String key}) async {
//     final rawValue = await localStorageServices.getLocalData(key: key);
//     if (rawValue.isEmpty) return [];
//
//     final decoded = jsonDecode(rawValue);
//     if (decoded is! List) return [];
//
//     return decoded
//         .map(
//           (item) => ProductUiModel.fromJson(
//             Map<String, dynamic>.from(item as Map),
//           ),
//         )
//         .toList();
//   }
//
//   Future<void> saveLocalProducts({
//     required String key,
//     required List<ProductUiModel> products,
//   }) async {
//     final value = jsonEncode(products.map((item) => item.toJson()).toList());
//     await localStorageServices.saveLocalData(key: key, value: value);
//   }
// }
//
