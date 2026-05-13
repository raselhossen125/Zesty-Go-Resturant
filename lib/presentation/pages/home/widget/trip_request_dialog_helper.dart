// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grand_transfers_driver_app/domain/controller/app_reservation_controller.dart';
// import 'package:grand_transfers_driver_app/presentation/common_widget/custom_button.dart';
//
// import '../../../../domain/ui_models/collection_ui_model.dart';
// import '../../../const/app_const_dimensions.dart';
// import '../../../routes/app_routes.dart';
//
// class TripRequestDialog extends StatelessWidget {
//   const TripRequestDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AppReservationController>(
//       builder: (controller) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               Dimensions.RADIUS_OVER_EXTRA_LARGE,
//             ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(
//                 Dimensions.RADIUS_OVER_EXTRA_LARGE,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 // 🔥 Top-Right corner cross button design
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(8), // clean padding
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor.withOpacity(
//                           0.15,
//                         ), // background a lighter tone
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.close, // normal cross icon
//                         size: 16, // small and elegant icon
//                         color: Theme.of(
//                           context,
//                         ).primaryColor, // slightly dark cross color
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // 🔥 content design code
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: Dimensions.FREE_SIZE_EXTRA_LARGE,
//                     ), // cross position fixed
//                     const Icon(
//                       Icons.notifications,
//                       size: 40,
//                       color: Color(0xFF2E3A59),
//                     ),
//                     const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
//                     Text(
//                       'welcome_key'.tr,
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         color: Theme.of(context).primaryColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: Dimensions.FREE_SIZE_SMALL),
//                     Text(
//                       'you_have_new_trip_requests_waiting_for_you_key'.tr,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         color: Theme.of(context).primaryColor.withOpacity(0.8),
//                       ),
//                     ),
//                     const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//
//                     // Dynamic List from Controller
//                     Flexible(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           maxHeight: Get.height * 0.5,
//                         ),
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           itemCount: controller.pendingTrips.length,
//                           separatorBuilder: (_, __) => const SizedBox(
//                             height: Dimensions.FREE_SIZE_LARGE,
//                           ),
//                           itemBuilder: (context, index) {
//                             final trip = controller.pendingTrips[index];
//                             return _buildTripCard(context, controller, trip);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// Widget _buildTripCard(
//   BuildContext context,
//   AppReservationController controller,
//   CollectionUiModel trip,
// ) {
//   return Container(
//     padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
//       boxShadow: [
//         BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
//       ],
//     ),
//     child: Column(
//       children: [
//         Text(
//           "${trip.from} > ${trip.to}",
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           "${controller.formatToReadable(trip.transferDate)} | ${trip.transferHour}",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//             fontWeight: FontWeight.w400,
//             color: Colors.black54,
//             fontSize: Dimensions.FONT_SIZE_SMALL,
//           ),
//         ),
//         const SizedBox(height: 15),
//
//         CustomButton(
//           onPressed: () {
//             final statusType = trip.statusType;
//
//             Get.toNamed(
//               statusType.toLowerCase() == 'delivery' ||
//                       statusType.toLowerCase() == 'pickup'
//                   ? RouteName.EQUIPMENT_DETAILS_SCREEN
//                   : RouteName.COLLECTION_DETAILS_SCREEN,
//               arguments: {
//                 "id": trip.id.toString(),
//                 "type": statusType.toLowerCase(),
//               },
//             )?.then((_) {
//               controller.removeFromPendingTrip(trip: trip);
//             });
//           },
//           buttonText: "view_key".tr,
//           height: 42,
//         ),
//       ],
//     ),
//   );
// }
//
// class TripDialogHelper {
//   static void showTripRequests() {
//     Get.dialog(
//       const TripRequestDialog(),
//       barrierDismissible: false,
//       useSafeArea: true,
//     );
//   }
// }
