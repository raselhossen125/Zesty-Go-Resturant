import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zesty_go_resturant/domain/controller/order_controller.dart';
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
    // This is the crucial line: wait for the files to load!
    await service.loadTranslations();
    return service;
  });

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => Dio());
  Get.lazyPut(() => LoggingInterceptor());

  /// Services

  Get.lazyPut(
    () => DioClient(
      baseUrl ?? "",
      Get.find<Dio>(),
      loggingInterceptor: Get.find<LoggingInterceptor>(),
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  Get.lazyPut(() => LocalStorageServices(sharedPreferences: Get.find()));

  /// Product Data Sources
  // Get.lazyPut(
  //   () => ProductRemoteDataSource(dioClient: Get.find<DioClient>()),
  // );
  // Get.lazyPut(
  //   () => ProductLocalDataSource(localStorageServices: Get.find()),
  // );

  /// Repositories
  // Get.lazyPut<ProductRepository>(
  //   () => ProductRepositoryImpl(
  //     productRemoteDataSource: Get.find<ProductRemoteDataSource>(),
  //     productLocalDataSource: Get.find<ProductLocalDataSource>(),
  //   ),
  // );

  /// Use Cases
  // Get.lazyPut<ProductUseCase>(
  //   () => ProductUseCaseImpl(productRepository: Get.find<ProductRepository>()),
  // );

  /// Controllers
  Get.lazyPut(() => BottomNavbarController());
  Get.lazyPut(() => MyMenuController());
  Get.lazyPut(() => OrderController());
}
