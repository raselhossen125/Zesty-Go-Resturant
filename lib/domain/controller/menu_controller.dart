import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/dio/base/api_response.dart';
import '../repository/app_menu_repository.dart';

class MyMenuController extends GetxController {
  final MenuRepository menuRepo;
  MyMenuController({required this.menuRepo});

  // Categories Data
  var categoriesList = <DocumentSnapshot>[].obs;
  var isLoading = false.obs;

  // Selection logic
  int selectedCategoryIndex = 0;

  // Image Picker state
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // --- 1. Selection & Index Logic ---
  void setCategoryIndex(int index) {
    selectedCategoryIndex = index;
    update();
  }

  // --- 2. Image Picker Logic ---
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

  // --- 3. Fetch/Read Categories ---
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      update();

      ApiResponse response = await menuRepo.getCategories();

      if (response.response != null && response.response is QuerySnapshot) {
        final snapshot = response.response as QuerySnapshot;
        categoriesList.assignAll(snapshot.docs);
      } else {
        Get.snackbar("Fetch Error", response.error.toString());
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // --- 4. Add Category ---
  Future<void> createCategory(String name, String imageUrl) async {
    if (name.trim().isEmpty) {
      Get.snackbar("Warning", "Please enter menu name");
      return;
    }

    isLoading.value = true;
    update();

    final categoryData = {
      'categoryName': name.trim(),
      'image': {
        'url': imageUrl.trim().isEmpty
            ? "https://placeholder.com/image.png"
            : imageUrl,
        'type': 'url',
      },
      'createdAt': FieldValue.serverTimestamp(),
    };

    ApiResponse response = await menuRepo.addCategory(categoryData);
    if (response.response != null) {
      await fetchCategories();
      clearPickedImage();
      Get.back();
      Get.snackbar("Success", "Category created successfully!");
    } else {
      Get.snackbar("Error", response.error.toString());
    }
    isLoading.value = false;
    update();
  }

  // --- 5. Update Category ---
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

    final categoryData = {
      'categoryName': newName.trim(),
      'image.url': newImageUrl.trim().isEmpty
          ? "https://placeholder.com/image.png"
          : newImageUrl,
    };

    ApiResponse response = await menuRepo.updateCategory(
      categoryId,
      categoryData,
    );
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

  // --- 6. Delete Category ---
  Future<void> removeCategory(String categoryId) async {
    isLoading.value = true;
    update();

    ApiResponse response = await menuRepo.deleteCategory(categoryId);
    if (response.response != null) {
      await fetchCategories();
      Get.back(); // Close confirmation dialog
      Get.snackbar("Deleted", "Category removed successfully");
    } else {
      Get.snackbar("Error", response.error.toString());
    }
    isLoading.value = false;
    update();
  }
}
