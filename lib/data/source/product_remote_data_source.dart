// import 'package:demo_app/data/const/api_endpoint.dart';
// import 'package:demo_app/data/response/api_product_response.dart';
// import 'package:demo_app/data/services/dio/dio_client.dart';
//
// class ProductRemoteDataSource {
//   final DioClient dioClient;
//
//   ProductRemoteDataSource({required this.dioClient});
//
//   Future<List<ApiProductResponse>> getAllProducts() async {
//     final response = await dioClient.get(ApiUrls.productListUrl);
//
//     final data = response.data;
//     if (data is! List) {
//       throw Exception('Invalid server response for product list.');
//     }
//
//     return data
//         .map(
//           (item) => ApiProductResponse.fromJson(
//             Map<String, dynamic>.from(item as Map),
//           ),
//         )
//         .toList();
//   }
//
//   Future<ApiProductResponse> addProduct({required Map<String, dynamic> body}) async {
//     final response = await dioClient.post(ApiUrls.addProductUrl, data: body);
//
//     if (response.data is! Map<String, dynamic>) {
//       throw Exception('Invalid server response for add product.');
//     }
//
//     return ApiProductResponse.fromJson(response.data as Map<String, dynamic>);
//   }
// }
//
//
