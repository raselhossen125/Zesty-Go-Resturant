import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/services/dio/base/api_response.dart';
import '../repository/app_auth_repository.dart';
import '../../presentation/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository authRepo = AuthRepository();

  bool isLoading = false;

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading = true;
      update();

      ApiResponse response = await authRepo.validateCredentials(
        email,
        password,
      );

      if (response.response != null && response.response == true) {
        Get.offAllNamed(RouteName.BOTTOM_NAV_SCREEN);

        Get.snackbar(
          "Welcome Back",
          "Logged in successfully as Zesty Go partner.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Login Failed",
          response.error.toString(),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
