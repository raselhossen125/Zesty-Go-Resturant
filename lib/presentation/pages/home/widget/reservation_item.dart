// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grand_transfers_driver_app/domain/controller/app_reservation_controller.dart';
//
// import '../../../common_widget/custom_network_image.dart';
// import '../../../const/app_const_dimensions.dart';
// import '../../../const/app_const_theme.dart';
// import '../../../routes/app_routes.dart';
//
// class ReservationItem extends StatelessWidget {
//   final AppReservationController appReservationController;
//   final TabController tabController;
//   final String id;
//   final String statusType;
//   final String image;
//   final String fullName;
//   final String from;
//   final String to;
//   final String transferDate;
//   final String transferHour;
//   final String delayed;
//   final String reservationCode;
//   final String priceType;
//   final String total;
//   final String uetds;
//   final String color;
//   const ReservationItem({
//     super.key,
//     required this.appReservationController,
//     required this.tabController,
//     required this.id,
//     required this.statusType,
//     required this.image,
//     required this.fullName,
//     required this.from,
//     required this.to,
//     required this.transferDate,
//     required this.transferHour,
//     required this.delayed,
//     required this.reservationCode,
//     required this.priceType,
//     required this.total,
//     required this.uetds,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: tabController.index == 0
//           ? () {
//               Get.toNamed(
//                 statusType.toLowerCase() == 'delivery' ||
//                         statusType.toLowerCase() == 'pickup'
//                     ? RouteName.EQUIPMENT_DETAILS_SCREEN
//                     : RouteName.COLLECTION_DETAILS_SCREEN,
//                 arguments: {"id": id, "type": statusType.toLowerCase()},
//               );
//             }
//           : null,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.grey[200],
//             child: ClipOval(
//               child: SizedBox.expand(
//                 child: CustomNetworkImage(imageUrl: image),
//               ),
//             ),
//           ),
//           const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fullName,
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: Dimensions.PADDING_SIZE_OVER_EXTRA_SMALL / 2,
//                 ),
//                 Text(
//                   "$from > $to",
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                     fontSize: Dimensions.FONT_SIZE_SMALL,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: Dimensions.PADDING_SIZE_OVER_EXTRA_SMALL,
//                 ),
//                 Text(
//                   "${appReservationController.formatToReadable(transferDate)} | $transferHour",
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black54,
//                     fontSize: Dimensions.FONT_SIZE_SMALL,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: Dimensions.PADDING_SIZE_OVER_EXTRA_SMALL,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "${'status_key'.tr} : ",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           color: Colors.black54,
//                           fontSize: Dimensions.FONT_SIZE_SMALL,
//                         ),
//                       ),
//                       TextSpan(
//                         text: "${statusType.toLowerCase()}_key".tr,
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: appReservationController.hexToColor(color),
//                           fontSize: Dimensions.FONT_SIZE_SMALL,
//                         ),
//                       ),
//
//                       if (delayed != '')
//                         TextSpan(
//                           text: " | ${'delayed_key'.tr} : $delayed",
//                           style: Theme.of(context).textTheme.bodyMedium!
//                               .copyWith(
//                                 color: Colors.black54,
//                                 fontSize: Dimensions.FONT_SIZE_SMALL,
//                               ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if ((statusType.toLowerCase() != 'pickup' &&
//                       statusType.toLowerCase() != 'delivery') &&
//                   tabController.index == 0 &&
//                   uetds.isNotEmpty)
//                 InkWell(
//                   onTap: () {
//                     appReservationController.openUETDSLink(url: uetds);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
//                       vertical: Dimensions.PADDING_SIZE_OVER_EXTRA_SMALL + 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppConstColor.primaryColor,
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.RADIUS_DEFAULT,
//                       ),
//                     ),
//                     child: Text(
//                       "UETDS",
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontSize: Dimensions.FONT_SIZE_SMALL,
//                         fontWeight: FontWeight.w600,
//                         color: AppConstColor.textWhiteColor,
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 const SizedBox(height: 25),
//               const SizedBox(height: Dimensions.PADDING_SIZE_OVER_EXTRA_SMALL),
//               Text(
//                 "${appReservationController.getPriceTypeIcon(priceType)}$total",
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: Dimensions.FONT_SIZE_DEFAULT,
//                   fontWeight: FontWeight.w600,
//                   color: AppConstColor.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
