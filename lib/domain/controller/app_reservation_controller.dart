// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../presentation/common_widget/custom_snackbar.dart';
// import '../../presentation/pages/home/widget/trip_request_dialog_helper.dart';
// import '../request_model/complete_reservation_request_model.dart';
// import '../ui_models/collection_details_ui_model.dart';
// import '../ui_models/collection_ui_model.dart';
// import '../ui_models/equipment_details_ui_model.dart';
// import '../ui_models/taken_ui_model.dart';
// import '../use_case/app_reservation_use_case.dart';
//
// class AppReservationController extends GetxController
//     with WidgetsBindingObserver {
//   final AppReservationUseCase appReservationUseCase;
//
//   AppReservationController({required this.appReservationUseCase});
//
//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }
//
//   bool _wasInBackground = false;
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     if (state == AppLifecycleState.paused) {
//       _wasInBackground = true;
//     }
//
//     if (state == AppLifecycleState.resumed && _wasInBackground) {
//       debugPrint("App returned from background: Calling getCollections...");
//       getCollections(refresh: true, showPendingTrip: true);
//
//       _wasInBackground = false;
//     }
//   }
//
//   /// Collection list
//   List<CollectionUiModel> _collectionList = [];
//   List<CollectionUiModel> get collectionList => _collectionList;
//
//   /// Pending trips list for Dialog
//   List<CollectionUiModel> _pendingTrips = [];
//   List<CollectionUiModel> get pendingTrips => _pendingTrips;
//
//   /// Collection loading flag
//   bool _collectionFetchLoading = false;
//   bool get collectionFetchLoading => _collectionFetchLoading;
//
//   /// Collection error message
//   String? _collectionErrorMessage;
//   String? get collectionErrorMessage => _collectionErrorMessage;
//
//   /// Get collection list
//   Future<void> getCollections({
//     bool refresh = false,
//     bool showPendingTrip = false,
//   }) async {
//     if (_collectionFetchLoading) return; // prevent multiple calls
//     if (_collectionList.isNotEmpty && !refresh) return;
//
//     _collectionFetchLoading = true;
//     _collectionErrorMessage = null;
//     update();
//
//     try {
//       final result = await appReservationUseCase.getCollections();
//
//       _collectionList = result;
//
//       if (showPendingTrip) {
//         // View == "0" Pending trip
//         _pendingTrips = _collectionList
//             .where((item) => item.view == "0")
//             .toList();
//         if (_pendingTrips.isNotEmpty && Get.isDialogOpen != true) {
//           // TripDialogHelper.showTripRequests();
//         }
//       }
//     } catch (e) {
//       _collectionErrorMessage = "failed_to_load_collection_key".tr;
//       debugPrint('Collection fetch error: $e');
//     } finally {
//       _collectionFetchLoading = false;
//       update();
//     }
//   }
//
//   /// Optional: Clear collections
//   void clearCollections() {
//     _collectionList.clear();
//     update();
//   }
//
//   void removeFromPendingTrip({required CollectionUiModel trip}) {
//     _pendingTrips.remove(trip);
//     if (_pendingTrips.isEmpty) {
//       Get.back();
//     }
//
//     update();
//   }
//
//   /// Taken list
//   List<TakenUiModel> _takenList = [];
//   List<TakenUiModel> get takenList => _takenList;
//
//   /// Taken loading flag
//   bool _takenFetchLoading = false;
//   bool get takenFetchLoading => _takenFetchLoading;
//
//   /// Taken error message
//   String? _takenErrorMessage;
//   String? get takenErrorMessage => _takenErrorMessage;
//
//   /// Get taken list
//   Future<void> getTakenList({bool refresh = false}) async {
//     if (_takenFetchLoading) return; // prevent multiple calls
//     if (_takenList.isNotEmpty && !refresh) return;
//
//     _takenFetchLoading = true;
//     _takenErrorMessage = null;
//     update();
//
//     try {
//       final result = await appReservationUseCase.getTakenList();
//
//       _takenList = result;
//     } catch (e) {
//       _takenErrorMessage = "failed_to_load_taken_key".tr;
//       debugPrint('Taken fetch error: $e');
//     } finally {
//       _takenFetchLoading = false;
//       update();
//     }
//   }
//
//   /// Optional: Clear taken
//   void clearTaken() {
//     _takenList.clear();
//     update();
//   }
//
//   /// Collection details
//   CollectionDetailsUiModel? _collectionDetails;
//   CollectionDetailsUiModel? get collectionDetails => _collectionDetails;
//
//   /// Collection details loading flag
//   bool _collectionDetailsFetchLoading = false;
//   bool get collectionDetailsFetchLoading => _collectionDetailsFetchLoading;
//
//   /// Collection details error message
//   String? _collectionDetailsErrorMessage;
//   String? get collectionDetailsErrorMessage => _collectionDetailsErrorMessage;
//
//   /// Get collection details
//   Future<void> getCollectionDetails({
//     required String collectionId,
//     bool refresh = false,
//   }) async {
//     if (_collectionDetailsFetchLoading) return;
//
//     // Prevent refetch if already loaded and not refreshing
//     if (_collectionDetails != null && !refresh) return;
//
//     _collectionDetailsFetchLoading = true;
//     _collectionDetailsErrorMessage = null;
//     update();
//
//     try {
//       final result = await appReservationUseCase.getCollectionDetails(
//         collectionId: collectionId,
//       );
//
//       _collectionDetails = result;
//       viewReservation(id: _collectionDetails!.id.toString());
//     } catch (e) {
//       _collectionDetailsErrorMessage =
//           "failed_to_load_collection_details_key".tr;
//       debugPrint('Collection details fetch error: $e');
//     } finally {
//       _collectionDetailsFetchLoading = false;
//       update();
//     }
//   }
//
//   void clearCollectionDetails() {
//     _collectionDetails = null;
//     update();
//   }
//
//   /// Equipment details
//   EquipmentDetailsUiModel? _equipmentDetails;
//   EquipmentDetailsUiModel? get equipmentDetails => _equipmentDetails;
//
//   /// Equipment details loading flag
//   bool _equipmentDetailsFetchLoading = false;
//   bool get equipmentDetailsFetchLoading => _equipmentDetailsFetchLoading;
//
//   /// Equipment details error message
//   String? _equipmentDetailsErrorMessage;
//   String? get equipmentDetailsErrorMessage => _equipmentDetailsErrorMessage;
//
//   /// Get equipment details
//   Future<void> getEquipmentDetails({
//     required String equipmentId,
//     bool refresh = false,
//   }) async {
//     if (_equipmentDetailsFetchLoading) return;
//
//     // Prevent refetch if already loaded and not refreshing
//     if (_equipmentDetails != null && !refresh) return;
//
//     _equipmentDetailsFetchLoading = true;
//     _equipmentDetailsErrorMessage = null;
//     update();
//
//     try {
//       final result = await appReservationUseCase.getEquipmentDetails(
//         equipmentId: equipmentId,
//       );
//
//       _equipmentDetails = result;
//       viewReservation(id: _equipmentDetails!.id.toString());
//     } catch (e) {
//       _equipmentDetailsErrorMessage = "failed_to_load_equipment_details_key".tr;
//       debugPrint('Equipment details fetch error: $e');
//     } finally {
//       _equipmentDetailsFetchLoading = false;
//       update();
//     }
//   }
//
//   /// Clear equipment details
//   void clearEquipmentDetails() {
//     _equipmentDetails = null;
//     update();
//   }
//
//   /// Complete Reservation loading flag
//   bool _completeReservationLoading = false;
//   bool get completeReservationLoading => _completeReservationLoading;
//
//   /// Update complete reservation loading state and refresh UI
//   void updateCompleteReservationLoading(bool value) {
//     _completeReservationLoading = value;
//     update();
//   }
//
//   /// Reset complete reservation loading state to false
//   void resetCompleteReservationLoading() {
//     updateCompleteReservationLoading(false);
//   }
//
//   /// Complete Reservation Function
//   Future<CompleteReservationResult> completeReservation({
//     required String reservationId,
//     required CompleteReservationRequestModel requestModel,
//   }) async {
//     updateCompleteReservationLoading(true);
//
//     try {
//       final String message = await appReservationUseCase.completeReservation(
//         reservationId: reservationId,
//         request: requestModel,
//       );
//
//       // Get.find<AppProfileController>().getProfileInfo(refresh: true);
//       getCollections(refresh: true);
//
//       // Don't show snackbar here, let UI handle it
//       return CompleteReservationResult(success: true, message: message);
//     } catch (error) {
//       debugPrint("Complete Reservation Error: $error");
//
//       String errorMessage = error is Exception
//           ? error.toString().replaceFirst("Exception: ", "")
//           : error.toString();
//
//       return CompleteReservationResult(success: false, message: errorMessage);
//     } finally {
//       resetCompleteReservationLoading();
//     }
//   }
//
//   /// View Reservation loading flag
//   bool _viewReservationLoading = false;
//   bool get viewReservationLoading => _viewReservationLoading;
//
//   /// Update view reservation loading state and refresh UI
//   void updateViewReservationLoading(bool value) {
//     _viewReservationLoading = value;
//     update();
//   }
//
//   /// Reset view reservation loading state to false
//   void resetViewReservationLoading() {
//     updateViewReservationLoading(false);
//   }
//
//   Future<void> viewReservation({required String id}) async {
//     updateViewReservationLoading(true);
//
//     try {
//       await appReservationUseCase.viewReservation(id: id);
//     } catch (error) {
//       debugPrint("View Reservation Error: $error");
//       String errorMessage = error is Exception
//           ? error.toString().replaceFirst("Exception: ", "")
//           : error.toString();
//
//       showCustomSnackBar(errorMessage, Get.context!, isError: true);
//       rethrow; // Let UI handle error if needed
//     } finally {
//       resetViewReservationLoading();
//     }
//   }
//
//   /// Open UETDS live journey link
//   void openUETDSLink({required String url}) async {
//     try {
//       // // Try to launch externally first
//       // bool launched = await launchUrlString(
//       //   url,
//       //   mode: LaunchMode.externalApplication,
//       // );
//       //
//       // if (!launched) {
//       //   // Fallback: Try in-app browser
//       //   launched = await launchUrlString(url, mode: LaunchMode.inAppWebView);
//       // }
//       //
//       // if (!launched) {
//       //   // Final fallback: show copy dialog
//       //   showCustomSnackBar(
//       //     'could_not_open_uetds_link_key'.tr,
//       //     Get.context!,
//       //     isError: true,
//       //   );
//       // }
//     } on PlatformException catch (e) {
//       debugPrint('UETDS launch platform error: $e');
//       showCustomSnackBar(
//         'something_went_wrong_while_opening_the_link_key'.tr,
//         Get.context!,
//         isError: true,
//       );
//     } catch (e) {
//       debugPrint('UETDS launch error: $e');
//       showCustomSnackBar(
//         'something_went_wrong_while_opening_the_link_key'.tr,
//         Get.context!,
//         isError: true,
//       );
//     }
//   }
//
//   /// Convert yyyy-MM-dd → 10.12.2025
//   String formatToReadable(String inputDate) {
//     try {
//       final parsedDate = DateTime.parse(inputDate);
//       return DateFormat('dd.MM.yyyy').format(parsedDate);
//     } catch (e) {
//       return inputDate;
//     }
//   }
//
//   /// Converts a hex color string like "#ffff01" to Flutter Color
//   /// If invalid, returns [fallback] color (default: Colors.grey)
//   Color hexToColor(String? hex, {Color fallback = Colors.grey}) {
//     try {
//       if (hex == null || hex.isEmpty) return fallback;
//
//       // Remove '#' if present
//       hex = hex.replaceAll('#', '');
//
//       // Add full opacity if only RRGGBB is provided
//       if (hex.length == 6) hex = 'FF$hex';
//
//       // Parse and return Color
//       return Color(int.parse(hex, radix: 16));
//     } catch (e) {
//       // In case of any error, return fallback color
//       return fallback;
//     }
//   }
//
//   String getPriceTypeIcon(String priceType) {
//     switch (priceType.toUpperCase()) {
//       case "EUR":
//         return "€";
//       case "GBP":
//         return "£";
//       case "DOLLAR":
//       case "USD":
//         return "\$";
//       case "LIRA":
//       case "TRY":
//         return "₺";
//       default:
//         return "";
//     }
//   }
//
//   String getPriceMethodFullName(String? code) {
//     switch (code) {
//       case 'on':
//         return "online_payment_key".tr;
//       case 'na':
//         return "cash_to_driver_key".tr;
//       case 'ba':
//         return "bank_key".tr;
//       default:
//         return "Unknown";
//     }
//   }
//
//   String listToCommaString(List<String>? list) {
//     if (list == null || list.isEmpty) return "-";
//     return list.join(', ');
//   }
// }
//
// class CompleteReservationResult {
//   final bool success;
//   final String message;
//
//   CompleteReservationResult({required this.success, required this.message});
// }
