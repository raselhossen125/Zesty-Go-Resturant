import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyMenuController extends GetxController {
  final List<String> categories = [
    "Zinger",
    "Veggi",
    "Chicken",
    "Him",
    "Cheese",
    "Pizza",
    "Drinks",
    "Dessert",
  ];

  int selectedCategoryIndex = 0;

  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      pickedImage = File(image.path);
      update(); // UI update korbe preview dekhanor jonno
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    update();
  }
}
