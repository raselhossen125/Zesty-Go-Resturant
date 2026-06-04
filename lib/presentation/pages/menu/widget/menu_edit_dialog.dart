import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/menu_controller.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

void showImagePickerBottomSheet(
  BuildContext context,
  String categoryId,
  String currentTitle,
) {
  final MyMenuController controller = Get.find<MyMenuController>();

  // Controllers
  final TextEditingController nameController = TextEditingController(
    text: currentTitle,
  );

  final TextEditingController imageUrlController = TextEditingController();

  Get.bottomSheet(
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        // Image preview update
        imageUrlController.addListener(() {
          if (context.mounted) {
            setModalState(() {});
          }
        });

        return GetBuilder<MyMenuController>(
          builder: (menuController) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Center(
                      child: Text(
                        "Update Category Menu",
                        style: headline(context),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Image preview
                    Center(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppConstColor.primaryColor.withOpacity(0.15),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: imageUrlController.text.trim().isNotEmpty
                              ? Image.network(
                                  imageUrlController.text.trim(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.broken_image_outlined,
                                        color: Colors.redAccent,
                                        size: 36,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Invalid Image URL Link!",
                                        style: TextStyle(
                                          color: Colors.red[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_search_rounded,
                                      color: Colors.grey[400],
                                      size: 36,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Enter New URL below to preview",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Name
                    CustomTextField(
                      header: "Menu Name ",
                      hintText: "Enter menu name",
                      controller: nameController,
                    ),

                    const SizedBox(height: 16),

                    // Image URL
                    CustomTextField(
                      header: "New Menu Image URL ",
                      hintText: "https://example.com/new-image.jpg",
                      controller: imageUrlController,
                      inputType: TextInputType.url,
                    ),

                    const SizedBox(height: 30),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: menuController.isLoading.value
                            ? null
                            : () {
                                if (nameController.text.trim().isEmpty) {
                                  Get.snackbar(
                                    "Required Field",
                                    "Menu Name cannot be empty",
                                    backgroundColor: Colors.amber,
                                    colorText: Colors.black,
                                  );
                                  return;
                                }

                                if (imageUrlController.text.trim().isEmpty) {
                                  Get.snackbar(
                                    "Required Field",
                                    "Please paste or enter a valid Menu Image URL",
                                    backgroundColor: Colors.amber,
                                    colorText: Colors.black,
                                  );
                                  return;
                                }

                                // Update category
                                menuController.editCategory(
                                  categoryId,
                                  nameController.text.trim(),
                                  imageUrlController.text.trim(),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstColor.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: menuController.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Save Changes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
    isScrollControlled: true,
  );
}
