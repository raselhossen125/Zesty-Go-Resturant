// import 'package:flutter/foundation.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
//
// import '../../data/response/api_collection_details_response.dart';
// import '../../data/response/api_collections_response.dart';
// import '../../data/response/api_equipment_details_response.dart';
// import '../../data/response/api_takens_response.dart';
// import '../../data/response/api_view_reservation_response.dart';
// import '../repository/app_reservation_repository.dart';
// import '../request_model/complete_reservation_request_model.dart';
// import '../ui_models/collection_details_ui_model.dart';
// import '../ui_models/collection_ui_model.dart';
// import '../ui_models/equipment_details_ui_model.dart';
// import '../ui_models/taken_ui_model.dart';
// import '../use_case/app_reservation_use_case.dart';
//
// class AppReservationUseCaseImpl implements AppReservationUseCase {
//   final AppReservationRepository appReservationRepository;
//
//   AppReservationUseCaseImpl({required this.appReservationRepository});
//
//   @override
//   Future<List<CollectionUiModel>> getCollections() async {
//     // TODO: implement getCollections
//     try {
//       // Step 1: Call backend API
//       final apiResponse = await appReservationRepository.getCollections();
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error!);
//       }
//
//       // Step 2: Validate and parse API response
//       if (apiResponse.response?.data == null) {
//         throw Exception('Invalid server response for collections.');
//       }
//       final apiCollectionsResponse = ApiCollectionsResponse.fromJson(
//         apiResponse.response!.data,
//       );
//       final collections =
//           apiCollectionsResponse.data
//               ?.map(
//                 (collection) => CollectionUiModel.fromApiResponse(collection),
//               )
//               .toList() ??
//           [];
//       return collections;
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error fetching collections: $e');
//       }
//       throw Exception('Failed to fetch collections: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<List<TakenUiModel>> getTakenList() async {
//     // TODO: implement getTakenList
//     try {
//       // Step 1: Call backend API
//       final apiResponse = await appReservationRepository.getTakenList();
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error!);
//       }
//
//       // Step 2: Validate and parse API response
//       if (apiResponse.response?.data == null) {
//         throw Exception('Invalid server response for taken.');
//       }
//       final apiTakenResponse = ApiTakensResponse.fromJson(
//         apiResponse.response!.data,
//       );
//       final takenList =
//           apiTakenResponse.data
//               ?.map((taken) => TakenUiModel.fromApi(taken))
//               .toList() ??
//           [];
//       return takenList;
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error fetching taken: $e');
//       }
//       throw Exception('Failed to fetch taken: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<CollectionDetailsUiModel> getCollectionDetails({
//     required String collectionId,
//   }) async {
//     try {
//       // Step 1: Call backend API
//       final apiResponse = await appReservationRepository.getCollectionDetails(
//         collectionId: collectionId,
//       );
//
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error!);
//       }
//
//       // Step 2: Validate response
//       if (apiResponse.response?.data == null) {
//         throw Exception('Invalid server response for collection details.');
//       }
//
//       final apiCollectionDetailsResponse =
//           ApiCollectionDetailsResponse.fromJson(apiResponse.response!.data);
//
//       final dataList = apiCollectionDetailsResponse.data;
//
//       if (dataList == null || dataList.isEmpty) {
//         throw Exception('Collection details not found.');
//       }
//
//       // ✅ Return first item only
//       return CollectionDetailsUiModel.fromApiResponse(dataList.first);
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error fetching collection details: $e');
//       }
//       throw Exception('Failed to fetch collection details: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<EquipmentDetailsUiModel> getEquipmentDetails({
//     required String equipmentId,
//   }) async {
//     try {
//       // Step 1: Call backend API
//       final apiResponse = await appReservationRepository.getEquipmentDetails(
//         equipmentId: equipmentId,
//       );
//
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error!);
//       }
//
//       // Step 2: Validate response
//       if (apiResponse.response?.data == null) {
//         throw Exception('Invalid server response for equipment details.');
//       }
//
//       final apiEquipmentDetailsResponse = ApiEquipmentDetailsResponse.fromJson(
//         apiResponse.response!.data,
//       );
//
//       final dataList = apiEquipmentDetailsResponse.data;
//
//       if (dataList == null || dataList.isEmpty) {
//         throw Exception('Equipment details not found.');
//       }
//
//       // ✅ Return first item only
//       return EquipmentDetailsUiModel.fromApiResponse(dataList.first);
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error fetching equipment details: $e');
//       }
//       throw Exception('Failed to fetch equipment details: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<String> completeReservation({
//     required String reservationId,
//     required CompleteReservationRequestModel request,
//   }) async {
//     try {
//       final requestData = request.toJson();
//       if (requestData.isEmpty) {
//         throw Exception('Invalid complete reservation request data.');
//       }
//
//       final apiResponse = await appReservationRepository.completeReservation(
//         reservationId: reservationId,
//         request: requestData,
//       );
//
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error);
//       }
//
//       final responseData = apiResponse.response?.data;
//
//       if (responseData == null) {
//         throw Exception('invalid_server_response_key'.tr);
//       }
//
//       if (responseData['success'] != true) {
//         throw Exception(
//           responseData['message'] ?? 'something_went_wrong_key'.tr,
//         );
//       }
//
//       return responseData['message'] ??
//           "collection_marked_as_completed_successfully_key".tr;
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error complete reservation: $e');
//       }
//
//       // IMPORTANT: Don't wrap again
//       rethrow;
//     }
//   }
//
//   @override
//   Future<bool> viewReservation({required String id}) async {
//     try {
//       // Step 1: Call backend API
//       final apiResponse = await appReservationRepository.viewReservation(
//         id: id,
//       );
//
//       if (apiResponse.error != null) {
//         throw Exception(apiResponse.error!);
//       }
//
//       if (apiResponse.response?.data == null) {
//         throw Exception('Invalid server response for view reservation.');
//       }
//
//       // Step 2: Parse response
//       final apiViewReservationResponse = ApiViewReservationResponse.fromJson(
//         apiResponse.response!.data,
//       );
//
//       // Step 3: Validate data
//       if (apiViewReservationResponse.success != true ||
//           apiViewReservationResponse.data == null) {
//         throw Exception(
//           apiViewReservationResponse.message ??
//               'Reservation view issue is occurring.',
//         );
//       }
//
//       // ✅ If everything is fine
//       return true;
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint('Error viewing reservation: $e');
//       }
//       return false;
//     }
//   }
// }
