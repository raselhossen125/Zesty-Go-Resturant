import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zesty_go_resturant/domain/controller/app_auth_controller.dart';
import 'package:zesty_go_resturant/domain/controller/dashboard_controller.dart';
import 'package:zesty_go_resturant/domain/controller/order_controller.dart';
import 'package:zesty_go_resturant/domain/controller/profile_controller.dart';
import 'package:zesty_go_resturant/domain/repository/app_auth_repository.dart';
import 'package:zesty_go_resturant/domain/repository/app_menu_repository.dart';
import 'package:zesty_go_resturant/domain/repository/dashboard_repository.dart';
import 'package:zesty_go_resturant/domain/repository/order_repository.dart';
import 'core/app_localizetion_service.dart';
import 'data/services/dio/dio_client.dart';
import 'data/services/dio/logging_interceptor.dart';
import 'data/services/sharedprefarance/local_storage.dart';
import 'domain/controller/bottom_navbar_controller.dart';
import 'domain/controller/menu_controller.dart';

Future<void> init() async {
  await dotenv.load(fileName: "assets/.env");
  final baseUrl = dotenv.env['BASE_URL'];

  await Get.putAsync(() async {
    final service = AppLocalizationService();
    await service.loadTranslations();
    return service;
  });

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => Dio());
  Get.lazyPut(() => LoggingInterceptor());

  Get.lazyPut(
    () => DioClient(
      baseUrl ?? "",
      Get.find<Dio>(),
      loggingInterceptor: Get.find<LoggingInterceptor>(),
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  Get.lazyPut(() => LocalStorageServices(sharedPreferences: Get.find()));

  Get.lazyPut(() => MenuRepository());
  Get.lazyPut(() => AuthRepository());
  Get.lazyPut(() => OrderRepository());
  Get.lazyPut(() => DashboardRepository());

  Get.lazyPut(() => BottomNavbarController());
  Get.lazyPut(() => MyMenuController(menuRepo: Get.find()));
  Get.lazyPut(() => OrderController());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => DashboardController(repo: Get.find()));
}
