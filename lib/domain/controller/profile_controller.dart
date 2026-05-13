import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var name = "ZestyGo".obs;
  var orderCount = 15.obs;

  // Image handling
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      pickedImage = File(image.path);
      update(); // UI update korbe
      Get.back(); // Bottom sheet bondho korbe
    }
  }

  void saveProfile() {
    // Save logic here
    Get.back();
    Get.snackbar("Success", "Profile updated successfully");
  }
}
