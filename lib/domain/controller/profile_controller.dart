import 'dart:async';
import 'package:get/get.dart';
import '../repository/app_profile_repo.dart';
import '../ui_models/profile_model.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepo = ProfileRepository();
  StreamSubscription? _profileSubscription;

  ProfileModel? profile;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() {
    _profileSubscription?.cancel();

    _profileSubscription = _profileRepo.getProfileStream().listen((data) {
      profile = data;
      update();
    });
  }

  Future<void> saveProfile({
    required String newName,
    required String newPhone,
    required String newEmail,
    required String newLocation,
    required String newImageUrl,
  }) async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      await _profileRepo.updateProfile(
        name: newName,
        phone: newPhone,
        email: newEmail,
        location: newLocation,
        imageUrl: newImageUrl,
      );

      Get.back();
      Get.snackbar("Success", "Profile updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    _profileSubscription?.cancel();
    _profileSubscription = null;
    super.onClose();
  }
}
