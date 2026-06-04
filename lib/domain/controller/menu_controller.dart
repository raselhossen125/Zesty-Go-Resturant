import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/dio/base/api_response.dart';
import '../repository/app_menu_repository.dart';

class MyMenuController extends GetxController {
  final MenuRepository menuRepo;
  MyMenuController({required this.menuRepo});

  var categoriesList = <DocumentSnapshot>[].obs;
  var isLoading = false.obs;

  int selectedCategoryIndex = 0;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      pickedImage = File(image.path);
      update();
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    update();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      update();

      final response = await menuRepo.getCategories();

      if (response.response != null && response.response is QuerySnapshot) {
        final snapshot = response.response as QuerySnapshot;
        categoriesList.assignAll(snapshot.docs);
      } else {
        Get.snackbar("Error", response.error.toString());
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> createCategory(String name, String imageUrl) async {
    if (name.trim().isEmpty || imageUrl.trim().isEmpty) {
      Get.snackbar("Warning", "All fields are required");
      return;
    }

    isLoading.value = true;
    update();

    final data = {
      'categoryName': name.trim(),
      'image': {'url': imageUrl.trim(), 'type': 'url'},
      'createdAt': FieldValue.serverTimestamp(),
    };

    final response = await menuRepo.addCategory(data);

    if (response.response != null) {
      await fetchCategories();
      Get.back();
      Get.snackbar("Success", "Category created successfully!");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }

  Future<void> editCategory(
    String categoryId,
    String newName,
    String newImageUrl,
  ) async {
    if (newName.trim().isEmpty) {
      Get.snackbar("Warning", "Name cannot be empty");
      return;
    }

    isLoading.value = true;
    update();

    final data = {
      'categoryName': newName.trim(),
      'image.url': newImageUrl.trim().isEmpty
          ? "https://images.unsplash.com/photo-1568901346375-23c9450c58cd"
          : newImageUrl.trim(),
    };

    final response = await menuRepo.updateCategory(categoryId, data);

    if (response.response != null) {
      await fetchCategories();
      clearPickedImage();
      Get.back();
      Get.snackbar("Success", "Category updated!");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }

  Future<void> removeCategory(String categoryId) async {
    isLoading.value = true;
    update();

    final response = await menuRepo.deleteCategory(categoryId);

    if (response.response != null) {
      await fetchCategories();
      Get.back();
      Get.snackbar("Deleted", "Category removed");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }

  Future<void> createFoodItem({
    required String categoryId,
    required String name,
    required String price,
    required String description,
    required bool isPopular,
    required String finalImageUrl,
  }) async {
    isLoading.value = true;
    update();

    final data = {
      'foodName': name.trim(),
      'price': price.trim(),
      'description': description.trim(),
      'isPopular': isPopular,
      'ratting': 0.0,
      'foodImage': finalImageUrl.trim(),
    };

    final response = await menuRepo.addFoodItem(categoryId, data);

    if (response.response != null) {
      Get.back();
      Get.snackbar("Success", "$name created successfully!");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }

  Future<void> editFoodItem({
    required String categoryId,
    required String foodId,
    required String name,
    required String price,
    required String description,
    required String finalImageUrl,
    required bool isPopular,
  }) async {
    isLoading.value = true;
    update();

    final data = {
      'foodName': name.trim(),
      'price': price.trim(),
      'description': description.trim(),
      'isPopular': isPopular,
      'foodImage': finalImageUrl.trim(),
    };

    final response = await menuRepo.updateFoodItem(categoryId, foodId, data);

    if (response.response != null) {
      Get.snackbar("Success", "$name updated successfully!");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }

  Future<void> deleteFoodItem({
    required String categoryId,
    required String foodId,
  }) async {
    isLoading.value = true;
    update();

    final response = await menuRepo.deleteFoodItem(categoryId, foodId);

    if (response.response != null) {
      Get.snackbar("Deleted", "Food item removed");
    } else {
      Get.snackbar("Error", response.error.toString());
    }

    isLoading.value = false;
    update();
  }
}
